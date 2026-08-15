// ==========================================
// Sonpur Sewa Samiti - Web App State Engine
// ==========================================

// Global App State
const state = {
  lang: 'hi', // Default Hindi
  theme: 'light',
  activeTab: 0,
  activeSubTab: 'calc',
  isScanning: false,
  selectedSampleKey: 'wheat_rust',
  
  shop: {
    nameEn: 'Sonpur Sewa Samiti',
    nameHi: 'सोनपुर सेवा समिति',
    taglineEn: 'Seva • Sahayog • Samarpan (Service • Cooperation • Dedication)',
    taglineHi: 'सेवा • सहयोग • समर्पण (कृषि सहकारिता एवं खाद भंडार)',
    phone: '8269202960',
    addressEn: 'Near UP Gramin Bank, Jethwara, Pratapgarh, Uttar Pradesh 230129',
    addressHi: 'यूपी ग्रामीण बैंक के पास, जेठवारा, प्रतापगढ़, उत्तर प्रदेश 230129',
    callUrl: 'tel:8269202960',
    whatsAppUrl: 'https://wa.me/918269202960?text=Namaste%20Sonpur%20Sewa%20Samiti%2C%20mujhe%20krishi%20sahayata%20chahiye'
  },

  // Shriram Fertilizers & Chemicals Store Inventory
  products: [
    {
      id: 'prod_shriram_urea',
      nameEn: 'Shriram Neem Coated Urea (46% N)',
      nameHi: 'श्रीराम नीम लेपित यूरिया (46% नाइट्रोजन)',
      category: 'fertilizer',
      mrp: 285.0,
      subsidizedPrice: 266.50,
      unitEn: '50 kg Bag',
      unitHi: '50 कि.ग्रा. बोरी',
      inStockCount: 850,
      descriptionEn: 'High efficiency slow-release nitrogen for sustained greening and vegetative branching.',
      descriptionHi: 'श्रीराम फर्टिलाइजर्स का उच्च गुणवत्ता वाला नीम लेपित यूरिया।',
      composition: 'Total Nitrogen (N): 46.0%',
      dosageEn: '45-50 kg per 1 Acre as split top dressing.',
      dosageHi: '45-50 कि.ग्रा. प्रति 1 एकड़ विभाजित मात्रा में।',
    },
    {
      id: 'prod_shriram_dap',
      nameEn: 'Shriram DAP (18:46:0 Di-Ammonium Phosphate)',
      nameHi: 'श्रीराम डीएपी 18:46:0 (डाई अमोनियम फॉस्फेट)',
      category: 'fertilizer',
      mrp: 1550.0,
      subsidizedPrice: 1350.00,
      unitEn: '50 kg Bag',
      unitHi: '50 कि.ग्रा. बोरी',
      inStockCount: 420,
      descriptionEn: 'High purity phosphorus essential for robust root anchorage and early seedling vigor.',
      descriptionHi: 'जड़ विकास व कल्ले फूटने के लिए आवश्यक श्रीराम प्रमाणित डीएपी।',
      composition: 'Nitrogen: 18.0%, P2O5: 46.0%',
      dosageEn: '50 kg per 1 Acre as basal application at sowing.',
      dosageHi: 'बुवाई के समय 50 कि.ग्रा. प्रति 1 एकड़ बेसल डोज में।',
    },
    {
      id: 'prod_shriram_ziva',
      nameEn: 'Shriram Ziva (Mycorrhizal Bio-Fertilizer & Root Booster)',
      nameHi: 'श्रीराम जीवा (माइकोराइजा जैव-उर्वरक)',
      category: 'fertilizer',
      mrp: 550.0,
      subsidizedPrice: 450.00,
      unitEn: '4 kg Pack',
      unitHi: '4 कि.ग्रा. पैकेट',
      inStockCount: 140, // IN STOCK
      descriptionEn: 'Specialized mycorrhizal bio-fertilizer developed by Shriram to multiply root surface area by 300%.',
      descriptionHi: 'जड़ों के जाल को 3 गुना बढ़ाकर मिट्टी से फास्फोरस व सूक्ष्म पोषक तत्वों का अवशोषण कराता है।',
      composition: 'Endo & Ecto Mycorrhizal Spores (1200 IP/gm)',
      dosageEn: '4 kg per 1 Acre mixed with soil or Shriram Urea at tillering.',
      dosageHi: '4 कि.ग्रा. प्रति 1 एकड़ (यूरिया या मिट्टी में मिलाकर कल्ले फूटते समय)।',
    },
    {
      id: 'prod_shriram_energy',
      nameEn: 'Shriram Energy (19:19:19 100% Water Soluble NPK)',
      nameHi: 'श्रीराम एनर्जी (19:19:19 पूर्ण घुलनशील एनपीके)',
      category: 'fertilizer',
      mrp: 350.0,
      subsidizedPrice: 280.00,
      unitEn: '1 kg Pack',
      unitHi: '1 कि.ग्रा. पैकेट',
      inStockCount: 210, // IN STOCK
      descriptionEn: 'Premium 100% spray grade NPK for instant crop vitality and grain luster.',
      descriptionHi: 'पर्णीय छिड़काव हेतु पूर्ण घुलनशील एनपीके टॉनिक जो फसल में तुरंत चमक और हरियाली लाता है।',
      composition: 'N: 19%, P2O5: 19%, K2O: 19% + Trace Elements',
      dosageEn: '1.0 kg in 200 Liters of water per 1 Acre (Foliar spray).',
      dosageHi: '1.0 कि.ग्रा. 200 लीटर पानी में मिलाकर प्रति 1 एकड़ छिड़कें।',
    },
    {
      id: 'prod_shriram_suraksha',
      nameEn: 'Shriram Suraksha (Hexaconazole 5% SC Fungicide)',
      nameHi: 'श्रीराम सुरक्षा (हेक्साकोनाजोल 5% एससी फफूंदनाशक)',
      category: 'pesticide',
      mrp: 620.0,
      subsidizedPrice: 490.00,
      unitEn: '500 ml Bottle',
      unitHi: '500 मिली बोतल',
      inStockCount: 75, // IN STOCK
      descriptionEn: 'Broad spectrum systemic fungicide for rust, sheath blight, and powdery mildew control.',
      descriptionHi: 'गेहूं में पीला रतुआ और धान में शीथ ब्लाइट का संपूर्ण समाधान।',
      composition: 'Hexaconazole 5% SC (Suspension Concentrate)',
      dosageEn: '400 ml in 200 Liters of water per 1 Acre.',
      dosageHi: '400 मिली 200 लीटर पानी में मिलाकर प्रति 1 एकड़।',
    },
    {
      id: 'prod_shriram_polyta',
      nameEn: 'Shriram Polyta (Azoxystrobin + Difenoconazole SC)',
      nameHi: 'श्रीराम पॉलिता (एजोक्सिस्ट्रोबिन + डिफेनोकोनाजोल)',
      category: 'pesticide',
      mrp: 1450.0,
      subsidizedPrice: 1250.00,
      unitEn: '250 ml Bottle',
      unitHi: '250 मिली बोतल',
      inStockCount: 0, // OUT OF STOCK test case
      descriptionEn: 'World-class dual systemic fungicide for complex blight and anthracnose infections.',
      descriptionHi: 'आलू पछेती झुलसा और सब्जियों में फफूंद रोगों पर त्वरित असरदार।',
      composition: 'Azoxystrobin 18.2% + Difenoconazole 11.4% SC',
      dosageEn: '200 ml in 200 Liters of water per 1 Acre.',
      dosageHi: '200 मिली 200 लीटर पानी में मिलाकर प्रति 1 एकड़।',
    },
    {
      id: 'prod_shriram_mahun',
      nameEn: 'Shriram Mahun Nashak (Imidacloprid 17.8% SL)',
      nameHi: 'श्रीराम माहू नाशक (इमिडाक्लोप्रिड 17.8% एसएल)',
      category: 'pesticide',
      mrp: 410.0,
      subsidizedPrice: 320.00,
      unitEn: '250 ml Bottle',
      unitHi: '250 मिली बोतल',
      inStockCount: 120, // IN STOCK
      descriptionEn: 'Systemic insecticide protecting mustard, cotton, and vegetables against sap-sucking aphids and jassids.',
      descriptionHi: 'सरसों के माहू (चेपा कीट) और रस चूसक कीटों का संपूर्ण खात्मा।',
      composition: 'Imidacloprid 17.8% SL',
      dosageEn: '100 ml in 150-200 Liters of water per 1 Acre.',
      dosageHi: '100 मिली 150-200 लीटर पानी में मिलाकर प्रति 1 एकड़।',
    },
  ],

  // Active Crops
  crops: [
    {
      id: 'crop_001',
      nameEn: 'Wheat (HD-2967)',
      nameHi: 'गेहूं (एच.डी. 2967)',
      variety: 'HD-2967 High Yielding',
      fieldSize: 2.5,
      fieldUnit: 'Acre',
      sowingDate: '2026-07-10',
      expectedHarvest: '2026-11-10',
      currentStageEn: 'Tillering & Vegetative Growth',
      currentStageHi: 'कल्ले फूटना एवं वानस्पतिक वृद्धि',
      progress: 0.35,
      daysPassed: 36,
      daysRemaining: 84,
      tasks: [
        { id: 't1', titleEn: 'First Top Dressing of Shriram Urea (45 kg)', titleHi: 'श्रीराम यूरिया का पहला टॉप ड्रेसिंग (45 कि.ग्रा.)', descEn: 'Broadcast urea before light irrigation.', descHi: 'हल्की सिंचाई से पहले यूरिया का छिड़काव करें।', date: '18 Aug', isDone: true },
        { id: 't2', titleEn: 'Apply Shriram Ziva Root Energizer (4 kg/Acre)', titleHi: 'श्रीराम जीवा जड़ पोषक (4 किग्रा/एकड़) डालें', descEn: 'Promotes active tiller branching.', descHi: 'जड़ों के विकास हेतु मिट्टी में मिलाएं।', date: '21 Aug', isDone: false },
        { id: 't3', titleEn: 'Second Crown Root Irrigation', titleHi: 'दूसरी मुख्य जड़ सिंचाई', descEn: 'Maintain adequate moisture.', descHi: 'खेत में पर्याप्त नमी बनाए रखें।', date: '28 Aug', isDone: false }
      ]
    },
    {
      id: 'crop_002',
      nameEn: 'Mustard (Pusa Jai Kisan)',
      nameHi: 'सरसों (पूसा जय किसान)',
      variety: 'Bio-902 / Pusa Jai Kisan',
      fieldSize: 1.5,
      fieldUnit: 'Acre',
      sowingDate: '2026-06-20',
      expectedHarvest: '2026-10-05',
      currentStageEn: 'Pod Formation & Siliqua Filling',
      currentStageHi: 'फलियां बनना एवं दाना भराव',
      progress: 0.65,
      daysPassed: 56,
      daysRemaining: 49,
      tasks: [
        { id: 'tm1', titleEn: 'Aphid Monitoring with Shriram Mahun Nashak', titleHi: 'माहू कीट नियंत्रण हेतु श्रीराम माहू नाशक का छिड़काव', descEn: 'Spray 100ml in 200L water per 1 Acre.', descHi: '100 मिली 200 लीटर पानी में प्रति एकड़ छिड़कें।', date: '17 Aug', isDone: false }
      ]
    }
  ],

  // Gemini Vision Diagnoses Library
  scans: [
    {
      id: 'scan_101',
      cropNameEn: 'Wheat Leaf (Triticum aestivum)',
      cropNameHi: 'गेहूं की पत्ती (Wheat)',
      diseaseNameEn: 'Yellow Rust (Puccinia striiformis)',
      diseaseNameHi: 'पीला रतुआ (येलो रस्ट)',
      confidenceScore: 0.96,
      isHealthy: false,
      symptomsEn: 'Yellow/orange powdery pustules arranged in parallel linear stripes along leaf veins.',
      symptomsHi: 'पत्तियों की शिराओं पर पीले-नारंगी रंग की धारियों के रूप में फफोले दिखना।',
      shriramProductId: 'prod_shriram_suraksha',
      shriramProductName: 'Shriram Suraksha (Hexaconazole 5% SC)',
      dosagePerAcreEn: '400 ml in 200 Liters of water per 1 Acre (Foliar spray)',
      dosagePerAcreHi: '400 मिली 200 लीटर पानी में मिलाकर प्रति 1 एकड़ (पर्णीय छिड़काव)',
      organicRemedyEn: 'Foliar spray of 10% fermented Cow Urine + Neem Seed Kernel Extract (5%).',
      organicRemedyHi: '10% गोमूत्र और 5% नीम निबोली अर्क का घोल बनाकर पर्णीय छिड़काव करें।',
      preventionEn: 'Avoid excess nitrogen fertilizer, use rust-resistant certified seeds.',
      preventionHi: 'अत्यधिक यूरिया से बचें और रोगरोधी प्रमाणित बीज लगाएं।'
    },
    {
      id: 'scan_102',
      cropNameEn: 'Potato Leaf (Solanum tuberosum)',
      cropNameHi: 'आलू की पत्ती (Potato)',
      diseaseNameEn: 'Late Blight (Phytophthora infestans)',
      diseaseNameHi: 'पछेती झुलसा रोग (Late Blight)',
      confidenceScore: 0.94,
      isHealthy: false,
      symptomsEn: 'Dark water-soaked necrotic patches with white fuzzy fungal spores under humid morning mist.',
      symptomsHi: 'पत्तियों पर गीले गहरे भूरे धब्बे तथा पत्ती के नीचे सफेद फफूंद का जाल।',
      shriramProductId: 'prod_shriram_polyta',
      shriramProductName: 'Shriram Polyta (Azoxystrobin + Difenoconazole SC)',
      dosagePerAcreEn: '200 ml in 200 Liters of water per 1 Acre',
      dosagePerAcreHi: '200 मिली 200 लीटर पानी में मिलाकर प्रति 1 एकड़',
      organicRemedyEn: 'Trichoderma viride bio-fungicide @ 1 kg in 100 kg compost per Acre.',
      organicRemedyHi: '1 कि.ग्रा. ट्राइकोडर्मा विरिडी 100 कि.ग्रा. सड़ी गोबर खाद में मिलाकर डालें।',
      preventionEn: 'Crop rotation, avoid overhead irrigation, ensure good field drainage.',
      preventionHi: 'फसल चक्र अपनाएं एवं खेत में जल निकासी की समुचित व्यवस्था रखें।'
    },
    {
      id: 'scan_103',
      cropNameEn: 'Paddy Leaf (Oryza sativa)',
      cropNameHi: 'धान की पत्ती (Paddy / Rice)',
      diseaseNameEn: 'Healthy Vigorous Foliage',
      diseaseNameHi: 'स्वस्थ एवं रोगमुक्त धान पत्ती',
      confidenceScore: 0.98,
      isHealthy: true,
      symptomsEn: 'Optimal chlorophyll index with healthy cellular vigor and no active fungal spot.',
      symptomsHi: 'पत्ती का रंग गहरा हरा व चमकदार है, कोई रोग के लक्षण नहीं मिले।',
      shriramProductId: 'prod_shriram_energy',
      shriramProductName: 'Shriram Energy (19:19:19 100% Water Soluble NPK)',
      dosagePerAcreEn: '1.0 kg in 200 Liters of water per 1 Acre (Foliar spray)',
      dosagePerAcreHi: '1.0 कि.ग्रा. 200 लीटर पानी में मिलाकर प्रति 1 एकड़',
      organicRemedyEn: 'Continue regular Jeevamrit / Panchagavya application for soil vigor.',
      organicRemedyHi: 'मिट्टी की उर्वरता हेतु जीवामृत या पंचगव्य का नियमित प्रयोग जारी रखें।',
      preventionEn: 'Maintain balanced water table and scout weekly for stem borers.',
      preventionHi: 'खेत में पानी का उचित स्तर बनाए रखें।',
    }
  ],

  // Cart
  cart: [],

  // Notices
  notices: [
    {
      id: 'n1',
      titleEn: 'Shriram Urea & DAP Stock Allocation for Rabi Season',
      titleHi: 'श्रीराम यूरिया व डीएपी खाद आवंटन सूचना',
      contentEn: 'Fresh railway rake of 1,200 bags Shriram Neem Coated Urea & Shriram DAP has arrived at Sonpur Sewa Samiti warehouse near UP Gramin Bank, Jethwara. Registered farmers can collect up to 5 bags.',
      contentHi: 'सोनपुर सेवा समिति गोदाम (यूपी ग्रामीण बैंक के पास, जेठवारा, प्रतापगढ़) पर श्रीराम नीम लेपित यूरिया और श्रीराम डीएपी की 1,200 बोरियों की नई खेप उपलब्ध है। किसान भाई KCC कार्ड दिखाकर 5 बोरी प्राप्त करें।',
      date: 'Today, 10:30 AM',
      isUrgent: true
    },
    {
      id: 'n2',
      titleEn: 'Weather Alert: Light Rain Expected in Sonpur Block',
      titleHi: 'मौसम चेतावनी: अगले 48 घंटों में हल्की बारिश व हवा की संभावना',
      contentEn: 'IMD advisory: Light drizzle expected. Farmers should spray Shriram Suraksha only after rain clears.',
      contentHi: 'मौसम विभाग के अनुसार बूंदाबांदी संभव है। किसान भाई बारिश रुकने के बाद ही श्रीराम सुरक्षा का छिड़काव करें।',
      date: 'Yesterday, 04:15 PM',
      isUrgent: true
    }
  ],

  // Farmer Queries
  queries: [
    {
      id: 'q1',
      farmer: 'Ramvilas Yadav (Jethwara)',
      crop: 'Wheat HD-2967',
      questionEn: 'My wheat leaves are turning yellow in patches after first watering. What should I spray?',
      questionHi: 'पहली सिंचाई के बाद गेहूं की पत्तियों में हल्के पीले धब्बे दिख रहे हैं। कौन सी दवा डालें?',
      responseEn: 'Apply Shriram Kranti Zinc (5 kg/Acre) with 45 kg Shriram Urea and Shriram Ziva (4 kg/Acre) for deep greening.',
      responseHi: '45 कि.ग्रा. श्रीराम यूरिया के साथ 5 कि.ग्रा. श्रीराम क्रांति जिंक व 4 कि.ग्रा. श्रीराम जीवा मिलाकर खेत में डालें।',
      isResolved: true,
      expert: 'Dr. S. K. Mishra (Senior Agronomist)'
    },
    {
      id: 'q2',
      farmer: 'Birendra Sharma (Hajipur Road)',
      crop: 'Mustard',
      questionEn: 'Black aphids are sticking to mustard flower buds. Which Shriram medicine is best?',
      questionHi: 'सरसों के फूलों पर काले माहू कीट चिपक रहे हैं। कौन सी श्रीराम दवा का छिड़काव करें?',
      responseEn: null,
      responseHi: null,
      isResolved: false
    }
  ]
};

