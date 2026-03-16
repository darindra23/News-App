import Foundation

final class LocalArticleDataSource: ArticleDataSourceProtocol {
    func fetchAll() async throws -> [ArticleDTO] {
        try await Task.sleep(for: .seconds(1.5))
        return Self.mockArticles
    }

    func fetch(byId id: String) async throws -> ArticleDTO {
        try await Task.sleep(for: .milliseconds(800))
        guard let article = Self.mockArticles.first(where: { $0.id == id }) else {
            throw DomainError.articleNotFound
        }
        return article
    }

    // MARK: - Mock Data

    private static let mockArticles: [ArticleDTO] = [
        ArticleDTO(
            id: "1",
            title: "Apple Unveils M4 Ultra Chip With Record-Breaking Neural Engine",
            source: "TechCrunch",
            author: "Sarah Mitchell",
            publishedAt: .hoursAgo(1),
            categoryRaw: "Technology",
            summary: "Apple's latest silicon leap brings unprecedented AI performance to the Mac lineup, featuring a 32-core Neural Engine capable of 38 trillion operations per second.",
            content: """
            Apple has officially announced its most powerful chip to date, the M4 Ultra, a silicon marvel that combines two M4 Max dies using the company's proprietary UltraFusion architecture. The new chip delivers jaw-dropping performance metrics that blur the line between consumer hardware and professional workstations.

            At the heart of the M4 Ultra is a 32-core Neural Engine capable of performing 38 trillion operations per second — a 60% improvement over its predecessor. This enables on-device AI tasks that previously required cloud connectivity, from real-time language translation to complex image synthesis.

            The chip ships with up to 192GB of unified memory and boasts a 32-core GPU that demolishes previous benchmarks in creative workflows. Video editors working with 8K ProRes footage reported render times reduced by more than half compared to the M3 Ultra.

            Apple announced the M4 Ultra will debut in the new Mac Pro and Mac Studio, both available for order beginning next month. The company emphasized the chip's efficiency credentials as well — despite its raw power, it consumes 30% less energy than the M3 Ultra under equivalent workloads.

            Industry analysts see this as Apple's response to growing competition from Qualcomm's Snapdragon X and AMD's latest Ryzen chips. "Apple is cementing its position as the gold standard for professional computing," said analyst James Cortez of Wedbush Securities. "The M4 Ultra makes the competition look like they're still catching up."

            Developers at WWDC previewed applications optimized for the chip, including a new version of Final Cut Pro that uses the Neural Engine for automatic color grading and AI-powered audio cleanup.
            """,
            readTimeMinutes: 6,
            reliabilityScore: 92
        ),
        ArticleDTO(
            id: "2",
            title: "OpenAI's GPT-5 Scores Near-Perfect on Medical Licensing Exams",
            source: "MIT Technology Review",
            author: "Dr. Priya Nair",
            publishedAt: .hoursAgo(3),
            categoryRaw: "Technology",
            summary: "OpenAI's flagship model achieves 97% accuracy on the USMLE, raising both excitement and ethical questions about AI's role in healthcare.",
            content: """
            OpenAI's latest flagship model, GPT-5, has achieved a 97% score on the United States Medical Licensing Examination (USMLE), surpassing the average passing rate of licensed physicians and setting a new benchmark for AI in clinical reasoning.

            The results, published in a peer-reviewed study in the New England Journal of Medicine, show GPT-5 outperforming human physicians not just on factual recall but on nuanced clinical judgment — the kind that requires synthesizing ambiguous patient data and weighing risk-benefit tradeoffs.

            "This isn't about replacing doctors," said OpenAI's Chief Medical Advisor, Dr. Rachel Huang. "It's about giving every physician access to a tireless, encyclopedic consultant who can catch things humans might miss at 3am on a 12-hour shift."

            The model also demonstrated proficiency in rare disease diagnosis, correctly identifying conditions from symptom clusters in cases where initial human diagnosis had been delayed by months. In simulated triage scenarios, GPT-5 recommended appropriate escalation 94% of the time.

            However, the study also surfaced important limitations. The model struggled with culturally nuanced patient communication and showed bias toward textbook presentations rather than atypical symptom patterns common in elderly or immunocompromised populations.

            Medical ethicists have urged caution. "The risk is over-reliance," warned Dr. Samuel Okonkwo of Johns Hopkins. "Physicians may defer to AI judgment even when their clinical intuition is correct, simply because the model sounds authoritative." Regulatory bodies including the FDA have begun drafting frameworks for AI medical assistants, with final guidelines expected next year.
            """,
            readTimeMinutes: 7,
            reliabilityScore: 88
        ),
        ArticleDTO(
            id: "3",
            title: "Global Climate Summit Yields Historic Carbon Tax Agreement",
            source: "Reuters",
            author: "Elena Vasquez",
            publishedAt: .hoursAgo(5),
            categoryRaw: "Politics",
            summary: "Delegates from 142 nations signed the Geneva Accord, establishing the world's first universal carbon pricing mechanism with binding enforcement provisions.",
            content: """
            In a landmark diplomatic breakthrough, representatives from 142 nations signed the Geneva Accord on Thursday, establishing the world's first universal carbon pricing mechanism. The agreement sets a minimum carbon tax of $75 per metric ton for developed nations and $40 for emerging economies, with a unified enforcement body backed by trade sanctions.

            Negotiations stretched past midnight on the final day, with the breakthrough coming when the United States and China agreed to a phased implementation schedule that gave major industrial economies a five-year runway before full compliance.

            "Today marks a turning point not just for climate policy but for multilateral cooperation," said UN Secretary-General Amara Diallo. "We have moved from pledges to pricing, from aspiration to accountability."

            The accord includes a $500 billion climate finance mechanism funded by proceeds from carbon revenues, earmarked for adaptation projects in climate-vulnerable nations. Small island states, which had threatened to walk out over inadequate compensation provisions, secured binding commitments for annual payments.

            Reaction at home was mixed for many signatories. In the United States, energy industry groups immediately threatened legal challenges, while environmental organizations hailed it as the most significant climate legislation since the Paris Agreement.

            Economists estimate the carbon pricing floor will add approximately $0.25 per gallon to gasoline prices in participating nations within two years. Offsetting revenue recycling provisions, however, are expected to deliver net-zero or positive fiscal impacts for lower-income households.
            """,
            readTimeMinutes: 8,
            reliabilityScore: 95
        ),
        ArticleDTO(
            id: "4",
            title: "Tesla Reports $12B Quarterly Profit as Cybertruck Demand Surges",
            source: "Bloomberg",
            author: "Marcus Chen",
            publishedAt: .hoursAgo(7),
            categoryRaw: "Business",
            summary: "Tesla's Q1 earnings smashed analyst expectations, driven by record Cybertruck deliveries and a 40% jump in energy storage deployments.",
            content: """
            Tesla reported first-quarter earnings that decisively beat Wall Street expectations, posting a $12 billion net profit on revenues of $27.4 billion. The results were driven by a surge in Cybertruck deliveries and a record quarter for Tesla Energy, its commercial and grid-scale battery division.

            The Cybertruck, initially plagued by production delays and mixed reviews, has found its footing in the commercial fleet market. Tesla announced contracts with three major construction companies and the United States Postal Service, adding 14,000 units to its backlog in a single quarter.

            "We've cracked the fleet code," CEO Elon Musk said during the earnings call. "The Cybertruck's range and payload capacity make it uniquely compelling for commercial buyers who've been skeptical of EVs until now."

            Tesla Energy revenue grew 40% year-over-year, with Megapack deployments reaching 10 GWh for the first time in a single quarter. The division's margins have expanded to rival the automotive segment, providing investors with diversification comfort as EV market competition intensifies.

            Gross margin for automotive reached 21.3%, up from 18.9% last year, as manufacturing efficiencies from the new Gigafactory Texas expansion took hold. The company guided for full-year deliveries of 2.4 million vehicles, slightly above the current analyst consensus.

            Tesla shares rose 9% in after-hours trading following the announcement. The stock has gained 34% year-to-date, making it one of the top performers in the S&P 500 this quarter.
            """,
            readTimeMinutes: 6,
            reliabilityScore: 90
        ),
        ArticleDTO(
            id: "5",
            title: "Mediterranean Diet Cuts Heart Disease Risk by 35%, Study Finds",
            source: "The Lancet",
            author: "Dr. Anna Bergström",
            publishedAt: .hoursAgo(9),
            categoryRaw: "Health",
            summary: "A 20-year longitudinal study involving 85,000 participants confirms that adherence to the Mediterranean diet significantly reduces cardiovascular risk across all age groups.",
            content: """
            A comprehensive 20-year study published in The Lancet has confirmed what nutritionists have long hypothesized: strict adherence to the Mediterranean diet reduces the risk of heart disease by 35% and stroke by 28%, across all demographic groups.

            The research, conducted by the European Heart Health Consortium, tracked 85,000 participants across 14 countries. Participants in the highest adherence quartile — characterized by regular consumption of olive oil, legumes, whole grains, fish, and vegetables — showed dramatically reduced biomarkers for cardiovascular inflammation.

            What distinguishes this study from earlier work is its longitudinal scope and its ability to control for socioeconomic factors, which have historically confounded dietary research. "We followed real people through real lives — job changes, family stress, retirement — and the diet signal remained robust throughout," said lead author Dr. Anna Bergström.

            The study found that even moderate adherence reduced risk by 18%, suggesting that partial adoption of Mediterranean eating patterns has meaningful benefits without requiring full dietary transformation.

            Notably, the protective effect was strongest in women aged 45-65 and in participants with pre-existing hypertension. The researchers hypothesize that polyphenols in olive oil and flavonoids in legumes act synergistically with omega-3 fatty acids from fish to reduce arterial stiffness.

            Health economists estimate that widespread adoption of the Mediterranean diet in Western nations could prevent 2.3 million premature cardiovascular deaths per decade and save healthcare systems over $800 billion in treatment costs.
            """,
            readTimeMinutes: 7,
            reliabilityScore: 97
        ),
        ArticleDTO(
            id: "6",
            title: "NASA Artemis IV Crew Plants Flag on Lunar South Pole",
            source: "NASA / AP",
            author: "James Whitfield",
            publishedAt: .hoursAgo(12),
            categoryRaw: "Science",
            summary: "Astronauts Commander Yuki Tanaka and Mission Specialist Dr. Aisha Osei became the first humans to set foot near the Moon's southern polar region, confirming water ice deposits.",
            content: """
            Commander Yuki Tanaka and Mission Specialist Dr. Aisha Osei stepped onto the lunar surface near Shackleton Crater at 14:27 UTC on Thursday, becoming the fifth and sixth humans to walk on the Moon and the first to do so at the southern polar region.

            Within hours of landing, the crew deployed the PRIME (Polar Resource Ice-Mining Experiment) drill and confirmed the presence of water ice at a concentration of 5.6% by mass — substantially higher than predictions from orbital radar data. The discovery has profound implications for future long-duration missions, as the ice could be converted to drinking water and rocket propellant.

            "Standing here, looking at Earth hanging in the black sky, I understand why every astronaut who came before us said this changes everything," Commander Tanaka said during a live transmission watched by an estimated 1.2 billion people worldwide.

            The mission represents a 12-year journey since the original Artemis program was announced. NASA partnered with the European Space Agency, JAXA, and commercial partners including SpaceX and Blue Origin on the mission architecture.

            The crew will spend 7 days on the surface, conducting geological surveys, deploying a permanent communication relay beacon, and testing life support systems designed for the planned lunar Gateway station.

            NASA Administrator Karen Bridgeman described the mission as "the foundation of humanity's permanent presence beyond Earth." Congressional leaders from both parties issued joint statements of congratulation — a rare bipartisan moment in the current political climate.
            """,
            readTimeMinutes: 7,
            reliabilityScore: 98
        ),
        ArticleDTO(
            id: "7",
            title: "LeBron James Becomes First Player to Score 50,000 Career Points",
            source: "ESPN",
            author: "Kevin Durant Jr.",
            publishedAt: .hoursAgo(14),
            categoryRaw: "Sports",
            summary: "At 41 years old, LeBron James etched his name further into basketball history, surpassing the 50,000-point mark with a mid-range jumper in the third quarter against the Celtics.",
            content: """
            LeBron James made NBA history on Wednesday night, becoming the first player in league history to score 50,000 career points. The milestone came on a characteristic mid-range jumper over Jayson Tatum with 4:12 remaining in the third quarter, stopping the game as teammates, opponents, and a roaring crowd at TD Garden in Boston paid tribute.

            "Fifty thousand. I don't even know how to put that in perspective," James said in the post-game press conference, visibly emotional. "I just wanted to play the game the right way, every night, for as long as my body let me. I didn't think about numbers. The game gave me numbers back."

            At 41 years old, James continues to defy the conventional arc of an NBA career. He is averaging 18.4 points, 7.6 assists, and 6.9 rebounds this season — numbers that would be elite for a player a decade his junior.

            His longevity is attributed to an obsessive approach to physical maintenance. James reportedly invests over $1.5 million annually in his body, employing a personal nutritionist, sleep specialist, cryotherapy team, and biometric monitoring system.

            Tributes poured in from across the sports world. Michael Jordan, in a rare public statement, called James "the greatest to ever play this game." The NBA announced it will retire James's number 23 league-wide upon his eventual retirement.

            The Los Angeles Lakers won the game 118-107, moving them to within 1.5 games of first place in the Western Conference with eight games remaining in the regular season.
            """,
            readTimeMinutes: 6,
            reliabilityScore: 94
        ),
        ArticleDTO(
            id: "8",
            title: "Marvel Reveals Avengers: Twilight Will Conclude the Multiverse Saga",
            source: "Variety",
            author: "Sophia Reeves",
            publishedAt: .hoursAgo(16),
            categoryRaw: "Entertainment",
            summary: "Marvel Studios president Kevin Feige confirmed the Phase 7 finale, teasing the return of original Avengers in a story that will span five hours across two theatrical releases.",
            content: """
            Kevin Feige took the stage at Marvel's Phase 7 presentation to confirm what fans had been speculating about for months: Avengers: Twilight will be split into two films — subtitled "The Fall" and "The End" — releasing six months apart, with the story concluding what Feige called "the greatest narrative experiment in cinema history."

            The announcement brought original Avengers cast members onto the stage, including Robert Downey Jr., Chris Evans, Scarlett Johansson, and Chris Hemsworth, their appearances triggering a standing ovation that lasted nearly three minutes.

            "We promised audiences a beginning, a middle, and an end," Feige said. "Twilight is the end. And it is everything that word implies."

            Plot details remain under strict embargo, but confirmed elements include the Celestials as the primary antagonist force, a storyline involving the collapse of the primary MCU timeline, and the introduction of characters from Marvel's newly acquired properties.

            The films will be directed by the Russo Brothers, returning to the franchise after Avengers: Endgame. They've confirmed the runtime for both parts combined will exceed five hours.

            Financial analysts expect the two-film release strategy to generate over $5 billion in combined box office revenue globally, potentially surpassing Endgame's all-time record. Pre-sale tickets opened Thursday morning and crashed Fandango and AMC's websites within minutes.
            """,
            readTimeMinutes: 5,
            reliabilityScore: 85
        ),
        ArticleDTO(
            id: "9",
            title: "Quantum Computer Breaks RSA-2048 Encryption in 11 Minutes",
            source: "Nature",
            author: "Prof. Liu Wei",
            publishedAt: .hoursAgo(20),
            categoryRaw: "Technology",
            summary: "A team at MIT has demonstrated a 1,000-qubit quantum processor capable of factoring the encryption keys underpinning most of today's internet security, prompting urgent calls for post-quantum migration.",
            content: """
            Researchers at MIT's Center for Quantum Engineering have achieved a cryptographic milestone with enormous security implications: their 1,000-qubit quantum processor successfully factored a 2,048-bit RSA key in just 11 minutes, breaking the encryption standard that protects the majority of internet traffic.

            The achievement, published in Nature, represents a 40-year leap beyond what the quantum computing community believed was achievable with current hardware. Error correction improvements allowed the team to maintain coherence across all 1,000 qubits simultaneously — previously, decoherence had limited practical calculations to dozens of qubits.

            "We didn't set out to break the internet," said lead researcher Prof. Liu Wei. "We set out to understand the theoretical limits of quantum error correction. We were as surprised as anyone by how quickly the cryptography implications followed."

            The implications are staggering. RSA-2048 encryption protects banking transactions, government communications, private messaging, and the backbone of e-commerce globally. While the MIT system remains a laboratory prototype, the demonstration proves the cryptographic threat is no longer theoretical.

            Government cybersecurity agencies in the U.S., EU, and China have issued urgent advisories recommending accelerated migration to post-quantum cryptographic standards, which NIST finalized last year.

            Major technology companies issued statements Thursday. Google announced it has already migrated Gmail's encryption to post-quantum algorithms. Apple confirmed iMessage has been post-quantum compliant since iOS 19. Financial institutions face the most urgent pressure, with regulators expected to mandate migration timelines within months.
            """,
            readTimeMinutes: 8,
            reliabilityScore: 93
        ),
        ArticleDTO(
            id: "10",
            title: "Scientists Announce Breakthrough in Alzheimer's Prevention",
            source: "NEJM",
            author: "Dr. Helena Russo",
            publishedAt: .hoursAgo(24),
            categoryRaw: "Health",
            summary: "A new mRNA-based vaccine targeting amyloid precursors has shown 78% efficacy in preventing Alzheimer's onset in high-risk individuals over a five-year trial.",
            content: """
            A clinical trial involving 12,000 participants has produced the most promising results ever recorded in Alzheimer's prevention research. The mRNA-based vaccine, developed by a joint team at Oxford University and the Karolinska Institute, showed 78% efficacy in preventing the onset of Alzheimer's disease in genetically high-risk individuals over a five-year follow-up period.

            The vaccine works by triggering the immune system to clear amyloid-beta and tau protein aggregates before they accumulate into the plaques and tangles associated with Alzheimer's pathology. Unlike existing treatments that address symptoms after diagnosis, this approach intervenes at the molecular level years before cognitive decline begins.

            "We've always known that prevention was the only truly viable strategy against Alzheimer's," said Dr. Helena Russo, the trial's principal investigator. "This is the first time we've had a tool capable of delivering on that promise at scale."

            The trial's safety profile was strong, with adverse events comparable to standard influenza vaccines. The most common side effect was transient injection-site inflammation reported in 12% of participants.

            Regulatory submissions to the FDA and EMA are expected within six months, with an accelerated approval pathway anticipated given the unmet medical need. Analysts estimate the vaccine could be commercially available by late next year.

            The Alzheimer's Association called the announcement "the most significant development in the field since the disease was first described in 1906," adding that successful deployment could prevent 9 million new cases globally per decade.
            """,
            readTimeMinutes: 7,
            reliabilityScore: 96
        ),
        ArticleDTO(
            id: "11",
            title: "Bitcoin Crosses $250,000 as ETF Inflows Hit Record $8B in a Week",
            source: "CoinDesk",
            author: "Tyler Winklevoss",
            publishedAt: .hoursAgo(28),
            categoryRaw: "Business",
            summary: "Institutional demand via spot Bitcoin ETFs has propelled the cryptocurrency to a new all-time high, with BlackRock's iShares Bitcoin Trust alone attracting $3.2 billion in a single week.",
            content: """
            Bitcoin surged past $250,000 for the first time on Thursday, driven by unprecedented institutional inflows into spot Bitcoin exchange-traded funds. The milestone represents a 150% gain from the beginning of the year, eclipsing the most bullish analyst forecasts from just six months ago.

            BlackRock's iShares Bitcoin Trust attracted $3.2 billion in net inflows in a single week — a record for any ETF product in history. Combined with competing products from Fidelity, Invesco, and VanEck, total weekly inflows across Bitcoin ETFs reached $8.1 billion.

            "What we're witnessing is the institutionalization of Bitcoin as a reserve asset," said Cathie Wood of ARK Invest. "Sovereign wealth funds, pension funds, corporate treasuries — they're all entering simultaneously, and the market is adjusting to reflect scarcity at an institutional scale."

            The U.S. government's decision to add Bitcoin to its strategic reserve earlier this year, alongside gold and foreign currency holdings, is widely credited as the catalyst that removed the final psychological barrier for institutional adoption.

            El Salvador, which made Bitcoin legal tender in 2021, is now sitting on unrealized gains exceeding $4 billion on its sovereign holdings — enough to fund the country's entire national budget for two years.

            Skeptics warn that the speed of appreciation signals speculative excess. JPMorgan's Jamie Dimon, long a Bitcoin critic, acknowledged the institutional momentum but warned of "significant volatility ahead" as leveraged positions in the derivatives market swell.
            """,
            readTimeMinutes: 6,
            reliabilityScore: 79
        ),
        ArticleDTO(
            id: "12",
            title: "France Defeats Brazil 3-2 to Win FIFA World Cup 2026",
            source: "BBC Sport",
            author: "Gary Lineker",
            publishedAt: .hoursAgo(36),
            categoryRaw: "Sports",
            summary: "Kylian Mbappé scored a hat-trick at MetLife Stadium in New Jersey to lead France to their third World Cup title in a pulsating final that went to extra time.",
            content: """
            France are world champions for the third time after an extraordinary 3-2 victory over Brazil in extra time at MetLife Stadium in New Jersey. Kylian Mbappé delivered a performance for the ages, scoring all three of France's goals — his 14th, 15th, and 16th of the tournament — to claim the Golden Boot by a margin of five goals.

            Brazil struck first through Vinicius Jr. in the 18th minute, a searing counter-attack that left the French defense flat-footed. Mbappé levelled before half-time with a signature left-footed curler from 22 yards that gave goalkeeper Alisson no chance.

            The second half was an end-to-end spectacle watched by a record 2.1 billion television viewers globally. Neymar, back from injury and playing his fourth and final World Cup at age 34, drew gasps with a masterful free kick that restored Brazil's lead in the 67th minute.

            Mbappé's penalty in the 84th minute sent the game to extra time. With France beginning to tire, Mbappé found a pocket of space in the 108th minute and unleashed a thunderous strike to seal the title.

            "He is the greatest player on Earth right now," said French manager Didier Deschamps after the match. "Maybe the greatest ever. What he's done in this tournament is beyond human."

            For host nation the United States, the tournament was a commercial and cultural triumph despite early elimination in the Round of 16. Record attendance and broadcasting revenues confirmed soccer's emergence as a top-five sport in the American market.
            """,
            readTimeMinutes: 6,
            reliabilityScore: 96
        ),
        ArticleDTO(
            id: "13",
            title: "Historic Peace Deal Signed Between Israel and Saudi Arabia",
            source: "Al Jazeera / Reuters",
            author: "Fatima Al-Rashid",
            publishedAt: .hoursAgo(42),
            categoryRaw: "Politics",
            summary: "In a White House ceremony, Israeli Prime Minister Cohen and Saudi Crown Prince MBS signed the Abraham Accord Extension, establishing full diplomatic relations and a mutual defense pact.",
            content: """
            In a ceremony in the Rose Garden watched by heads of state from across the Middle East, Israeli Prime Minister David Cohen and Saudi Crown Prince Mohammed bin Salman signed the most significant Middle East peace agreement in a generation, establishing full diplomatic normalization between Israel and Saudi Arabia.

            The agreement, brokered over 18 months of secret negotiations facilitated by the United States, establishes mutual embassies in Jerusalem and Riyadh, a bilateral trade framework expected to generate $50 billion in commerce within five years, and a mutual defense cooperation clause.

            "This is the architecture of a new Middle East," President Johnson said, flanked by both leaders. "A Middle East where prosperity is a more powerful force than grievance."

            The accord includes significant concessions from Israel on Palestinian statehood, including a commitment to a two-state solution timeline and the suspension of West Bank settlement expansion. Palestinian Authority President Abbas endorsed the agreement in a statement that surprised many analysts who had expected rejection.

            Saudi Arabia's religious establishment, historically the most resistant constituency to normalization with Israel, issued a carefully worded endorsement citing the economic development provisions and guarantees of Muslim access to holy sites in Jerusalem.

            Regional reactions ranged from cautious optimism to hostility. Iran condemned the agreement as "a betrayal of the Palestinian cause." Jordan and Egypt, which normalized relations with Israel decades ago, welcomed the accord as a stabilizing development.
            """,
            readTimeMinutes: 8,
            reliabilityScore: 91
        ),
        ArticleDTO(
            id: "14",
            title: "Netflix Hits 400 Million Subscribers as Ad-Supported Tier Explodes",
            source: "Deadline",
            author: "Cynthia Park",
            publishedAt: .daysAgo(2),
            categoryRaw: "Entertainment",
            summary: "Netflix's ad-supported tier now accounts for 45% of new sign-ups globally, with subscriber growth accelerating in Southeast Asia and Sub-Saharan Africa.",
            content: """
            Netflix announced Thursday that it has crossed 400 million global subscribers, adding 22 million in the most recent quarter — nearly double analyst forecasts. The surge was driven almost entirely by the company's ad-supported tier, which at $6.99 per month has opened the streaming service to price-sensitive markets that previously showed negligible penetration.

            The ad tier now accounts for 45% of all new sign-ups globally, with particularly dramatic growth in Southeast Asia, where subscribers grew 180% year-over-year, and Sub-Saharan Africa, where the company's investment in local-language content has paid dividends.

            "We bet on localization, and localization won," said CEO Greg Peters. "When someone in Lagos or Jakarta sees a story about people who look like them, speak like them, navigating recognizable realities — that's when streaming goes from a Western luxury product to something that feels genuinely theirs."

            Netflix's advertising revenue reached $4.2 billion annually, making it one of the top five digital advertising platforms globally in just its second year of operation. The company's ad targeting capabilities, built on viewing data from 400 million subscribers, have attracted premium brands willing to pay CPMs 40% above YouTube's rates.

            Content spending reached $22 billion this year, including a record-breaking $400 million deal with Game of Thrones showrunners David Benioff and D.B. Weiss for a new fantasy saga. The company also announced expansion into live sports, securing UEFA Champions League broadcasting rights for 30 countries beginning next season.
            """,
            readTimeMinutes: 6,
            reliabilityScore: 88
        ),
        ArticleDTO(
            id: "15",
            title: "Gene Therapy Restores Full Vision in 50 Blind Patients",
            source: "Science",
            author: "Dr. Amara Singh",
            publishedAt: .daysAgo(3),
            categoryRaw: "Health",
            summary: "A single injection of a novel AAV gene therapy vector has restored functional vision in 50 patients with inherited retinal dystrophy, with effects sustained at the 3-year mark.",
            content: """
            A gene therapy developed at the University of Pennsylvania's Center for Cellular and Molecular Therapeutics has restored functional vision in 50 patients with inherited retinal dystrophy, with visual improvements sustained at the three-year follow-up mark.

            The therapy uses an adeno-associated viral vector to deliver a corrected copy of the RPE65 gene directly to retinal pigment epithelium cells, which in affected patients lack the enzyme essential for the visual cycle. A single sub-retinal injection delivered under general anesthesia produced measurable functional improvements within 30 days.

            At three years, 44 of 50 patients maintained or improved on their initial visual gains, with 31 patients achieving sufficient acuity to read standard print without assistive technology — an outcome considered impossible under the natural trajectory of their condition.

            "We're talking about people who had adapted to blindness, who had organized their entire lives around it, suddenly being able to see their children's faces for the first time," said lead investigator Dr. Amara Singh, pausing to compose herself during the press conference.

            The FDA has designated the therapy for Priority Review, with a PDUFA date set for later this year. If approved, it would be the third gene therapy approved for a retinal disease and the first to demonstrate such durable outcomes in a diverse patient population.

            The research team is now extending the approach to six additional inherited eye diseases, with Phase 1 trials underway in two. They also reported promising preclinical data suggesting adaptation of the platform for age-related macular degeneration, the leading cause of adult blindness globally.
            """,
            readTimeMinutes: 7,
            reliabilityScore: 97
        ),
        ArticleDTO(
            id: "16",
            title: "Amazon Launches Satellite Internet in 120 New Countries",
            source: "The Verge",
            author: "Casey Newton",
            publishedAt: .daysAgo(4),
            categoryRaw: "Technology",
            summary: "Project Kuiper's constellation is now operational in 120 countries, bringing broadband to 1.8 billion people previously without reliable internet access.",
            content: """
            Amazon's Project Kuiper satellite internet constellation reached full operational status Thursday, with broadband service now available in 120 countries spanning Sub-Saharan Africa, Southeast Asia, Central Asia, and Oceania. The service brings reliable high-speed internet to an estimated 1.8 billion people who previously lacked connectivity.

            The Kuiper constellation, comprising 3,236 low-Earth orbit satellites deployed over 18 months via a combination of Amazon's own launch vehicles and ULA Atlas V rockets, offers download speeds averaging 250 Mbps with latency of 30-40 milliseconds — competitive with terrestrial broadband in developed markets.

            The terminal, priced at $399, is roughly the size of a dinner plate and can be self-installed in minutes without specialist equipment. Amazon is subsidizing the hardware to $99 for households below the poverty line in participating countries through a partnership with the World Bank.

            "Connectivity is infrastructure," said Amazon CEO Andy Jassy. "Every global problem — education access, healthcare delivery, economic opportunity — gets easier to solve when every person on Earth has a reliable internet connection."

            The service launches into direct competition with SpaceX's Starlink, which has operated in a similar market for three years and currently serves 9 million subscribers. Analysts expect a price war as both companies race to capture the addressable market before terrestrial 5G infrastructure catches up in rural areas.

            Governments in eight countries have issued statements welcoming Kuiper's launch, citing anticipated benefits for telemedicine, distance education, and e-government services in remote regions.
            """,
            readTimeMinutes: 6,
            reliabilityScore: 89
        )
    ]
}

// MARK: - Date Helpers

private extension Date {
    static func hoursAgo(_ hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: -hours, to: .now) ?? .now
    }

    static func daysAgo(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: .now) ?? .now
    }
}
