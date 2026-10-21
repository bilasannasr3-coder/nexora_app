
import 'package:flutter/widgets.dart';

class AppLocalizations {
final Locale locale;

AppLocalizations(this.locale);

static AppLocalizations of(BuildContext context) {
return Localizations.of<AppLocalizations>(
context,
AppLocalizations,
)!;
}

static const LocalizationsDelegate<AppLocalizations> delegate =
_AppLocalizationsDelegate();

// =========================================================
// ENGLISH
// =========================================================

static const Map<String, String> _en = {
// =======================================================
// General
// =======================================================

'appName': 'NEXORA',
'welcome': 'Welcome',
'login': 'Login',
'register': 'Register',
'email': 'Email',
'password': 'Password',
'name': 'Name',

// =======================================================
// Welcome Screen
// =======================================================

'discoverPath':
'Discover Your Academic Path with Confidence',

'pathDescription':
'Help yourself choose the path that suits you best by understanding your abilities and interests.',

'startNow': 'Get Started',

// =======================================================
// Register Screen
// =======================================================

'createAccount': 'Create Account',

'registerDescription':
'Create your account and start your journey with NEXORA',

'enterName': 'Enter your name',

'enterEmail': 'Enter your email',

'enterPassword': 'Enter your password',

'confirmPassword': 'Confirm Password',

'reEnterPassword': 'Re-enter your password',

'createAccountButton': 'Create Account',

'alreadyHaveAccount':
'Already have an account? Login',

// =======================================================
// Login Screen
// =======================================================

'backWelcome': 'Welcome Back',

'loginDescription':
'Log in to continue your journey with NEXORA',

'forgotPassword': 'Forgot your password?',

'loginButton': 'Login',

'noAccount':
"Don't have an account? Create Account",

  'loginRequiredFields': 'Please enter your email and password.',
  'invalidLogin': 'Invalid email or password.',
  'serverConnectionError': 'Unable to connect to the server.',
  'loginError': 'Login failed. Please try again.',
// =======================================================
// Home Screen
// =======================================================

'home': 'Home',

'homeWelcome':
'Welcome to NEXORA 👋',

'homeDescription':
'Your journey to discover your academic path starts here.',

'journeyTitle':
'Your NEXORA Journey',

'journeySubtitle':
'Everything you need to discover your academic path',

'readyToDiscover':
'Ready to discover your path?',

'testDescription':
'Answer the tests and discover the academic path that matches your abilities and interests.',

'startTests':
'Start Tests',

'tests':
'Tests',

'discoverAbilities':
'Discover your abilities',

'results':
'Results',

'reviewResults':
'Review your results',

'academicPath':
'Academic Path',

'recommendedPath':
'Your recommended path',

'specializations':
'Specializations',

'exploreFuture':
'Explore your future',

'journeyNotStarted':
'Your journey has not started yet',

'startTestsToSee':
'Start the tests to see your results and recommendations',

'account':
'Account',

'pageComingSoon':
'This page will be built later',
};

// =========================================================
// ARABIC
// =========================================================

static const Map<String, String> _ar = {
// =======================================================
// General
// =======================================================

'appName': 'NEXORA',
'welcome': 'مرحبًا',
'login': 'تسجيل الدخول',
'register': 'إنشاء حساب',
'email': 'البريد الإلكتروني',
'password': 'كلمة المرور',
'name': 'الاسم',

// =======================================================
// Welcome Screen
// =======================================================

'discoverPath':
'اكتشف مسارك الدراسي بثقة',

'pathDescription':
'ساعد نفسك على اختيار المسار الأنسب لك، من خلال فهم قدراتك واهتماماتك.',

'startNow': 'ابدأ الآن',

// =======================================================
// Register Screen
// =======================================================

'createAccount': 'إنشاء حساب',

'registerDescription':
'أنشئ حسابك وابدأ رحلتك مع NEXORA',

'enterName': 'أدخل اسمك',

'enterEmail': 'أدخل بريدك الإلكتروني',

'enterPassword': 'أدخل كلمة المرور',

'confirmPassword': 'تأكيد كلمة المرور',

'reEnterPassword':
'أعد إدخال كلمة المرور',

'createAccountButton':
'إنشاء الحساب',

'alreadyHaveAccount':
'لديك حساب بالفعل؟ تسجيل الدخول',

// =======================================================
// Login Screen
// =======================================================

'backWelcome':
'مرحبًا بعودتك',

'loginDescription':
'سجّل دخولك لمتابعة رحلتك مع NEXORA',

'forgotPassword':
'نسيت كلمة المرور؟',

'loginButton':
'تسجيل الدخول',

'noAccount':
'ليس لديك حساب؟ إنشاء حساب',
  'loginRequiredFields': 'يرجى إدخال البريد الإلكتروني وكلمة المرور.',
  'invalidLogin': 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
  'serverConnectionError': 'تعذر الاتصال بالخادم.',
  'loginError': 'فشل تسجيل الدخول. حاول مرة أخرى.',
// =======================================================
// Home Screen
// =======================================================

'home': 'الرئيسية',

'homeWelcome':
'أهلًا بك في NEXORA 👋',

'homeDescription':
'رحلتك لاكتشاف مسارك الدراسي تبدأ من هنا.',

'journeyTitle':
'رحلتك مع NEXORA',

'journeySubtitle':
'كل ما تحتاجه لاكتشاف مسارك الدراسي',

'readyToDiscover':
'جاهز تكتشف مسارك؟',

'testDescription':
'أجب عن الاختبارات واكتشف المسار الدراسي الذي يتناسب مع قدراتك واهتماماتك.',

'startTests':
'ابدأ الاختبارات',

'tests':
'الاختبارات',

'discoverAbilities':
'اكتشف قدراتك',

'results':
'النتائج',

'reviewResults':
'راجع نتائجك',

'academicPath':
'المسار الاكاديمي',

'recommendedPath':
'مسارك المقترح',

'specializations':
'التخصصات',

'exploreFuture':
'استكشف مستقبلك',

'journeyNotStarted':
'رحلتك لم تبدأ بعد',

'startTestsToSee':
'ابدأ الاختبارات لتظهر لك نتائجك وتوصياتك',

'account':
'حسابي',

'pageComingSoon':
'هذه الصفحة سنبنيها لاحقًا',
};

// =========================================================
// TRANSLATION METHOD
// =========================================================

String text(String key) {
final translations =
locale.languageCode == 'ar' ? _ar : _en;

return translations[key] ?? key;
}

// =========================================================
// GENERAL GETTERS
// =========================================================

String get appName => text('appName');

String get welcome => text('welcome');

String get login => text('login');

String get register => text('register');

String get email => text('email');

String get password => text('password');

String get name => text('name');

// =========================================================
// WELCOME GETTERS
// =========================================================

String get discoverPath =>
text('discoverPath');

String get pathDescription =>
text('pathDescription');

String get startNow =>
text('startNow');

// =========================================================
// REGISTER GETTERS
// =========================================================

String get createAccount =>
text('createAccount');

String get registerDescription =>
text('registerDescription');

String get enterName =>
text('enterName');

String get enterEmail =>
text('enterEmail');

String get enterPassword =>
text('enterPassword');

String get confirmPassword =>
text('confirmPassword');

String get reEnterPassword =>
text('reEnterPassword');

String get createAccountButton =>
text('createAccountButton');

String get alreadyHaveAccount =>
text('alreadyHaveAccount');

// =========================================================
// LOGIN GETTERS
// =========================================================

String get backWelcome =>
text('backWelcome');

String get loginDescription =>
text('loginDescription');

String get forgotPassword =>
text('forgotPassword');

String get loginButton =>
text('loginButton');

String get noAccount =>
text('noAccount');
  String get loginRequiredFields =>
      text('loginRequiredFields');