// ==========================================
// Initialization & Event Listeners
// ==========================================
document.addEventListener('DOMContentLoaded', () => {
  renderActiveScanResult(state.scans[0]);
  renderHistoryList();
  renderCropCalendar();
  runFertilizerCalc();
  renderStoreProducts();
  renderAdminPanel();
  updateLanguageUI();
});

// ==========================================
// Language Switcher Engine
// ==========================================
function toggleLanguage() {
  state.lang = state.lang === 'hi' ? 'en' : 'hi';
  document.getElementById('langBtnText').textContent = state.lang === 'hi' ? 'English' : 'हिंदी';
  updateLanguageUI();
  renderActiveScanResult(state.currentActiveScan || state.scans[0]);
  renderHistoryList();
  renderCropCalendar();
  runFertilizerCalc();
  renderStoreProducts();
  renderAdminPanel();
}

function updateLanguageUI() {
  const isHi = state.lang === 'hi';
  
  // Header
  document.getElementById('appTitle').textContent = isHi ? 'सोनपुर सेवा समिति' : 'Sonpur Sewa Samiti';
  document.getElementById('appSubtitle').textContent = isHi ? 'जेठवारा, प्रतापगढ़ • सेवा • सहयोग • समर्पण' : 'Jethwara, Pratapgarh • Seva • Sahayog • Samarpan';
  
  // Nav
  document.getElementById('navScan').textContent = isHi ? 'रोग जांच (स्कैन)' : 'Scan & Diagnose';
  document.getElementById('navCalendar').textContent = isHi ? 'फसल कैलेंडर' : 'Crop Calendar';
  document.getElementById('navStore').textContent = isHi ? 'खाद व दुकान' : 'Store & Calc';
  document.getElementById('navAdmin').textContent = isHi ? 'समिति प्रबंधन' : 'Admin Panel';

  // Scan Tab
  document.getElementById('txtScanTitle').textContent = isHi ? 'एआई फसल डॉक्टर' : 'AI Plant Doctor';
  document.getElementById('txtScanSubtitle').textContent = isHi ? 'पत्ती स्कैन कर तुरंत पाएं रोग पहचान व श्रीराम फर्टिलाइजर्स का सटीक उपचार' : 'AI disease detection mapped to Shriram Fertilizers & Chemicals';
  document.getElementById('txtSampleTitle').textContent = isHi ? 'उदाहरण पत्ती स्कैन जांचें' : 'Try Sample Leaf Scans';
  document.getElementById('txtOneTap').textContent = isHi ? '1-क्लिक टेस्ट' : '1-Tap Demo';
  document.getElementById('chipWheat').textContent = isHi ? 'गेहूं पीला रतुआ' : 'Wheat Yellow Rust';
  document.getElementById('chipPotato').textContent = isHi ? 'आलू पछेती झुलसा' : 'Potato Late Blight';
  document.getElementById('chipMustard').textContent = isHi ? 'सरसों माहू कीट' : 'Mustard Aphids';
  document.getElementById('chipPaddy').textContent = isHi ? 'स्वस्थ धान पत्ती' : 'Healthy Paddy';
  document.getElementById('txtBtnScan').textContent = isHi ? 'पत्ती स्कैन करें (Gemini AI)' : 'Scan Leaf with Gemini AI';
  document.getElementById('txtBtnGallery').textContent = isHi ? 'गैलरी' : 'Gallery';
  document.getElementById('txtHistoryTitle').textContent = isHi ? 'हालिया जांच रिकॉर्ड' : 'Recent Diagnosis Records';
}

