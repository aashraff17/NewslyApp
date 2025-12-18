import '../model/article_model.dart';

final Map<String, List<Article>> mockNews = {
  'sports': [
    Article(
      url: 'https://newsly.fake/sports/champions-league',
      title: 'Champions League Final: Underdogs Secure Historic Victory',
      description: 'Against all odds, the visiting team clinched a 2-1 victory in injury time, ending a 20-year drought for the prestigious trophy.',
      imageUrl: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=800',
    ),
    Article(
      url: 'https://newsly.fake/sports/olympics-prep',
      title: 'Olympic Preparation: Athletes Arrive at the New High-Tech Village',
      description: 'The upcoming summer games promise sustainability with carbon-neutral housing and AI-driven training facilities for world-class athletes.',
      imageUrl: 'https://images.unsplash.com/photo-1461891263873-d81ff14f001c?w=800',
    ),
    Article(
      url: 'https://newsly.fake/sports/tennis-open',
      title: 'Tennis Open: Record-Breaking Heat Challenges Top Seeds',
      description: 'As temperatures soar on the court, tournament officials implement extreme weather protocols to protect players and fans alike.',
      imageUrl: 'https://images.unsplash.com/photo-1595435066359-62b6382aa78d?w=800',
    ),
    Article(
      url: 'https://newsly.fake/sports/f1-innovation',
      title: 'Formula 1: The New Era of Sustainable Bio-Fuels',
      description: 'Formula 1 introduces a 100% sustainable fuel standard for the next season, aiming to revolutionize the automotive industry.',
      imageUrl: 'https://images.unsplash.com/photo-1532906644359-4835275e1ee3?w=800',
    ),
  ],

  'nation': [ // Politics
    Article(
      url: 'https://newsly.fake/politics/election-reform',
      title: 'National Assembly Passes Landmark Voting Rights Reform',
      description: 'The new legislation aims to streamline the voting process while introducing advanced digital verification to enhance security.',
      imageUrl: 'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=800',
    ),
    Article(
      url: 'https://newsly.fake/politics/summit',
      title: 'G7 Summit: Leaders Agree on Global Minimum Tax Rate',
      description: 'A historic agreement was reached today to prevent multinational corporations from shifting profits to low-tax jurisdictions.',
      imageUrl: 'https://images.unsplash.com/photo-1523995442743-7ee597c7b4ba?w=800',
    ),
    Article(
      url: 'https://newsly.fake/politics/city-planning',
      title: 'Urban Transformation: Smart Cities Bill Greenlit by Senate',
      description: 'Billions are allocated to transform aging infrastructure into interconnected smart grids for better energy and traffic management.',
      imageUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800',
    ),
    Article(
      url: 'https://newsly.fake/politics/diplomacy',
      title: 'Diplomatic Accord Signed to Restore Open Borders',
      description: 'After years of tension, neighboring nations have signed a peace treaty allowing for the free flow of trade and citizens.',
      imageUrl: 'https://images.unsplash.com/photo-1577412647305-991150c7d163?w=800',
    ),
  ],

  'business': [
    Article(
      url: 'https://newsly.fake/business/tech-merger',
      title: 'Tech Giant Acquires Semiconductor Startup for \$40 Billion',
      description: 'The massive merger is set to reshape the hardware industry and accelerate the development of next-generation AI processors.',
      imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800',
    ),
    Article(
      url: 'https://newsly.fake/business/crypto-regulation',
      title: 'Central Bank Issues Guidelines for Digital Currency Integration',
      description: 'A move toward a "Digital Dollar" gains momentum as regulatory frameworks are established to protect retail investors.',
      imageUrl: 'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?w=800',
    ),
    Article(
      url: 'https://newsly.fake/business/green-energy',
      title: 'Renewable Energy Stocks Reach All-Time Highs',
      description: 'Investors pivot away from fossil fuels as breakthroughs in battery storage make solar and wind more profitable than ever.',
      imageUrl: 'https://images.unsplash.com/photo-1466611653911-954ffaa1376b?w=800',
    ),
    Article(
      url: 'https://newsly.fake/business/remote-work',
      title: 'The Shift: Why 60% of Fortune 500 Companies are Adopting Hybrid Models',
      description: 'Recent data shows productivity gains and reduced overhead are driving a permanent change in how global businesses operate.',
      imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
    ),
  ],

  'technology': [
    Article(
      url: 'https://newsly.fake/tech/quantum-computing',
      title: 'Quantum Leap: 1000-Qubit Processor Solves Complex Physics Problem',
      description: 'Researchers achieved what was previously thought impossible, opening the door to revolutionary medicine and material science.',
      imageUrl: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800',
    ),
    Article(
      url: 'https://newsly.fake/tech/ai-creative',
      title: 'Generative AI: The Future of Professional Cinematic Production',
      description: 'New AI models can now assist in lighting, rendering, and even dialogue drafting, cutting production times by half.',
      imageUrl: 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800',
    ),
    Article(
      url: 'https://newsly.fake/tech/smart-home',
      title: 'The Matter Standard: How Smart Home Privacy Just Got Better',
      description: 'Universal device standards are finally here, ensuring your smart devices work together without compromising your personal data.',
      imageUrl: 'https://images.unsplash.com/photo-1558002038-1055907df827?w=800',
    ),
    Article(
      url: 'https://newsly.fake/tech/space-telescope',
      title: 'James Webb Update: First Images of Atmospheric Water on Exoplanet',
      description: 'Data from the deep-space telescope suggests a "super-Earth" 40 light-years away may possess a cloud-forming atmosphere.',
      imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800',
    ),
  ],

  'health': [
    Article(
      url: 'https://newsly.fake/health/personalized-medicine',
      title: 'The Era of Precision: AI-Driven Personalized Cancer Treatments',
      description: 'New clinical trials show a 30% increase in efficacy when treatment plans are customized using genomic sequencing and AI.',
      imageUrl: 'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?w=800',
    ),
    Article(
      url: 'https://newsly.fake/health/mental-wellness',
      title: 'Workplace Burnout: The New Strategy for Employee Mental Health',
      description: 'Top tech firms are implementing mandatory "Digital Detox" weeks to combat the rising tide of cognitive exhaustion.',
      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800',
    ),
    Article(
      url: 'https://newsly.fake/health/nutrition-science',
      title: 'Gut Health: How the Microbiome Affects Daily Energy Levels',
      description: 'Scientific studies confirm that a diverse gut microbiome is the secret to long-term immune strength and mental clarity.',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
    ),
    Article(
      url: 'https://newsly.fake/health/fitness-tech',
      title: 'Wearable Tech: New Sensor Monitors Real-Time Hydration',
      description: 'A non-invasive patch can now tell you exactly when you need electrolytes during intense physical activity.',
      imageUrl: 'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?w=800',
    ),
  ],

  'entertainment': [
    Article(
      url: 'https://newsly.fake/ent/oscars-buzz',
      title: 'Indie Film Shocks Critics with Record-Breaking Award Season',
      description: 'Shot on a shoestring budget, this experimental drama has become the front-runner for Best Picture this year.',
      imageUrl: 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=800',
    ),
    Article(
      url: 'https://newsly.fake/ent/streaming-wars',
      title: 'Streaming Pivot: Major Studio Announces Return to Theatrical Only',
      description: 'In a bold move, "The Cinema First" initiative aims to restore the big-screen experience for all blockbuster releases.',
      imageUrl: 'https://images.unsplash.com/photo-1524712245354-2c4e5e7124c1?w=800',
    ),
    Article(
      url: 'https://newsly.fake/ent/music-revival',
      title: 'Vinyl Surge: Record Sales Outpace Digital Downloads for Third Year',
      description: 'Collectors and Gen Z alike are driving a massive resurgence in physical media, seeking a "tangible connection" to music.',
      imageUrl: 'https://images.unsplash.com/photo-1603048588665-791ca8aea617?w=800',
    ),
    Article(
      url: 'https://newsly.fake/ent/gaming-future',
      title: 'VR Revolution: The First Full-Immersion RPG Hits the Market',
      description: 'With haptic suits and 8K resolution, the latest VR release blurring the lines between reality and gaming.',
      imageUrl: 'https://images.unsplash.com/photo-1622979135225-d2ba269cf1ac?w=800',
    ),
  ],

  'science': [
    Article(
      url: 'https://newsly.fake/sci/fusion-energy',
      title: 'Nuclear Fusion: Commercial Power Plants Could be Ready by 2035',
      description: 'Scientists at the National Ignition Facility have achieved sustainable net energy gain for the third consecutive time.',
      imageUrl: 'https://images.unsplash.com/photo-1532187863486-abf9d39d6618?w=800',
    ),
    Article(
      url: 'https://newsly.fake/sci/ancient-civilization',
      title: 'LiDAR Mapping Reveals Hidden Mayan Megacity in Guatemala',
      description: 'Advanced laser technology has pierced through thick jungle canopy to reveal over 60,000 previously unknown structures.',
      imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800',
    ),
    Article(
      url: 'https://newsly.fake/sci/ocean-exploration',
      title: 'Deep Sea Discovery: New Species Found Near Hydrothermal Vents',
      description: 'Autonomous drones have captured footage of bioluminescent life that survives under crushing pressure and extreme heat.',
      imageUrl: 'https://images.unsplash.com/photo-1551244072-5d12893278ab?w=800',
    ),
    Article(
      url: 'https://newsly.fake/sci/climate-tech',
      title: 'Carbon Capture: The Massive Fans Cleaning the Atmosphere',
      description: 'A new facility in Iceland is successfully removing 36,000 tons of CO2 per year directly from the air.',
      imageUrl: 'https://images.unsplash.com/photo-1532601224476-15c79f2f7a51?w=800',
    ),
  ],

  'world': [
    Article(
      url: 'https://newsly.fake/world/green-treaty',
      title: 'Global Green Pact: 150 Nations Commit to Biodiversity Protection',
      description: 'The historic treaty aims to protect 30% of the Earth\'s land and water by 2030 to prevent ecosystem collapse.',
      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
    ),
    Article(
      url: 'https://newsly.fake/world/refugee-aid',
      title: 'Crisis Response: UN Deploys AI to Optimize Refugee Aid Distribution',
      description: 'Real-time logistics monitoring ensures that food, medicine, and clean water reach those in need within 24 hours of arrival.',
      imageUrl: 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=800',
    ),
    Article(
      url: 'https://newsly.fake/world/cultural-heritage',
      title: 'Digital Preservation: AI Reconstructs Lost Heritage Sites in 3D',
      description: 'Virtual Reality tours are now allowing people to visit historical landmarks that were destroyed by time and conflict.',
      imageUrl: 'https://images.unsplash.com/photo-1503917988258-f19a78a44283?w=800',
    ),
    Article(
      url: 'https://newsly.fake/world/sustainable-shipping',
      title: 'Maritime Shift: World\'s First Electric Cargo Ship Sets Sail',
      description: 'Reducing emissions in global trade, the zero-emission vessel completes its first cross-Atlantic journey successfully.',
      imageUrl: 'https://images.unsplash.com/photo-1494412519320-aa613dfb7738?w=800',
    ),
  ],
};