  String get invalidLogin =>
      text('invalidLogin');

  String get serverConnectionError =>
      text('serverConnectionError');

  String get loginError =>
      text('loginError');
// =========================================================
// HOME GETTERS
// =========================================================

String get home =>
text('home');

String get homeWelcome =>
text('homeWelcome');

String get homeDescription =>
text('homeDescription');

String get journeyTitle =>
text('journeyTitle');

String get journeySubtitle =>
text('journeySubtitle');

String get readyToDiscover =>
text('readyToDiscover');

String get testDescription =>
text('testDescription');

String get startTests =>
text('startTests');

String get tests =>
text('tests');

String get discoverAbilities =>
text('discoverAbilities');

String get results =>
text('results');

String get reviewResults =>
text('reviewResults');

String get academicPath =>
text('academicPath');

String get recommendedPath =>
text('recommendedPath');

String get specializations =>
text('specializations');

String get exploreFuture =>
text('exploreFuture');

String get journeyNotStarted =>
text('journeyNotStarted');

String get startTestsToSee =>
text('startTestsToSee');

String get account =>
text('account');

String get pageComingSoon =>
text('pageComingSoon');
}

// ===========================================================
// LOCALIZATION DELEGATE
// ===========================================================

class _AppLocalizationsDelegate
extends LocalizationsDelegate<AppLocalizations> {
const _AppLocalizationsDelegate();

@override
bool isSupported(Locale locale) {
return ['en', 'ar'].contains(
locale.languageCode,
);
}

@override
Future<AppLocalizations> load(Locale locale) async {
return AppLocalizations(locale);
}

@override
bool shouldReload(
_AppLocalizationsDelegate old,
) {
return false;
}
}