// ==========================================
// Theme Toggler
// ==========================================
function toggleTheme() {
  state.theme = state.theme === 'light' ? 'dark' : 'light';
  document.body.setAttribute('data-theme', state.theme);
  document.getElementById('themeIcon').textContent = state.theme === 'light' ? 'dark_mode' : 'light_mode';
}

// ==========================================
// Tab Switching
// ==========================================
function switchTab(index) {
  state.activeTab = index;
  const tabs = document.querySelectorAll('.tab-view');
  const navItems = document.querySelectorAll('.nav-item');

  tabs.forEach((tab, i) => {
    tab.classList.toggle('active', i === index);
  });

  navItems.forEach((item, i) => {
    item.classList.toggle('active', i === index);
  });
}

function switchSubTab(sub) {
  state.activeSubTab = sub;
  document.getElementById('subTabCalcBtn').classList.toggle('active', sub === 'calc');
  document.getElementById('subTabStoreBtn').classList.toggle('active', sub === 'store');
  document.getElementById('subViewCalc').classList.toggle('active', sub === 'calc');
  document.getElementById('subViewStore').classList.toggle('active', sub === 'store');
}

// ==========================================
// Gemini Vision Leaf Scanner
// ==========================================
function selectSample(key, btn) {
  state.selectedSampleKey = key;
  document.querySelectorAll('.chips-scroll .chip').forEach(c => c.classList.remove('active'));
  btn.classList.add('active');

  const leafIcon = document.getElementById('viewfinderLeafIcon');
  if (key === 'paddy_healthy') {
    leafIcon.textContent = 'eco';
    leafIcon.style.color = 'var(--primary-light-green)';
  } else {
    leafIcon.textContent = 'coronavirus';
    leafIcon.style.color = 'var(--harvest-gold)';
  }
}

