import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PriceMate'**
  String get appName;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Scan and compare'**
  String get onboardingTitle1;

  /// No description provided for @onboardingBody1.
  ///
  /// In en, this message translates to:
  /// **'Scan any product and instantly see which supermarket in Oman sells it cheapest.'**
  String get onboardingBody1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Share prices, earn points'**
  String get onboardingTitle2;

  /// No description provided for @onboardingBody2.
  ///
  /// In en, this message translates to:
  /// **'Spotted a price? Add it in seconds. Every report helps your neighbours and earns you points.'**
  String get onboardingBody2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Save on every shop'**
  String get onboardingTitle3;

  /// No description provided for @onboardingBody3.
  ///
  /// In en, this message translates to:
  /// **'Build a shopping list and we\'ll find the cheapest store for your whole basket.'**
  String get onboardingBody3;

  /// No description provided for @onboardingSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your app'**
  String get onboardingSetupTitle;

  /// No description provided for @onboardingSetupBody.
  ///
  /// In en, this message translates to:
  /// **'Pick your city and language. You can change them later in Settings.'**
  String get onboardingSetupBody;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'Device language'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to PriceMate'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Free, community-powered grocery prices across Oman.'**
  String get signInSubtitle;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Continue with phone number'**
  String get continueWithPhone;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Browse as guest'**
  String get continueAsGuest;

  /// No description provided for @signInGuestHint.
  ///
  /// In en, this message translates to:
  /// **'You can browse without an account. Sign in later to add prices and earn points.'**
  String get signInGuestHint;

  /// No description provided for @phoneSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your phone'**
  String get phoneSignInTitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'9X XXX XXX'**
  String get phoneNumberHint;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @enterCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get enterCodeTitle;

  /// No description provided for @enterCodeBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {phone}.'**
  String enterCodeBody(String phone);

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @changeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get changeNumber;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your signal and try again.'**
  String get errorNetwork;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'That phone number doesn\'t look right.'**
  String get errorInvalidPhone;

  /// No description provided for @errorInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'That code is incorrect or has expired.'**
  String get errorInvalidCode;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a few minutes and try again.'**
  String get errorTooManyRequests;

  /// No description provided for @errorAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get errorAccountDisabled;

  /// No description provided for @errorSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue.'**
  String get errorSignInRequired;

  /// No description provided for @errorFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorFieldRequired;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Product search and deals are coming in the next phase.'**
  String get homePlaceholder;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String welcomeUser(String name);

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInPrompt;

  /// No description provided for @firebaseSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Firebase isn\'t configured yet'**
  String get firebaseSetupTitle;

  /// No description provided for @firebaseSetupBody.
  ///
  /// In en, this message translates to:
  /// **'Run `flutterfire configure` in the project folder, then restart the app.'**
  String get firebaseSetupBody;

  /// No description provided for @cityMuscat.
  ///
  /// In en, this message translates to:
  /// **'Muscat'**
  String get cityMuscat;

  /// No description provided for @citySeeb.
  ///
  /// In en, this message translates to:
  /// **'Seeb'**
  String get citySeeb;

  /// No description provided for @cityBawshar.
  ///
  /// In en, this message translates to:
  /// **'Bawshar'**
  String get cityBawshar;

  /// No description provided for @cityMuttrah.
  ///
  /// In en, this message translates to:
  /// **'Muttrah'**
  String get cityMuttrah;

  /// No description provided for @cityBarka.
  ///
  /// In en, this message translates to:
  /// **'Barka'**
  String get cityBarka;

  /// No description provided for @citySohar.
  ///
  /// In en, this message translates to:
  /// **'Sohar'**
  String get citySohar;

  /// No description provided for @citySalalah.
  ///
  /// In en, this message translates to:
  /// **'Salalah'**
  String get citySalalah;

  /// No description provided for @cityNizwa.
  ///
  /// In en, this message translates to:
  /// **'Nizwa'**
  String get cityNizwa;

  /// No description provided for @citySur.
  ///
  /// In en, this message translates to:
  /// **'Sur'**
  String get citySur;

  /// No description provided for @cityIbri.
  ///
  /// In en, this message translates to:
  /// **'Ibri'**
  String get cityIbri;

  /// No description provided for @cityRustaq.
  ///
  /// In en, this message translates to:
  /// **'Rustaq'**
  String get cityRustaq;

  /// No description provided for @cityBuraimi.
  ///
  /// In en, this message translates to:
  /// **'Buraimi'**
  String get cityBuraimi;

  /// No description provided for @cityKhasab.
  ///
  /// In en, this message translates to:
  /// **'Khasab'**
  String get cityKhasab;

  /// No description provided for @catFruitsVegetables.
  ///
  /// In en, this message translates to:
  /// **'Fruits & Vegetables'**
  String get catFruitsVegetables;

  /// No description provided for @catDairyEggs.
  ///
  /// In en, this message translates to:
  /// **'Dairy & Eggs'**
  String get catDairyEggs;

  /// No description provided for @catMeatFish.
  ///
  /// In en, this message translates to:
  /// **'Meat & Fish'**
  String get catMeatFish;

  /// No description provided for @catBakery.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get catBakery;

  /// No description provided for @catRiceGrains.
  ///
  /// In en, this message translates to:
  /// **'Rice & Grains'**
  String get catRiceGrains;

  /// No description provided for @catOilGhee.
  ///
  /// In en, this message translates to:
  /// **'Oil & Ghee'**
  String get catOilGhee;

  /// No description provided for @catBeverages.
  ///
  /// In en, this message translates to:
  /// **'Beverages'**
  String get catBeverages;

  /// No description provided for @catSnacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get catSnacks;

  /// No description provided for @catBabyCare.
  ///
  /// In en, this message translates to:
  /// **'Baby Care'**
  String get catBabyCare;

  /// No description provided for @catCleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get catCleaning;

  /// No description provided for @catPersonalCare.
  ///
  /// In en, this message translates to:
  /// **'Personal Care'**
  String get catPersonalCare;

  /// No description provided for @catFrozen.
  ///
  /// In en, this message translates to:
  /// **'Frozen'**
  String get catFrozen;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products (English or Arabic)'**
  String get searchHint;

  /// No description provided for @searchPrompt.
  ///
  /// In en, this message translates to:
  /// **'Type at least 2 letters to search.'**
  String get searchPrompt;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No products found for \"{query}\". Can\'t find it? Scan its barcode to add it.'**
  String noSearchResults(String query);

  /// No description provided for @scanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan barcode'**
  String get scanBarcode;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at a barcode'**
  String get scanHint;

  /// No description provided for @toggleFlash.
  ///
  /// In en, this message translates to:
  /// **'Toggle flash'**
  String get toggleFlash;

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera isn\'t available. Allow camera access in your phone settings and try again.'**
  String get cameraUnavailable;

  /// No description provided for @recentlyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Recently updated prices'**
  String get recentlyUpdated;

  /// No description provided for @noPricesYet.
  ///
  /// In en, this message translates to:
  /// **'No prices yet — be the first to add one and earn 10 points!'**
  String get noPricesYet;

  /// No description provided for @noPricesShort.
  ///
  /// In en, this message translates to:
  /// **'No prices'**
  String get noPricesShort;

  /// No description provided for @noProductsInCategory.
  ///
  /// In en, this message translates to:
  /// **'No products in this category yet.'**
  String get noProductsInCategory;

  /// No description provided for @fromPrice.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromPrice;

  /// No description provided for @newProductTitle.
  ///
  /// In en, this message translates to:
  /// **'New product'**
  String get newProductTitle;

  /// No description provided for @signInToAddProduct.
  ///
  /// In en, this message translates to:
  /// **'Sign in to add a product and earn points.'**
  String get signInToAddProduct;

  /// No description provided for @barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get productName;

  /// No description provided for @productNameAr.
  ///
  /// In en, this message translates to:
  /// **'Name in Arabic (optional)'**
  String get productNameAr;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand (optional)'**
  String get brand;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size (optional)'**
  String get size;

  /// No description provided for @sizeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1 kg, 500 ml, 6 x 200 ml'**
  String get sizeHint;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @saveProduct.
  ///
  /// In en, this message translates to:
  /// **'Save product'**
  String get saveProduct;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'This product no longer exists.'**
  String get productNotFound;

  /// No description provided for @pricesTitle.
  ///
  /// In en, this message translates to:
  /// **'Prices'**
  String get pricesTitle;

  /// No description provided for @cheapest.
  ///
  /// In en, this message translates to:
  /// **'Cheapest'**
  String get cheapest;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @offer.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get offer;

  /// No description provided for @offerUntil.
  ///
  /// In en, this message translates to:
  /// **'Offer until {date}'**
  String offerUntil(DateTime date);

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{km} km away'**
  String distanceKm(String km);

  /// No description provided for @updatedAgo.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{Updated today} =1{Updated yesterday} other{Updated {days} days ago}}'**
  String updatedAgo(int days);

  /// No description provided for @confirmationsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No confirmations} =1{1 confirmation} other{{count} confirmations}}'**
  String confirmationsCount(int count);

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitLitre.
  ///
  /// In en, this message translates to:
  /// **'litre'**
  String get unitLitre;

  /// No description provided for @unitPiece.
  ///
  /// In en, this message translates to:
  /// **'piece'**
  String get unitPiece;

  /// No description provided for @errorDuplicatePrice.
  ///
  /// In en, this message translates to:
  /// **'You already reported this product at this store in the last 6 hours.'**
  String get errorDuplicatePrice;

  /// No description provided for @errorDailyLimit.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached today\'s limit of 50 prices. Come back tomorrow!'**
  String get errorDailyLimit;

  /// No description provided for @errorActionNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'That isn\'t allowed. You may have already confirmed or reported this price, or it\'s your own.'**
  String get errorActionNotAllowed;

  /// No description provided for @chooseStore.
  ///
  /// In en, this message translates to:
  /// **'Choose a store'**
  String get chooseStore;

  /// No description provided for @noStoresFound.
  ///
  /// In en, this message translates to:
  /// **'No stores found nearby. Add the branch you\'re in.'**
  String get noStoresFound;

  /// No description provided for @addBranch.
  ///
  /// In en, this message translates to:
  /// **'Add a branch'**
  String get addBranch;

  /// No description provided for @addBranchHint.
  ///
  /// In en, this message translates to:
  /// **'Add the store you\'re standing in. We\'ll use your current location for its pin.'**
  String get addBranchHint;

  /// No description provided for @chain.
  ///
  /// In en, this message translates to:
  /// **'Store chain'**
  String get chain;

  /// No description provided for @branchName.
  ///
  /// In en, this message translates to:
  /// **'Branch name'**
  String get branchName;

  /// No description provided for @areaOptional.
  ///
  /// In en, this message translates to:
  /// **'Area (optional)'**
  String get areaOptional;

  /// No description provided for @locationNeededForBranch.
  ///
  /// In en, this message translates to:
  /// **'Turn on location so we can pin this branch on the map.'**
  String get locationNeededForBranch;

  /// No description provided for @signInToAddBranch.
  ///
  /// In en, this message translates to:
  /// **'Sign in to add a branch.'**
  String get signInToAddBranch;

  /// No description provided for @addPrice.
  ///
  /// In en, this message translates to:
  /// **'Add price'**
  String get addPrice;

  /// No description provided for @addPriceTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a price'**
  String get addPriceTitle;

  /// No description provided for @signInToAddPrice.
  ///
  /// In en, this message translates to:
  /// **'Sign in to add prices and earn points.'**
  String get signInToAddPrice;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @thisIsAnOffer.
  ///
  /// In en, this message translates to:
  /// **'This is an offer'**
  String get thisIsAnOffer;

  /// No description provided for @offerEndDateOptional.
  ///
  /// In en, this message translates to:
  /// **'Offer end date (optional)'**
  String get offerEndDateOptional;

  /// No description provided for @photoOfPriceTag.
  ///
  /// In en, this message translates to:
  /// **'Photo of the price tag'**
  String get photoOfPriceTag;

  /// No description provided for @photoBonusHint.
  ///
  /// In en, this message translates to:
  /// **'+{points} bonus points'**
  String photoBonusHint(int points);

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @submitPrice.
  ///
  /// In en, this message translates to:
  /// **'Submit price'**
  String get submitPrice;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @priceDeviationWarning.
  ///
  /// In en, this message translates to:
  /// **'{price} is very different from the usual price of about {average}. We\'ll mark it for review.'**
  String priceDeviationWarning(String price, String average);

  /// No description provided for @changePrice.
  ///
  /// In en, this message translates to:
  /// **'Change price'**
  String get changePrice;

  /// No description provided for @yesSubmit.
  ///
  /// In en, this message translates to:
  /// **'Yes, submit'**
  String get yesSubmit;

  /// No description provided for @photoUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t upload the photo, so the price was sent without it.'**
  String get photoUploadFailed;

  /// No description provided for @pointsEarned.
  ///
  /// In en, this message translates to:
  /// **'+{points} points!'**
  String pointsEarned(int points);

  /// No description provided for @thanksForSharing.
  ///
  /// In en, this message translates to:
  /// **'Thanks for helping your neighbours save!'**
  String get thanksForSharing;

  /// No description provided for @savedOffline.
  ///
  /// In en, this message translates to:
  /// **'No signal. Your price is saved and will be sent automatically.'**
  String get savedOffline;

  /// No description provided for @addNewProduct.
  ///
  /// In en, this message translates to:
  /// **'Add a new product'**
  String get addNewProduct;

  /// No description provided for @confirmPriceCorrect.
  ///
  /// In en, this message translates to:
  /// **'Still correct'**
  String get confirmPriceCorrect;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @reportWrongPrice.
  ///
  /// In en, this message translates to:
  /// **'What\'s wrong with this price?'**
  String get reportWrongPrice;

  /// No description provided for @reasonWrongPrice.
  ///
  /// In en, this message translates to:
  /// **'Wrong price'**
  String get reasonWrongPrice;

  /// No description provided for @reasonWrongProduct.
  ///
  /// In en, this message translates to:
  /// **'Wrong product'**
  String get reasonWrongProduct;

  /// No description provided for @reasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get reasonSpam;

  /// No description provided for @reasonOfferEnded.
  ///
  /// In en, this message translates to:
  /// **'Offer ended'**
  String get reasonOfferEnded;

  /// No description provided for @thanksConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Thanks for confirming! +{points} points'**
  String thanksConfirmed(int points);

  /// No description provided for @thanksReported.
  ///
  /// In en, this message translates to:
  /// **'Thanks, we\'ll review this price.'**
  String get thanksReported;

  /// No description provided for @cantConfirmOwnPrice.
  ///
  /// In en, this message translates to:
  /// **'You can\'t confirm your own price.'**
  String get cantConfirmOwnPrice;

  /// No description provided for @cantReportOwnPrice.
  ///
  /// In en, this message translates to:
  /// **'You can\'t report your own price.'**
  String get cantReportOwnPrice;

  /// No description provided for @showPriceHistory.
  ///
  /// In en, this message translates to:
  /// **'Show price history (90 days)'**
  String get showPriceHistory;

  /// No description provided for @hidePriceHistory.
  ///
  /// In en, this message translates to:
  /// **'Hide price history'**
  String get hidePriceHistory;

  /// No description provided for @noPriceHistory.
  ///
  /// In en, this message translates to:
  /// **'No price history yet.'**
  String get noPriceHistory;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
