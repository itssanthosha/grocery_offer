// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'برايس ميت';

  @override
  String get next => 'التالي';

  @override
  String get skip => 'تخطي';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get cancel => 'إلغاء';

  @override
  String get retry => 'حاول مرة أخرى';

  @override
  String get onboardingTitle1 => 'امسح وقارن';

  @override
  String get onboardingBody1 =>
      'امسح باركود أي منتج وشاهد فوراً أي سوبرماركت في عُمان يبيعه بأرخص سعر.';

  @override
  String get onboardingTitle2 => 'شارك الأسعار واكسب النقاط';

  @override
  String get onboardingBody2 =>
      'شاهدت سعراً؟ أضفه في ثوانٍ. كل بلاغ يساعد جيرانك ويمنحك نقاطاً.';

  @override
  String get onboardingTitle3 => 'وفّر في كل تسوق';

  @override
  String get onboardingBody3 =>
      'أنشئ قائمة تسوق وسنجد لك أرخص متجر لسلتك بالكامل.';

  @override
  String get onboardingSetupTitle => 'جهّز تطبيقك';

  @override
  String get onboardingSetupBody =>
      'اختر مدينتك ولغتك. يمكنك تغييرهما لاحقاً من الإعدادات.';

  @override
  String get city => 'المدينة';

  @override
  String get language => 'اللغة';

  @override
  String get languageSystem => 'لغة الجهاز';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get signInTitle => 'مرحباً بك في برايس ميت';

  @override
  String get signInSubtitle => 'أسعار البقالة في عُمان، مجاناً ومن المجتمع.';

  @override
  String get continueWithGoogle => 'المتابعة عبر جوجل';

  @override
  String get continueWithPhone => 'المتابعة برقم الهاتف';

  @override
  String get continueAsGuest => 'التصفح كزائر';

  @override
  String get signInGuestHint =>
      'يمكنك التصفح بدون حساب. سجّل الدخول لاحقاً لإضافة الأسعار وكسب النقاط.';

  @override
  String get phoneSignInTitle => 'سجّل الدخول برقم هاتفك';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get phoneNumberHint => '9X XXX XXX';

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get enterCodeTitle => 'أدخل الرمز';

  @override
  String enterCodeBody(String phone) {
    return 'أرسلنا رمزاً من 6 أرقام إلى $phone.';
  }

  @override
  String get verificationCode => 'رمز التحقق';

  @override
  String get verify => 'تحقق';

  @override
  String get changeNumber => 'تغيير الرقم';

  @override
  String get errorGeneric => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get errorNetwork =>
      'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.';

  @override
  String get errorInvalidPhone => 'رقم الهاتف غير صحيح.';

  @override
  String get errorInvalidCode => 'الرمز غير صحيح أو منتهي الصلاحية.';

  @override
  String get errorTooManyRequests =>
      'محاولات كثيرة. يرجى الانتظار بضع دقائق ثم المحاولة مرة أخرى.';

  @override
  String get errorAccountDisabled => 'تم تعطيل هذا الحساب.';

  @override
  String get errorSignInRequired => 'يرجى تسجيل الدخول للمتابعة.';

  @override
  String get errorFieldRequired => 'هذا الحقل مطلوب';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get homePlaceholder =>
      'البحث عن المنتجات والعروض قادم في المرحلة التالية.';

  @override
  String welcomeUser(String name) {
    return 'مرحباً، $name';
  }

  @override
  String get guest => 'زائر';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get signInPrompt => 'تسجيل الدخول';

  @override
  String get firebaseSetupTitle => 'لم يتم إعداد Firebase بعد';

  @override
  String get firebaseSetupBody =>
      'شغّل الأمر `flutterfire configure` داخل مجلد المشروع ثم أعد تشغيل التطبيق.';

  @override
  String get cityMuscat => 'مسقط';

  @override
  String get citySeeb => 'السيب';

  @override
  String get cityBawshar => 'بوشر';

  @override
  String get cityMuttrah => 'مطرح';

  @override
  String get cityBarka => 'بركاء';

  @override
  String get citySohar => 'صحار';

  @override
  String get citySalalah => 'صلالة';

  @override
  String get cityNizwa => 'نزوى';

  @override
  String get citySur => 'صور';

  @override
  String get cityIbri => 'عبري';

  @override
  String get cityRustaq => 'الرستاق';

  @override
  String get cityBuraimi => 'البريمي';

  @override
  String get cityKhasab => 'خصب';

  @override
  String get catFruitsVegetables => 'الفواكه والخضروات';

  @override
  String get catDairyEggs => 'الألبان والبيض';

  @override
  String get catMeatFish => 'اللحوم والأسماك';

  @override
  String get catBakery => 'المخبوزات';

  @override
  String get catRiceGrains => 'الأرز والحبوب';

  @override
  String get catOilGhee => 'الزيوت والسمن';

  @override
  String get catBeverages => 'المشروبات';

  @override
  String get catSnacks => 'الوجبات الخفيفة';

  @override
  String get catBabyCare => 'العناية بالطفل';

  @override
  String get catCleaning => 'المنظفات';

  @override
  String get catPersonalCare => 'العناية الشخصية';

  @override
  String get catFrozen => 'المجمدات';

  @override
  String get searchHint => 'ابحث عن منتج (بالعربية أو الإنجليزية)';

  @override
  String get searchPrompt => 'اكتب حرفين على الأقل للبحث.';

  @override
  String noSearchResults(String query) {
    return 'لم نجد منتجات لـ \"$query\". لا تجده؟ امسح الباركود لإضافته.';
  }

  @override
  String get scanBarcode => 'مسح الباركود';

  @override
  String get scanHint => 'وجّه الكاميرا نحو الباركود';

  @override
  String get toggleFlash => 'تشغيل/إيقاف الفلاش';

  @override
  String get cameraUnavailable =>
      'الكاميرا غير متاحة. اسمح بالوصول إلى الكاميرا من إعدادات هاتفك ثم حاول مرة أخرى.';

  @override
  String get recentlyUpdated => 'أحدث الأسعار';

  @override
  String get noPricesYet =>
      'لا توجد أسعار بعد — كن أول من يضيف سعراً واكسب 10 نقاط!';

  @override
  String get noPricesShort => 'لا أسعار';

  @override
  String get noProductsInCategory => 'لا توجد منتجات في هذه الفئة بعد.';

  @override
  String get fromPrice => 'ابتداءً من';

  @override
  String get newProductTitle => 'منتج جديد';

  @override
  String get signInToAddProduct => 'سجّل الدخول لإضافة منتج وكسب النقاط.';

  @override
  String get barcode => 'الباركود';

  @override
  String get productName => 'اسم المنتج';

  @override
  String get productNameAr => 'الاسم بالعربية (اختياري)';

  @override
  String get brand => 'العلامة التجارية (اختياري)';

  @override
  String get size => 'الحجم (اختياري)';

  @override
  String get sizeHint => 'مثال: 1 كجم، 500 مل، 6 × 200 مل';

  @override
  String get category => 'الفئة';

  @override
  String get saveProduct => 'حفظ المنتج';

  @override
  String get productNotFound => 'هذا المنتج لم يعد موجوداً.';

  @override
  String get pricesTitle => 'الأسعار';

  @override
  String get cheapest => 'الأرخص';

  @override
  String get verified => 'موثّق';

  @override
  String get offer => 'عرض';

  @override
  String offerUntil(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'العرض حتى $dateString';
  }

  @override
  String distanceKm(String km) {
    return 'على بعد $km كم';
  }

  @override
  String updatedAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'تم التحديث قبل $days يوم',
      many: 'تم التحديث قبل $days يوماً',
      few: 'تم التحديث قبل $days أيام',
      two: 'تم التحديث قبل يومين',
      one: 'تم التحديث أمس',
      zero: 'تم التحديث اليوم',
    );
    return '$_temp0';
  }

  @override
  String confirmationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تأكيد',
      many: '$count تأكيداً',
      few: '$count تأكيدات',
      two: 'تأكيدان',
      one: 'تأكيد واحد',
      zero: 'لا تأكيدات',
    );
    return '$_temp0';
  }

  @override
  String get unitKg => 'كجم';

  @override
  String get unitLitre => 'لتر';

  @override
  String get unitPiece => 'قطعة';

  @override
  String get errorDuplicatePrice =>
      'لقد أبلغت عن هذا المنتج في هذا المتجر خلال آخر 6 ساعات.';

  @override
  String get errorDailyLimit => 'وصلت إلى حد اليوم وهو 50 سعراً. عد غداً!';

  @override
  String get errorActionNotAllowed =>
      'غير مسموح. ربما أكدت هذا السعر أو أبلغت عنه من قبل، أو أنه سعرك أنت.';

  @override
  String get chooseStore => 'اختر المتجر';

  @override
  String get noStoresFound => 'لا توجد متاجر قريبة. أضف الفرع الذي أنت فيه.';

  @override
  String get addBranch => 'إضافة فرع';

  @override
  String get addBranchHint =>
      'أضف المتجر الذي تقف فيه. سنستخدم موقعك الحالي لتحديد مكانه.';

  @override
  String get chain => 'سلسلة المتاجر';

  @override
  String get branchName => 'اسم الفرع';

  @override
  String get areaOptional => 'المنطقة (اختياري)';

  @override
  String get locationNeededForBranch =>
      'فعّل الموقع لنتمكن من تحديد هذا الفرع على الخريطة.';

  @override
  String get signInToAddBranch => 'سجّل الدخول لإضافة فرع.';

  @override
  String get addPrice => 'إضافة سعر';

  @override
  String get addPriceTitle => 'إضافة سعر';

  @override
  String get signInToAddPrice => 'سجّل الدخول لإضافة الأسعار وكسب النقاط.';

  @override
  String get change => 'تغيير';

  @override
  String get thisIsAnOffer => 'هذا عرض';

  @override
  String get offerEndDateOptional => 'تاريخ انتهاء العرض (اختياري)';

  @override
  String get photoOfPriceTag => 'صورة بطاقة السعر';

  @override
  String photoBonusHint(int points) {
    return '+$points نقاط إضافية';
  }

  @override
  String get remove => 'إزالة';

  @override
  String get submitPrice => 'إرسال السعر';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String priceDeviationWarning(String price, String average) {
    return 'السعر $price يختلف كثيراً عن السعر المعتاد الذي يبلغ نحو $average. سنضعه قيد المراجعة.';
  }

  @override
  String get changePrice => 'تغيير السعر';

  @override
  String get yesSubmit => 'نعم، أرسل';

  @override
  String get photoUploadFailed => 'تعذّر رفع الصورة، لذلك أُرسل السعر بدونها.';

  @override
  String pointsEarned(int points) {
    return '+$points نقطة!';
  }

  @override
  String get thanksForSharing => 'شكراً لمساعدتك جيرانك على التوفير!';

  @override
  String get savedOffline => 'لا توجد إشارة. تم حفظ السعر وسيُرسل تلقائياً.';

  @override
  String get addNewProduct => 'إضافة منتج جديد';

  @override
  String get confirmPriceCorrect => 'ما زال صحيحاً';

  @override
  String get report => 'إبلاغ';

  @override
  String get reportWrongPrice => 'ما المشكلة في هذا السعر؟';

  @override
  String get reasonWrongPrice => 'سعر خاطئ';

  @override
  String get reasonWrongProduct => 'منتج خاطئ';

  @override
  String get reasonSpam => 'محتوى مزعج';

  @override
  String get reasonOfferEnded => 'انتهى العرض';

  @override
  String thanksConfirmed(int points) {
    return 'شكراً على التأكيد! +$points نقاط';
  }

  @override
  String get thanksReported => 'شكراً، سنراجع هذا السعر.';

  @override
  String get cantConfirmOwnPrice => 'لا يمكنك تأكيد سعر أضفته بنفسك.';

  @override
  String get cantReportOwnPrice => 'لا يمكنك الإبلاغ عن سعر أضفته بنفسك.';

  @override
  String get showPriceHistory => 'عرض سجل الأسعار (90 يوماً)';

  @override
  String get hidePriceHistory => 'إخفاء سجل الأسعار';

  @override
  String get noPriceHistory => 'لا يوجد سجل أسعار بعد.';
}