function toggleFlash() {
  const btn = document.getElementById('flashBtn');
  btn.classList.toggle('active');
  const icon = btn.querySelector('.material-symbols-rounded');
  icon.textContent = btn.classList.contains('active') ? 'flash_on' : 'flash_off';
}

function runGeminiScan() {
  if (state.isScanning) return;
  state.isScanning = true;

  const card = document.getElementById('viewfinderCard');
  card.classList.add('scanning');
  document.getElementById('scannerStatusLabel').textContent = 'GEMINI VISION ANALYZING';

  setTimeout(() => {
    state.isScanning = false;
    card.classList.remove('scanning');
    document.getElementById('scannerStatusLabel').textContent = 'GEMINI VISION READY';

    let result;
    if (state.selectedSampleKey === 'potato_blight') {
      result = state.scans[1];
    } else if (state.selectedSampleKey === 'paddy_healthy') {
      result = state.scans[2];
    } else {
      result = state.scans[0];
    }

    state.currentActiveScan = result;
    renderActiveScanResult(result);
    showToast(state.lang === 'hi' ? 'Gemini AI: रोग निदान पूर्ण हुआ!' : 'Gemini Vision AI: Diagnosis Complete!');
  }, 1400);
}

function renderActiveScanResult(scan) {
  const isHi = state.lang === 'hi';
  const container = document.getElementById('scanResultContainer');
  
  // Find mapped Shriram product in store inventory
  const liveProduct = state.products.find(p => p.id === scan.shriramProductId) || state.products[0];
  const inStock = liveProduct.inStockCount > 0;

  container.innerHTML = `
    <div class="card mt-14" style="border: 1.5px solid ${scan.isHealthy ? 'var(--primary-light-green)' : 'var(--health-danger)'};">
      <div style="display: flex; justify-content: space-between; align-items: flex-start;">
        <div>
          <span style="font-size: 11px; font-weight: 700; color: var(--primary-green);">${isHi ? scan.cropNameHi : scan.cropNameEn}</span>
          <h3 style="font-size: 17px; font-weight: 900; margin-top: 2px; color: ${scan.isHealthy ? 'var(--health-good)' : 'var(--health-danger)'};">
            ${isHi ? scan.diseaseNameHi : scan.diseaseNameEn}
          </h3>
        </div>
        <span class="badge ${scan.isHealthy ? 'badge-success' : 'badge-danger'}">
          <span class="material-symbols-rounded" style="font-size: 13px;">${scan.isHealthy ? 'check_circle' : 'warning'}</span>
          ${scan.isHealthy ? (isHi ? 'स्वस्थ फसल' : 'Healthy Crop') : (isHi ? 'रोग ग्रसित' : 'Infection Detected')}
        </span>
      </div>

      <!-- Shriram Prescribed Treatment Card -->
      <div class="shriram-card">
        <div class="shriram-header">
          <span class="material-symbols-rounded shriram-icon">verified_user</span>
          <div>
            <h4 class="shriram-name">${isHi ? 'श्रीराम फर्टिलाइजर्स एवं केमिकल्स अनुशंसित उपचार' : 'Shriram Fertilizers & Chemicals Prescription'}</h4>
            <span style="font-size: 10px; color: var(--text-secondary);">${isHi ? 'विशिष्ट उत्पाद एवं 1 एकड़ अनुसार मात्रा' : 'Targeted Product & 1-Acre Dosage'}</span>
          </div>
        </div>

        <strong style="font-size: 14.5px; color: var(--primary-dark-green); display: block;">
          ${isHi ? liveProduct.nameHi : liveProduct.nameEn}
        </strong>
        <p style="font-size: 11px; color: var(--text-secondary); margin-top: 2px;">${liveProduct.composition}</p>

        <!-- 1-Acre Exact Dosage Box -->
        <div class="dosage-box">
          <span class="dosage-label">
            <span class="material-symbols-rounded" style="font-size: 15px;">speed</span>
            ${isHi ? '1 एकड़ खेत हेतु सही मात्रा (1 Acre Dosage):' : 'Exact Dosage per 1 Acre:'}
          </span>
          <p class="dosage-val">${isHi ? scan.dosagePerAcreHi : scan.dosagePerAcreEn}</p>
        </div>

        <!-- Real-time Inventory & Price Checker -->
        <div class="inventory-row">
          <div>
            <span style="font-size: 10.5px; color: var(--text-secondary);">${isHi ? 'सहकारी मूल्य (Price):' : 'Store Price:'}</span>
            <div class="price-subsidized">₹${liveProduct.subsidizedPrice.toFixed(0)} <span style="font-size: 11px; font-weight: 500; color: grey;">/ ${isHi ? liveProduct.unitHi : liveProduct.unitEn}</span></div>
          </div>

          <span class="badge ${inStock ? 'badge-success' : 'badge-danger'}" style="font-size: 11px; padding: 5px 10px;">
            <span class="material-symbols-rounded" style="font-size: 14px;">${inStock ? 'check_circle' : 'cancel'}</span>
            ${inStock ? (isHi ? `उपलब्ध (${liveProduct.inStockCount} पीस)` : `IN STOCK (${liveProduct.inStockCount} left)`) : (isHi ? 'स्टॉक समाप्त (OUT OF STOCK)' : 'OUT OF STOCK')}
          </span>
        </div>

        ${inStock ? `
          <button class="btn-primary w-full mt-10" onclick="addToCart('${liveProduct.id}')">
            <span class="material-symbols-rounded">add_shopping_cart</span>
            ${isHi ? 'यह श्रीराम दवा कार्ट में जोड़ें' : 'Add Shriram Product to Cart'}
          </button>
        ` : `
          <button class="btn-outlined w-full mt-10" disabled style="opacity: 0.6;">
            ${isHi ? 'स्टॉक समाप्त (Out of Stock)' : 'Out of Stock'}
          </button>
        `}
      </div>

      <!-- Symptoms & Organic Advisory -->
      <div style="margin-top: 12px; font-size: 12px; line-height: 1.4;">
        <strong>${isHi ? 'लक्षण:' : 'Symptoms:'}</strong> ${isHi ? scan.symptomsHi : scan.symptomsEn}
      </div>

      <div style="margin-top: 8px; font-size: 12px; line-height: 1.4; color: var(--primary-green);">
        <strong>${isHi ? 'जैविक उपचार:' : 'Organic / Jaivik Remedy:'}</strong> ${isHi ? scan.organicRemedyHi : scan.organicRemedyEn}
      </div>

      <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 14px; padding-top: 10px; border-top: 1px solid var(--border-color);">
        <span style="font-size: 11.5px; font-weight: 800; color: var(--primary-green);">
          <span class="material-symbols-rounded" style="font-size: 14px; vertical-align: middle;">auto_awesome</span>
          ${(scan.confidenceScore * 100).toFixed(0)}% Gemini Match
        </span>
        <button class="btn-primary-sm" onclick="openDiagnosisModal()">
          ${isHi ? 'पूरा विवरण देखें' : 'View Full Details'}
        </button>
      </div>
    </div>
  `;
}

