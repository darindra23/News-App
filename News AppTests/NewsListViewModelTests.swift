import Testing
@testable import News_App

@Suite("NewsListViewModel")
@MainActor
struct NewsListViewModelTests {

    // MARK: - loadArticles

    @Test("loadArticles transitions to success state")
    func loadArticlesSuccess() async throws {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture, .fixture2]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)

        await sut.loadArticles()

        guard case .success(let articles) = sut.state else {
            Issue.record("Expected .success state")
            return
        }
        #expect(articles.count == 2)
    }

    @Test("loadArticles transitions to failure state on error")
    func loadArticlesFailure() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedError = DomainError.dataUnavailable
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)

        await sut.loadArticles()

        guard case .failure(let message) = sut.state else {
            Issue.record("Expected .failure state")
            return
        }
        #expect(!message.isEmpty)
    }

    @Test("loadArticles skips reload when already loaded")
    func loadArticlesSkipsWhenAlreadyLoaded() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)

        await sut.loadArticles()

        // Change stub to error — if guard works, state should stay success
        useCase.stubbedError = DomainError.dataUnavailable
        await sut.loadArticles()

        guard case .success(let articles) = sut.state else {
            Issue.record("Expected state to remain .success")
            return
        }
        #expect(articles.count == 1)
    }

    @Test("retry reloads even when already in success state")
    func retryReloadsAlways() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)

        await sut.loadArticles()

        useCase.stubbedArticles = [.fixture, .fixture2]
        await sut.retry()

        guard case .success(let articles) = sut.state else {
            Issue.record("Expected .success state after retry")
            return
        }
        #expect(articles.count == 2)
    }

    // MARK: - Category Filter

    @Test("selectCategory sets selected category")
    func selectCategorySetsCategory() async {
        let sut = NewsListViewModel(fetchArticlesUseCase: MockFetchArticlesUseCase())

        sut.selectCategory(.technology)

        #expect(sut.selectedCategory == .technology)
    }

    @Test("selectCategory toggles off when same category is tapped again")
    func selectCategoryTogglesOff() async {
        let sut = NewsListViewModel(fetchArticlesUseCase: MockFetchArticlesUseCase())

        sut.selectCategory(.technology)
        sut.selectCategory(.technology)

        #expect(sut.selectedCategory == nil)
    }

    @Test("clearCategoryFilter removes selected category")
    func clearCategoryFilterClearsSelection() async {
        let sut = NewsListViewModel(fetchArticlesUseCase: MockFetchArticlesUseCase())
        sut.selectCategory(.sports)

        sut.clearCategoryFilter()

        #expect(sut.selectedCategory == nil)
    }

    // MARK: - Filtered Articles

    @Test("filteredArticles returns all articles when no filter is set")
    func filteredArticlesReturnsAll() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture, .fixture2]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)
        await sut.loadArticles()

        #expect(sut.filteredArticles.count == 2)
    }

    @Test("filteredArticles filters by selected category")
    func filteredArticlesFiltersByCategory() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture, .fixture2]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)
        await sut.loadArticles()

        sut.selectCategory(.technology)

        #expect(sut.filteredArticles.count == 1)
        #expect(sut.filteredArticles[0].category == .technology)
    }

    @Test("filteredArticles filters by search text on title")
    func filteredArticlesFiltersByTitle() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture, .fixture2]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)
        await sut.loadArticles()

        sut.searchText = "Another"

        #expect(sut.filteredArticles.count == 1)
        #expect(sut.filteredArticles[0].id == Article.fixture2.id)
    }

    @Test("filteredArticles filters by search text on source")
    func filteredArticlesFiltersBySource() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture, .fixture2]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)
        await sut.loadArticles()

        sut.searchText = "Test Source"

        #expect(sut.filteredArticles.count == 1)
        #expect(sut.filteredArticles[0].id == Article.fixture.id)
    }

    @Test("filteredArticles returns empty when no match found")
    func filteredArticlesReturnsEmpty() async {
        let useCase = MockFetchArticlesUseCase()
        useCase.stubbedArticles = [.fixture, .fixture2]
        let sut = NewsListViewModel(fetchArticlesUseCase: useCase)
        await sut.loadArticles()

        sut.searchText = "zzz-no-match"

        #expect(sut.filteredArticles.isEmpty)
    }

}
