// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PriceMate';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get started';

  @override
  String get cancel => 'Cancel';

  @override
  String get retry => 'Try again';

  @override
  String get onboardingTitle1 => 'Scan and compare';

  @override
  String get onboardingBody1 =>
      'Scan any product and instantly see which supermarket in Oman sells it cheapest.';

  @override
  String get onboardingTitle2 => 'Share prices, earn points';

  @override
  String get onboardingBody2 =>
      'Spotted a price? Add it in seconds. Every report helps your neighbours and earns you points.';

  @override
  String get onboardingTitle3 => 'Save on every shop';

  @override
  String get onboardingBody3 =>
      'Build a shopping list and we\'ll find the cheapest store for your whole basket.';

  @override
  String get onboardingSetupTitle => 'Set up your app';

  @override
  String get onboardingSetupBody =>
      'Pick your city and language. You can change them later in Settings.';

  @override
  String get city => 'City';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'Device language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get signInTitle => 'Welcome to PriceMate';

  @override
  String get signInSubtitle =>
      'Free, community-powered grocery prices across Oman.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithPhone => 'Continue with phone number';

  @override
  String get continueAsGuest => 'Browse as guest';

  @override
  String get signInGuestHint =>
      'You can browse without an account. Sign in later to add prices and earn points.';

  @override
  String get phoneSignInTitle => 'Sign in with your phone';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get phoneNumberHint => '9X XXX XXX';

  @override
  String get sendCode => 'Send code';

  @override
  String get enterCodeTitle => 'Enter the code';

  @override
  String enterCodeBody(String phone) {
    return 'We sent a 6-digit code to $phone.';
  }

  @override
  String get verificationCode => 'Verification code';

  @override
  String get verify => 'Verify';

  @override
  String get changeNumber => 'Change number';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNetwork =>
      'No internet connection. Check your signal and try again.';

  @override
  String get errorInvalidPhone => 'That phone number doesn\'t look right.';

  @override
  String get errorInvalidCode => 'That code is incorrect or has expired.';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Please wait a few minutes and try again.';

  @override
  String get errorAccountDisabled => 'This account has been disabled.';

  @override
  String get errorSignInRequired => 'Please sign in to continue.';

  @override
  String get errorFieldRequired => 'This field is required';

  @override
  String get homeTitle => 'Home';

  @override
  String get homePlaceholder =>
      'Product search and deals are coming in the next phase.';

  @override
  String welcomeUser(String name) {
    return 'Hello, $name';
  }

  @override
  String get guest => 'Guest';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInPrompt => 'Sign in';

  @override
  String get firebaseSetupTitle => 'Firebase isn\'t configured yet';

  @override
  String get firebaseSetupBody =>
      'Run `flutterfire configure` in the project folder, then restart the app.';

  @override
  String get cityMuscat => 'Muscat';

  @override
  String get citySeeb => 'Seeb';

  @override
  String get cityBawshar => 'Bawshar';

  @override
  String get cityMuttrah => 'Muttrah';

  @override
  String get cityBarka => 'Barka';

  @override
  String get citySohar => 'Sohar';

  @override
  String get citySalalah => 'Salalah';

  @override
  String get cityNizwa => 'Nizwa';

  @override
  String get citySur => 'Sur';

  @override
  String get cityIbri => 'Ibri';

  @override
  String get cityRustaq => 'Rustaq';

  @override
  String get cityBuraimi => 'Buraimi';

  @override
  String get cityKhasab => 'Khasab';

  @override
  String get catFruitsVegetables => 'Fruits & Vegetables';

  @override
  String get catDairyEggs => 'Dairy & Eggs';

  @override
  String get catMeatFish => 'Meat & Fish';

  @override
  String get catBakery => 'Bakery';

  @override
  String get catRiceGrains => 'Rice & Grains';

  @override
  String get catOilGhee => 'Oil & Ghee';

  @override
  String get catBeverages => 'Beverages';

  @override
  String get catSnacks => 'Snacks';

  @override
  String get catBabyCare => 'Baby Care';

  @override
  String get catCleaning => 'Cleaning';

  @override
  String get catPersonalCare => 'Personal Care';

  @override
  String get catFrozen => 'Frozen';

  @override
  String get searchHint => 'Search products (English or Arabic)';

  @override
  String get searchPrompt => 'Type at least 2 letters to search.';

  @override
  String noSearchResults(String query) {
    return 'No products found for \"$query\". Can\'t find it? Scan its barcode to add it.';
  }

  @override
  String get scanBarcode => 'Scan barcode';

  @override
  String get scanHint => 'Point the camera at a barcode';

  @override
  String get toggleFlash => 'Toggle flash';

  @override
  String get cameraUnavailable =>
      'Camera isn\'t available. Allow camera access in your phone settings and try again.';

  @override
  String get recentlyUpdated => 'Recently updated prices';

  @override
  String get noPricesYet =>
      'No prices yet — be the first to add one and earn 10 points!';

  @override
  String get noPricesShort => 'No prices';

  @override
  String get noProductsInCategory => 'No products in this category yet.';

  @override
  String get fromPrice => 'From';

  @override
  String get newProductTitle => 'New product';

  @override
  String get signInToAddProduct => 'Sign in to add a product and earn points.';

  @override
  String get barcode => 'Barcode';

  @override
  String get productName => 'Product name';

  @override
  String get productNameAr => 'Name in Arabic (optional)';

  @override
  String get brand => 'Brand (optional)';

  @override
  String get size => 'Size (optional)';

  @override
  String get sizeHint => 'e.g. 1 kg, 500 ml, 6 x 200 ml';

  @override
  String get category => 'Category';

  @override
  String get saveProduct => 'Save product';

  @override
  String get productNotFound => 'This product no longer exists.';

  @override
  String get pricesTitle => 'Prices';

  @override
  String get cheapest => 'Cheapest';

  @override
  String get verified => 'Verified';

  @override
  String get offer => 'Offer';

  @override
  String offerUntil(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Offer until $dateString';
  }

  @override
  String distanceKm(String km) {
    return '$km km away';
  }

  @override
  String updatedAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Updated $days days ago',
      one: 'Updated yesterday',
      zero: 'Updated today',
    );
    return '$_temp0';
  }

  @override
  String confirmationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count confirmations',
      one: '1 confirmation',
      zero: 'No confirmations',
    );
    return '$_temp0';
  }

  @override
  String get unitKg => 'kg';

  @override
  String get unitLitre => 'litre';

  @override
  String get unitPiece => 'piece';

  @override
  String get errorDuplicatePrice =>
      'You already reported this product at this store in the last 6 hours.';

  @override
  String get errorDailyLimit =>
      'You\'ve reached today\'s limit of 50 prices. Come back tomorrow!';

  @override
  String get errorActionNotAllowed =>
      'That isn\'t allowed. You may have already confirmed or reported this price, or it\'s your own.';

  @override
  String get chooseStore => 'Choose a store';

  @override
  String get noStoresFound =>
      'No stores found nearby. Add the branch you\'re in.';

  @override
  String get addBranch => 'Add a branch';

  @override
  String get addBranchHint =>
      'Add the store you\'re standing in. We\'ll use your current location for its pin.';

  @override
  String get chain => 'Store chain';

  @override
  String get branchName => 'Branch name';

  @override
  String get areaOptional => 'Area (optional)';

  @override
  String get locationNeededForBranch =>
      'Turn on location so we can pin this branch on the map.';

  @override
  String get signInToAddBranch => 'Sign in to add a branch.';

  @override
  String get addPrice => 'Add price';

  @override
  String get addPriceTitle => 'Add a price';

  @override
  String get signInToAddPrice => 'Sign in to add prices and earn points.';

  @override
  String get change => 'Change';

  @override
  String get thisIsAnOffer => 'This is an offer';

  @override
  String get offerEndDateOptional => 'Offer end date (optional)';

  @override
  String get photoOfPriceTag => 'Photo of the price tag';

  @override
  String photoBonusHint(int points) {
    return '+$points bonus points';
  }

  @override
  String get remove => 'Remove';

  @override
  String get submitPrice => 'Submit price';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String priceDeviationWarning(String price, String average) {
    return '$price is very different from the usual price of about $average. We\'ll mark it for review.';
  }

  @override
  String get changePrice => 'Change price';

  @override
  String get yesSubmit => 'Yes, submit';

  @override
  String get photoUploadFailed =>
      'Couldn\'t upload the photo, so the price was sent without it.';

  @override
  String pointsEarned(int points) {
    return '+$points points!';
  }

  @override
  String get thanksForSharing => 'Thanks for helping your neighbours save!';

  @override
  String get savedOffline =>
      'No signal. Your price is saved and will be sent automatically.';

  @override
  String get addNewProduct => 'Add a new product';

  @override
  String get confirmPriceCorrect => 'Still correct';

  @override
  String get report => 'Report';

  @override
  String get reportWrongPrice => 'What\'s wrong with this price?';

  @override
  String get reasonWrongPrice => 'Wrong price';

  @override
  String get reasonWrongProduct => 'Wrong product';

  @override
  String get reasonSpam => 'Spam';

  @override
  String get reasonOfferEnded => 'Offer ended';

  @override
  String thanksConfirmed(int points) {
    return 'Thanks for confirming! +$points points';
  }

  @override
  String get thanksReported => 'Thanks, we\'ll review this price.';

  @override
  String get cantConfirmOwnPrice => 'You can\'t confirm your own price.';

  @override
  String get cantReportOwnPrice => 'You can\'t report your own price.';

  @override
  String get showPriceHistory => 'Show price history (90 days)';

  @override
  String get hidePriceHistory => 'Hide price history';

  @override
  String get noPriceHistory => 'No price history yet.';
}