function renderHistoryList() {
  const isHi = state.lang === 'hi';
  const list = document.getElementById('historyList');
  document.getElementById('historyCount').textContent = `${state.scans.length} Records`;

  list.innerHTML = state.scans.map(scan => `
    <div class="card" style="margin-top: 6px; padding: 10px 12px; cursor: pointer;" onclick="renderActiveScanResult(state.scans.find(s => s.id === '${scan.id}'))">
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <div style="display: flex; align-items: center; gap: 10px;">
          <div style="width: 32px; height: 32px; border-radius: 50%; background: ${scan.isHealthy ? 'var(--green-surface)' : '#FFEBEE'}; display: flex; align-items: center; justify-content: center; color: ${scan.isHealthy ? 'var(--primary-green)' : 'var(--health-danger)'};">
            <span class="material-symbols-rounded" style="font-size: 18px;">${scan.isHealthy ? 'eco' : 'coronavirus'}</span>
          </div>
          <div>
            <strong style="font-size: 13px;">${isHi ? scan.diseaseNameHi : scan.diseaseNameEn}</strong>
            <p style="font-size: 11px; color: var(--text-secondary);">${isHi ? scan.cropNameHi : scan.cropNameEn} • ${(scan.confidenceScore * 100).toFixed(0)}% match</p>
          </div>
        </div>
        <span class="material-symbols-rounded" style="color: grey; font-size: 20px;">chevron_right</span>
      </div>
    </div>
  `).join('');
}

// ==========================================
// Crop Calendar
// ==========================================
function renderCropCalendar() {
  const isHi = state.lang === 'hi';
  const chips = document.getElementById('cropSelectorChips');
  chips.innerHTML = state.crops.map((c, i) => `
    <button class="chip ${i === 0 ? 'active' : ''}" onclick="selectCropTab(${i}, this)">
      <span class="material-symbols-rounded">grass</span>
      ${isHi ? c.nameHi : c.nameEn}
    </button>
  `).join('');

  renderActiveCropCard(state.crops[0]);
}

function selectCropTab(index, btn) {
  document.querySelectorAll('#cropSelectorChips .chip').forEach(c => c.classList.remove('active'));
  btn.classList.add('active');
  renderActiveCropCard(state.crops[index]);
}

function renderActiveCropCard(crop) {
  const isHi = state.lang === 'hi';
  const dossier = document.getElementById('cropDossierCard');

  dossier.innerHTML = `
    <div class="card">
      <div style="display: flex; justify-content: space-between; align-items: flex-start;">
        <div>
          <h3 style="font-size: 16px; font-weight: 800;">${isHi ? crop.nameHi : crop.nameEn}</h3>
          <p style="font-size: 11.5px; color: var(--text-secondary);">${crop.fieldSize} ${crop.fieldUnit} • ${crop.variety}</p>
        </div>
        <span class="badge badge-success">${isHi ? 'उत्तम स्वास्थ्य' : 'Healthy Vigor'}</span>
      </div>

      <div style="background: var(--green-surface); padding: 8px 12px; border-radius: 8px; margin-top: 10px; font-size: 12px; font-weight: 800; color: var(--primary-dark-green);">
        ${isHi ? 'वर्तमान चरण' : 'Current Stage'}: ${isHi ? crop.currentStageHi : crop.currentStageEn}
      </div>

      <div style="display: flex; justify-content: space-between; font-size: 11px; font-weight: 700; margin-top: 12px;">
        <span>${crop.daysPassed} ${isHi ? 'दिन बीते' : 'Days Passed'}</span>
        <span style="color: var(--harvest-gold);">${crop.daysRemaining} ${isHi ? 'दिन शेष' : 'Days to Harvest'}</span>
      </div>
      <div style="height: 8px; background: var(--green-surface); border-radius: 4px; overflow: hidden; margin-top: 4px;">
        <div style="width: ${crop.progress * 100}%; height: 100%; background: var(--primary-green);"></div>
      </div>
    </div>
  `;

  // Render Tasks
  const tasksList = document.getElementById('tasksList');
  const doneCount = crop.tasks.filter(t => t.isDone).length;
  document.getElementById('taskDoneCount').textContent = `${doneCount}/${crop.tasks.length} Done`;

  tasksList.innerHTML = crop.tasks.map(t => `
    <div class="card" style="margin-top: 6px; padding: 10px 12px; display: flex; align-items: center; justify-content: space-between;">
      <div style="display: flex; align-items: center; gap: 10px;">
        <input type="checkbox" ${t.isDone ? 'checked' : ''} style="width: 18px; height: 18px; accent-color: var(--primary-green); cursor: pointer;" onchange="toggleTask('${crop.id}', '${t.id}', this.checked)">
        <div>
          <strong style="font-size: 12.5px; ${t.isDone ? 'text-decoration: line-through; opacity: 0.7;' : ''}">${isHi ? t.titleHi : t.titleEn}</strong>
          <p style="font-size: 11px; color: var(--text-secondary);">${isHi ? t.descHi : t.descEn}</p>
        </div>
      </div>
      <span class="badge ${t.isDone ? 'badge-success' : 'badge-warning'}">${t.date}</span>
    </div>
  `).join('');
}

function toggleTask(cropId, taskId, isChecked) {
  const crop = state.crops.find(c => c.id === cropId);
  if (crop) {
    const task = crop.tasks.find(t => t.id === taskId);
    if (task) task.isDone = isChecked;
    renderActiveCropCard(crop);
    showToast(state.lang === 'hi' ? 'कार्य स्थिति अपडेट की गई' : 'Task status updated');
  }
}

// ==========================================
// Scientific Fertilizer Calculator
// ==========================================
function setPresetArea(area) {
  document.getElementById('calcAreaInput').value = area;
  document.querySelectorAll('.presets-row .preset-pill').forEach(p => {
    p.classList.toggle('active', parseFloat(p.textContent) === area);
  });
  runFertilizerCalc();
}

function runFertilizerCalc() {
  const isHi = state.lang === 'hi';
  const cropKey = document.getElementById('calcCropSelect').value;
  const area = parseFloat(document.getElementById('calcAreaInput').value) || 1.0;
  const unit = document.getElementById('calcUnitSelect').value;

  // Convert to Acres (Sonpur regional conversion: 1 Bigha = 0.625 Acre)
  let acres = area;
  if (unit === 'Bigha') acres = area * 0.625;
  if (unit === 'Hectare') acres = area * 2.471;
  if (unit === 'Kattha') acres = area * 0.03125;

  let ureaBags = 0, dapBags = 0, zivaPacks = 0, estimatedCost = 0;

  if (cropKey === 'wheat') {
    dapBags = Math.ceil(acres * 1.1);
    ureaBags = Math.ceil(acres * 2.0);
    zivaPacks = Math.ceil(acres * 1.0);
  } else if (cropKey === 'paddy') {
    dapBags = Math.ceil(acres * 1.0);
    ureaBags = Math.ceil(acres * 1.8);
    zivaPacks = Math.ceil(acres * 1.0);
  } else if (cropKey === 'potato') {
    dapBags = Math.ceil(acres * 2.5);
    ureaBags = Math.ceil(acres * 3.0);
    zivaPacks = Math.ceil(acres * 2.0);
  } else {
    dapBags = Math.ceil(acres * 1.0);
    ureaBags = Math.ceil(acres * 1.5);
    zivaPacks = Math.ceil(acres * 1.0);
  }

  estimatedCost = (ureaBags * 266.50) + (dapBags * 1350.00) + (zivaPacks * 450.00);

  const dossier = document.getElementById('calcResultDossier');
  dossier.innerHTML = `
    <div class="card mt-12" style="border: 1.5px solid var(--primary-light-green);">
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <div>
          <h3 style="font-size: 15px; font-weight: 800; color: var(--primary-dark-green);">
            ${isHi ? 'अनुशंसित श्रीराम खाद मात्रा' : 'Recommended Shriram Fertilizer Dosage'}
          </h3>
          <span style="font-size: 11px; color: var(--text-secondary);">${area} ${unit} (${acres.toFixed(2)} Acres)</span>
        </div>
        <span class="badge badge-warning" style="font-size: 12px; font-weight: 900;">₹${estimatedCost.toFixed(0)} Est.</span>
      </div>

      <div class="kpi-grid mt-10">
        <div class="kpi-card" style="border-left: 4px solid var(--primary-green);">
          <div>
            <p class="kpi-label">श्रीराम नीम लेपित यूरिया</p>
            <h4 class="kpi-val" style="color: var(--primary-green);">${ureaBags} बोरी (50 kg)</h4>
          </div>
        </div>

        <div class="kpi-card" style="border-left: 4px solid #E65100;">
          <div>
            <p class="kpi-label">श्रीराम डीएपी (18:46:0)</p>
            <h4 class="kpi-val" style="color: #E65100;">${dapBags} बोरी (50 kg)</h4>
          </div>
        </div>

        <div class="kpi-card" style="border-left: 4px solid var(--soil-brown);">
          <div>
            <p class="kpi-label">श्रीराम जीवा जड़ पोषक</p>
            <h4 class="kpi-val" style="color: var(--soil-brown);">${zivaPacks} पैकेट (4 kg)</h4>
          </div>
        </div>
      </div>

      <!-- Split Schedule -->
      <div class="dosage-box mt-10">
        <span class="dosage-label"><span class="material-symbols-rounded" style="font-size: 14px;">calendar_today</span> 3-चरण में खाद छिड़काव सारिणी (Split Schedule):</span>
        <p style="font-size: 11.5px; margin-top: 4px;">• <strong>बुवाई पर (Basal):</strong> पूरा ${dapBags} बोरी डीएपी + 1 बोरी यूरिया</p>
        <p style="font-size: 11.5px;">• <strong>पहली सिंचाई (21 दिन):</strong> 1 बोरी यूरिया + ${zivaPacks} पैकेट श्रीराम जीवा</p>
      </div>

      <button class="btn-primary w-full mt-10" onclick="addCalculatedFertilizersToCart(${ureaBags}, ${dapBags}, ${zivaPacks})">
        <span class="material-symbols-rounded">add_shopping_cart</span>
        ${isHi ? 'यह आवश्यक खाद सीधे कार्ट में जोड़ें' : 'Add Calculated Fertilizers to Cart'}
      </button>
    </div>
  `;
}

function addCalculatedFertilizersToCart(urea, dap, ziva) {
  addToCart('prod_shriram_urea', urea);
  addToCart('prod_shriram_dap', dap);
  addToCart('prod_shriram_ziva', ziva);
  showToast(state.lang === 'hi' ? 'अनुशंसित खाद कार्ट में जोड़ दी गई!' : 'Calculated fertilizers added to Cart!');
}

// ==========================================
// Kisan Store
// ==========================================
function renderStoreProducts(filterCat = 'all', search = '') {
  const isHi = state.lang === 'hi';
  const grid = document.getElementById('productsGrid');

  const filtered = state.products.filter(p => {
    const matchCat = filterCat === 'all' || p.category === filterCat;
    const matchSearch = !search || p.nameEn.toLowerCase().includes(search.toLowerCase()) || p.nameHi.includes(search);
    return matchCat && matchSearch;
  });

  grid.innerHTML = filtered.map(p => {
    const inStock = p.inStockCount > 0;
    return `
      <div class="card" style="margin-top: 8px;">
        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
          <div>
            <strong style="font-size: 14px; color: var(--primary-dark-green);">${isHi ? p.nameHi : p.nameEn}</strong>
            <p style="font-size: 11px; color: var(--text-secondary);">${p.composition}</p>
          </div>
          <span class="badge ${inStock ? 'badge-success' : 'badge-danger'}">
            ${inStock ? `${p.inStockCount} ${isHi ? 'उपलब्ध' : 'In Stock'}` : (isHi ? 'स्टॉक समाप्त' : 'Out of Stock')}
          </span>
        </div>

        <p style="font-size: 11.5px; margin-top: 6px;">${isHi ? p.descriptionHi : p.descriptionEn}</p>

        <div class="inventory-row" style="margin-top: 10px; padding-top: 8px; border-top: 1px solid var(--border-color);">
          <div>
            <span class="price-subsidized">₹${p.subsidizedPrice.toFixed(0)}</span>
            <span style="font-size: 11px; color: grey; text-decoration: line-through;">₹${p.mrp.toFixed(0)}</span>
            <span style="font-size: 10.5px; color: grey;">/ ${isHi ? p.unitHi : p.unitEn}</span>
          </div>
          <button class="btn-primary-sm" ${inStock ? '' : 'disabled style="opacity: 0.5;"'} onclick="addToCart('${p.id}')">
            <span class="material-symbols-rounded">shopping_cart</span>
            ${isHi ? 'कार्ट में जोड़ें' : 'Add to Cart'}
          </button>
        </div>
      </div>
    `;
  }).join('');
}

function filterStoreCategory(cat, btn) {
  document.querySelectorAll('#subViewStore .chip').forEach(c => c.classList.remove('active'));
  btn.classList.add('active');
  const search = document.getElementById('storeSearchInput').value;
  renderStoreProducts(cat, search);
}

function filterStoreProducts() {
  const search = document.getElementById('storeSearchInput').value;
  renderStoreProducts('all', search);
}

// ==========================================
// Shopping Cart
// ==========================================
function addToCart(productId, qty = 1) {
  const product = state.products.find(p => p.id === productId);
  if (!product) return;

  const existing = state.cart.find(item => item.product.id === productId);
  if (existing) {
    existing.quantity += qty;
  } else {
    state.cart.push({ product, quantity: qty });
  }

  updateCartBadge();
  showToast(state.lang === 'hi' ? `${product.nameHi} कार्ट में जोड़ा गया!` : `${product.nameEn} added to cart!`);
}

function updateCartBadge() {
  const count = state.cart.reduce((sum, i) => sum + i.quantity, 0);
  const total = state.cart.reduce((sum, i) => sum + (i.product.subsidizedPrice * i.quantity), 0);

  const badge = document.getElementById('navCartBadge');
  const floatingBtn = document.getElementById('floatingCartBtn');

  if (count > 0) {
    badge.textContent = count;
    badge.classList.add('show');
    floatingBtn.style.display = 'flex';
    document.getElementById('floatingCartText').textContent = `${count} ${state.lang === 'hi' ? 'सामग्री' : 'Items'} (₹${total.toFixed(0)})`;
  } else {
    badge.classList.remove('show');
    floatingBtn.style.display = 'none';
  }
}

function openCartModal() {
  const isHi = state.lang === 'hi';
  const modal = document.getElementById('cartModal');
  const body = document.getElementById('cartModalBody');

  const count = state.cart.reduce((sum, i) => sum + i.quantity, 0);
  const total = state.cart.reduce((sum, i) => sum + (i.product.subsidizedPrice * i.quantity), 0);
  const savings = state.cart.reduce((sum, i) => sum + ((i.product.mrp - i.product.subsidizedPrice) * i.quantity), 0);

  body.innerHTML = `
    <div class="modal-header-row">
      <h3 class="modal-title">${isHi ? 'समिति टोकन कार्ट' : 'Co-operative Booking Cart'} (${count})</h3>
      <button class="close-btn" onclick="closeModal('cartModal')"><span class="material-symbols-rounded">close</span></button>
    </div>

    ${state.cart.length === 0 ? `
      <p style="text-align: center; padding: 24px; color: grey;">${isHi ? 'आपकी कार्ट खाली है' : 'Your cart is empty'}</p>
    ` : `
      <div style="margin-top: 10px;">
        ${state.cart.map(item => `
          <div class="card" style="padding: 10px; margin-top: 6px; display: flex; justify-content: space-between; align-items: center;">
            <div>
              <strong style="font-size: 13px;">${isHi ? item.product.nameHi : item.product.nameEn}</strong>
              <p style="font-size: 11px; color: var(--primary-green); font-weight: 700;">₹${item.product.subsidizedPrice.toFixed(0)} x ${item.quantity} = ₹${(item.product.subsidizedPrice * item.quantity).toFixed(0)}</p>
            </div>
            <div style="display: flex; align-items: center; gap: 6px;">
              <button class="btn-stock-adjust" onclick="changeCartQty('${item.product.id}', -1)">-</button>
              <span style="font-weight: 800; font-size: 13px;">${item.quantity}</span>
              <button class="btn-stock-adjust add" onclick="changeCartQty('${item.product.id}', 1)">+</button>
            </div>
          </div>
        `).join('')}

        <!-- Subsidy Savings -->
        <div style="background: var(--harvest-amber-light); border: 1px solid var(--harvest-gold); border-radius: 10px; padding: 10px; margin-top: 12px; font-size: 12px; font-weight: 800; color: #E65100; display: flex; align-items: center; gap: 6px;">
          <span class="material-symbols-rounded">savings</span>
          ${isHi ? `सहकारी अनुदान से आपकी कुल बचत: ₹${savings.toFixed(0)}` : `Total Subsidy Savings: ₹${savings.toFixed(0)}`}
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 14px; font-size: 16px; font-weight: 900;">
          <span>${isHi ? 'कुल देय राशि:' : 'Total Amount:'}</span>
          <span style="color: var(--primary-dark-green);">₹${total.toFixed(0)}</span>
        </div>

        <button class="btn-primary w-full mt-14" onclick="checkoutBooking()">
          <span class="material-symbols-rounded">verified</span>
          ${isHi ? 'सोनपुर समिति केंद्र पर बुक करें' : 'Confirm Booking Token'}
        </button>
      </div>
    `}
  `;

  modal.classList.add('show');
}

function changeCartQty(productId, delta) {
  const item = state.cart.find(i => i.product.id === productId);
  if (item) {
    item.quantity += delta;
    if (item.quantity <= 0) {
      state.cart = state.cart.filter(i => i.product.id !== productId);
    }
  }
  updateCartBadge();
  openCartModal();
}

function checkoutBooking() {
  state.cart.forEach(item => {
    item.product.inStockCount = Math.max(0, item.product.inStockCount - item.quantity);
  });
  state.cart = [];
  updateCartBadge();
  closeModal('cartModal');
  renderStoreProducts();
  renderAdminPanel();
  showToast(state.lang === 'hi' ? 'बुकिंग टोकन जनरेट हुआ! समिति केंद्र से प्राप्त करें।' : 'Booking Token Confirmed! Collect from Samiti center.');
}

// ==========================================
// Admin Panel
// ==========================================
function renderAdminPanel() {
  const isHi = state.lang === 'hi';
  
  const urea = state.products.find(p => p.id === 'prod_shriram_urea')?.inStockCount || 850;
  const dap = state.products.find(p => p.id === 'prod_shriram_dap')?.inStockCount || 420;
  const pending = state.queries.filter(q => !q.isResolved).length;

  document.getElementById('kpiUreaStock').textContent = `${urea}`;
  document.getElementById('kpiDapStock').textContent = `${dap}`;
  document.getElementById('kpiPendingCount').textContent = `${pending}`;
  document.getElementById('stockUreaText').textContent = `${urea} Bags in Warehouse`;
  document.getElementById('stockDapText').textContent = `${dap} Bags in Warehouse`;

  // Render Notices
  const noticesList = document.getElementById('noticesList');
  noticesList.innerHTML = state.notices.map(n => `
    <div class="card" style="margin-top: 6px; padding: 10px 12px;">
      <div style="display: flex; justify-content: space-between;">
        <strong style="font-size: 13px;">${isHi ? n.titleHi : n.titleEn}</strong>
        <span class="badge ${n.isUrgent ? 'badge-danger' : 'badge-success'}">${n.isUrgent ? (isHi ? 'आपातकालीन' : 'Urgent') : 'Info'}</span>
      </div>
      <p style="font-size: 11.5px; margin-top: 4px; color: var(--text-secondary);">${isHi ? n.contentHi : n.contentEn}</p>
      <span style="font-size: 10px; color: grey; margin-top: 6px; display: block;">${n.date}</span>
    </div>
  `).join('');

  // Render Queries
  const queriesList = document.getElementById('queriesList');
  queriesList.innerHTML = state.queries.map(q => `
    <div class="card" style="margin-top: 6px; padding: 10px 12px;">
      <div style="display: flex; justify-content: space-between;">
        <strong style="font-size: 13px;">${q.farmer} • <span style="color: var(--primary-green);">${q.crop}</span></strong>
        <span class="badge ${q.isResolved ? 'badge-success' : 'badge-warning'}">${q.isResolved ? (isHi ? 'समाधान दिया' : 'Resolved') : (isHi ? 'लंबित' : 'Pending')}</span>
      </div>
      <p style="font-size: 12px; margin-top: 4px;">${isHi ? q.questionHi : q.questionEn}</p>
      ${q.isResolved ? `
        <div style="background: var(--green-surface); padding: 8px; border-radius: 6px; margin-top: 8px; font-size: 11.5px;">
          <strong>${q.expert || 'Agronomist'}:</strong> ${isHi ? q.responseHi : q.responseEn}
        </div>
      ` : `
        <button class="btn-primary-sm mt-8" onclick="openResolveModal('${q.id}')">
          <span class="material-symbols-rounded">reply</span>
          ${isHi ? 'सलाह भेजें' : 'Post Advice'}
        </button>
      `}
    </div>
  `).join('');
}

function adjustStock(productId, delta) {
  const p = state.products.find(prod => prod.id === productId);
  if (p) {
    p.inStockCount = Math.max(0, p.inStockCount + delta);
    renderAdminPanel();
    renderStoreProducts();
    showToast(`${p.nameHi} stock: ${p.inStockCount} bags`);
  }
}

// ==========================================
// Modal Helpers
// ==========================================
function openDiagnosisModal() {
  const isHi = state.lang === 'hi';
  const scan = state.currentActiveScan || state.scans[0];
  const liveProduct = state.products.find(p => p.id === scan.shriramProductId) || state.products[0];
  const inStock = liveProduct.inStockCount > 0;

  const body = document.getElementById('diagnosisModalBody');
  body.innerHTML = `
    <div class="modal-header-row">
      <h3 class="modal-title">${isHi ? scan.diseaseNameHi : scan.diseaseNameEn}</h3>
      <button class="close-btn" onclick="closeModal('diagnosisModal')"><span class="material-symbols-rounded">close</span></button>
    </div>

    <div class="dosage-box mt-10">
      <span class="dosage-label">${isHi ? 'श्रीराम फर्टिलाइजर्स 1 एकड़ खुराक:' : 'Shriram 1-Acre Dosage:'}</span>
      <p class="dosage-val">${isHi ? scan.dosagePerAcreHi : scan.dosagePerAcreEn}</p>
    </div>

    <div style="margin-top: 10px; font-size: 12.5px;">
      <strong>${isHi ? 'लक्षण:' : 'Symptoms:'}</strong> ${isHi ? scan.symptomsHi : scan.symptomsEn}
    </div>

    <div style="margin-top: 8px; font-size: 12.5px; color: var(--primary-green);">
      <strong>${isHi ? 'जैविक उपचार:' : 'Organic / Jaivik Remedy:'}</strong> ${isHi ? scan.organicRemedyHi : scan.organicRemedyEn}
    </div>

    <div style="margin-top: 8px; font-size: 12.5px; color: var(--soil-brown);">
      <strong>${isHi ? 'रोकथाम:' : 'Prevention:'}</strong> ${isHi ? scan.preventionHi : scan.preventionEn}
    </div>

    ${inStock ? `
      <button class="btn-primary w-full mt-14" onclick="addToCart('${liveProduct.id}'); closeModal('diagnosisModal');">
        <span class="material-symbols-rounded">add_shopping_cart</span>
        ${isHi ? `यह दवा कार्ट में जोड़ें (₹${liveProduct.subsidizedPrice.toFixed(0)})` : `Add to Cart (₹${liveProduct.subsidizedPrice.toFixed(0)})`}
      </button>
    ` : ''}
  `;

  document.getElementById('diagnosisModal').classList.add('show');
}

function openAddCropModal() {
  document.getElementById('addCropModal').classList.add('show');
}

function submitAddCrop() {
  const type = document.getElementById('modalCropType').value;
  const variety = document.getElementById('modalCropVariety').value || 'HD-2967';
  const size = parseFloat(document.getElementById('modalCropSize').value) || 2.0;
  const unit = document.getElementById('modalCropUnit').value;

  const newCrop = {
    id: `crop_${Date.now()}`,
    nameEn: `${type.toUpperCase()} (${variety})`,
    nameHi: `${type === 'wheat' ? 'गेहूं' : type === 'paddy' ? 'धान' : 'सरसों'} (${variety})`,
    variety,
    fieldSize: size,
    fieldUnit: unit,
    sowingDate: '2026-08-01',
    expectedHarvest: '2026-11-30',
    currentStageEn: 'Germination & Root Settling',
    currentStageHi: 'अंकुरण एवं प्रारंभिक जड़ विकास',
    progress: 0.15,
    daysPassed: 14,
    daysRemaining: 106,
    tasks: [
      { id: `t_${Date.now()}`, titleEn: 'First Light Irrigation', titleHi: 'पहली हल्की सिंचाई', descEn: 'Water seedlings uniformly.', descHi: 'पौधों को हल्की सिंचाई दें।', date: '22 Aug', isDone: false }
    ]
  };

  state.crops.push(newCrop);
  closeModal('addCropModal');
  renderCropCalendar();
  showToast(state.lang === 'hi' ? 'नई फसल सफलतापूर्वक जोड़ी गई!' : 'New crop registered successfully!');
}

function openPublishNoticeModal() {
  document.getElementById('noticeModal').classList.add('show');
}

function submitPublishNotice() {
  const title = document.getElementById('noticeTitleInput').value || 'श्रीराम खाद सूचना';
  const content = document.getElementById('noticeContentInput').value || 'समस्त किसानों को सूचित किया जाता है।';

  state.notices.unshift({
    id: `n_${Date.now()}`,
    titleEn: title,
    titleHi: title,
    contentEn: content,
    contentHi: content,
    date: 'Just now',
    isUrgent: true
  });

  closeModal('noticeModal');
  renderAdminPanel();
  showToast(state.lang === 'hi' ? 'सूचना सभी किसानों को प्रसारित की गई!' : 'Notice broadcasted to all farmers!');
}

function openResolveModal(queryId) {
  state.activeQueryId = queryId;
  const q = state.queries.find(item => item.id === queryId);
  if (q) {
    document.getElementById('resolveQueryPreview').innerHTML = `
      <strong>${q.farmer} (${q.crop}):</strong> ${state.lang === 'hi' ? q.questionHi : q.questionEn}
    `;
    document.getElementById('resolveModal').classList.add('show');
  }
}

function submitResolveQuery() {
  const resp = document.getElementById('resolveResponseInput').value || 'श्रीराम सुरक्षा 400ml/Acre छिड़कें।';
  const q = state.queries.find(item => item.id === state.activeQueryId);
  if (q) {
    q.isResolved = true;
    q.responseEn = resp;
    q.responseHi = resp;
    q.expert = 'Dr. S. K. Mishra (Senior Agronomist, Samiti)';
  }
  closeModal('resolveModal');
  renderAdminPanel();
  showToast(state.lang === 'hi' ? 'परामर्श किसान के प्रोफाइल पर भेजा गया!' : 'Advice sent to farmer profile!');
}

function closeModal(id) {
  document.getElementById(id).classList.remove('show');
}

function showToast(msg) {
  const toast = document.getElementById('toast');
  toast.textContent = msg;
  toast.style.display = 'block';
  setTimeout(() => {
    toast.style.display = 'none';
  }, 2200);
}
