
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexora_app/login_screen.dart';
import 'package:nexora_app/home_screen.dart';
import 'package:nexora_app/l10n/app_localizations.dart';
import 'package:nexora_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
const RegisterScreen({super.key});

@override
State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
final TextEditingController _nameController =
TextEditingController();

final TextEditingController _emailController =
TextEditingController();

final TextEditingController _passwordController =
TextEditingController();

final TextEditingController _confirmPasswordController =
TextEditingController();

bool _isLoading = false;
String? _errorMessage;

// Cairo للعربي وPoppins للإنجليزي
TextStyle _fontStyle({
required bool isArabic,
Color color = Colors.white,
double fontSize = 15,
FontWeight fontWeight = FontWeight.normal,
double? height,
}) {
if (isArabic) {
return GoogleFonts.cairo(
color: color,
fontSize: fontSize,
fontWeight: fontWeight,
height: height,
);
}

return GoogleFonts.poppins(
color: color,
fontSize: fontSize,
fontWeight: fontWeight,
height: height,
);
}

@override
void dispose() {
_nameController.dispose();
_emailController.dispose();
_passwordController.dispose();
_confirmPasswordController.dispose();
super.dispose();
}

Future<void> _register() async {
final name = _nameController.text.trim();
final email = _emailController.text.trim();
final password = _passwordController.text;
final confirmPassword = _confirmPasswordController.text;

final isArabic =
Localizations.localeOf(context).languageCode == 'ar';

setState(() {
_errorMessage = null;
});

// التحقق من الحقول
if (name.isEmpty ||
email.isEmpty ||
password.isEmpty ||
confirmPassword.isEmpty) {
setState(() {
_errorMessage = isArabic
? 'يرجى تعبئة جميع الحقول.'
    : 'Please fill in all fields.';
});
return;
}

// التحقق من تطابق كلمات المرور
if (password != confirmPassword) {
setState(() {
_errorMessage = isArabic
? 'كلمتا المرور غير متطابقتين.'
    : 'Passwords do not match.';
});
return;
}

// التحقق من طول كلمة المرور
if (password.length < 8) {
setState(() {
_errorMessage = isArabic
? 'يجب أن تكون كلمة المرور 8 أحرف على الأقل.'
    : 'Password must be at least 8 characters.';
});
return;
}

setState(() {
_isLoading = true;
});

try {
await AuthService.register(
name: name,
email: email,
password: password,
confirmPassword: confirmPassword,
);

if (!mounted) return;

Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (context) => const HomeScreen(),
),
(route) => false,
);
} catch (e) {
if (!mounted) return;

final isArabic =
Localizations.localeOf(context).languageCode == 'ar';

final error = e.toString();

String message;

if (error.contains('EMAIL_ALREADY_REGISTERED')) {
message = isArabic
? 'هذا البريد الإلكتروني مسجل مسبقًا.'
    : 'This email is already registered.';
} else if (error.contains('SocketException')) {
message = isArabic
? 'تعذر الاتصال بالخادم.'
    : 'Unable to connect to the server.';
} else if (error.contains('VALIDATION_ERROR')) {
message = isArabic
? 'تأكد من صحة البيانات المدخلة.'
    : 'Please check the information you entered.';
} else {
message = isArabic
? 'فشل إنشاء الحساب. حاول مرة أخرى.'
    : 'Registration failed. Please try again.';
}

setState(() {
_errorMessage = message;
});
} finally {
if (mounted) {
setState(() {
_isLoading = false;
});
}
}
}

@override
Widget build(BuildContext context) {
final local = AppLocalizations.of(context);

final isArabic =
Localizations.localeOf(context).languageCode == 'ar';

return Directionality(
textDirection:
isArabic ? TextDirection.rtl : TextDirection.ltr,
child: Scaffold(
backgroundColor: const Color(0xFF02030A),
appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
leading: IconButton(
icon: Icon(
isArabic
? Icons.arrow_forward_ios
    : Icons.arrow_back_ios,
color: Colors.white,
),
onPressed: _isLoading
? null
    : () {
Navigator.pop(context);
},
),
),
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(horizontal: 28),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
const SizedBox(height: 20),

// العنوان
Text(
local.createAccount,
textAlign: TextAlign.center,
style: _fontStyle(
isArabic: isArabic,
fontSize: 30,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

// الوصف
Text(
local.registerDescription,
textAlign: TextAlign.center,
style: _fontStyle(
isArabic: isArabic,
color: Colors.white70,
fontSize: 15,
height: 1.5,
),
),

const SizedBox(height: 40),

// الاسم
Text(
local.name,
textAlign:
isArabic ? TextAlign.right : TextAlign.left,
style: _fontStyle(
isArabic: isArabic,
fontSize: 15,
fontWeight: FontWeight.w600,
),
),

const SizedBox(height: 8),

_buildTextField(
controller: _nameController,
hint: local.enterName,
icon: Icons.person_outline,
isArabic: isArabic,
),

const SizedBox(height: 20),

// البريد الإلكتروني
Text(
local.email,
textAlign:
isArabic ? TextAlign.right : TextAlign.left,
style: _fontStyle(
isArabic: isArabic,
fontSize: 15,
fontWeight: FontWeight.w600,
),
),

const SizedBox(height: 8),

_buildTextField(
controller: _emailController,
hint: local.enterEmail,
icon: Icons.email_outlined,
isArabic: isArabic,
keyboardType: TextInputType.emailAddress,
),

const SizedBox(height: 20),

// كلمة المرور
Text(
local.password,
textAlign:
isArabic ? TextAlign.right : TextAlign.left,
style: _fontStyle(
isArabic: isArabic,
fontSize: 15,
fontWeight: FontWeight.w600,
),
),

const SizedBox(height: 8),

_buildTextField(
controller: _passwordController,
hint: local.enterPassword,
icon: Icons.lock_outline,
isArabic: isArabic,
obscureText: true,
),

const SizedBox(height: 20),

// تأكيد كلمة المرور
Text(
local.confirmPassword,
textAlign:
isArabic ? TextAlign.right : TextAlign.left,
style: _fontStyle(
isArabic: isArabic,
fontSize: 15,
fontWeight: FontWeight.w600,
),
),

const SizedBox(height: 8),

_buildTextField(
controller: _confirmPasswordController,
hint: local.reEnterPassword,
icon: Icons.lock_reset_outlined,
isArabic: isArabic,
obscureText: true,
),

const SizedBox(height: 25),

// رسائل الخطأ
if (_errorMessage != null) ...[
Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(
horizontal: 14,
vertical: 12,
),
decoration: BoxDecoration(
color: const Color(0xFF3A1018),
borderRadius: BorderRadius.circular(14),
border: Border.all(
color: const Color(0xFF8B2635),
),
),
child: Text(
_errorMessage!,
textAlign: TextAlign.center,
style: _fontStyle(
isArabic: isArabic,
color: const Color(0xFFFFA8B3),
fontSize: 13,
height: 1.4,
),
),
),
const SizedBox(height: 15),
],

const SizedBox(height: 10),

// زر إنشاء الحساب
SizedBox(
width: double.infinity,
height: 58,
child: DecoratedBox(
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
Color(0xFF008CFF),
Color(0xFF7B3FFF),
Color(0xFFFF2DA6),
],
),
borderRadius: BorderRadius.circular(18),
),
child: ElevatedButton(
onPressed: _isLoading ? null : _register,
style: ElevatedButton.styleFrom(
backgroundColor: Colors.transparent,
disabledBackgroundColor: Colors.transparent,
shadowColor: Colors.transparent,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
),
child: _isLoading
? const SizedBox(
width: 25,
height: 25,
child: CircularProgressIndicator(
strokeWidth: 2.5,
valueColor:
AlwaysStoppedAnimation<Color>(
Colors.white,
),
),
)
    : Text(
local.createAccountButton,
style: _fontStyle(
isArabic: isArabic,
fontSize: 17,
fontWeight: FontWeight.bold,
),
),
),
),
),

const SizedBox(height: 25),

// الانتقال إلى تسجيل الدخول
TextButton(
onPressed: _isLoading
? null
    : () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const LoginScreen(),
),
);
},
child: Text(
local.alreadyHaveAccount,
textAlign: TextAlign.center,
style: _fontStyle(
isArabic: isArabic,
color: const Color(0xFF8F9BFF),
fontSize: 15,
),
),
),

const SizedBox(height: 20),
],
),
),
),
),
);
}

Widget _buildTextField({
required TextEditingController controller,
required String hint,
required IconData icon,
required bool isArabic,
bool obscureText = false,
TextInputType keyboardType = TextInputType.text,
}) {
return TextField(
controller: controller,
obscureText: obscureText,
keyboardType: keyboardType,
textDirection:
isArabic ? TextDirection.rtl : TextDirection.ltr,
style: _fontStyle(
isArabic: isArabic,
color: Colors.white,
fontSize: 14,
),
decoration: InputDecoration(
hintText: hint,
hintTextDirection:
isArabic ? TextDirection.rtl : TextDirection.ltr,
hintStyle: _fontStyle(
isArabic: isArabic,
color: Colors.white38,
fontSize: 13,
),
prefixIcon: Icon(
icon,
color: Colors.white54,
),
filled: true,
fillColor: const Color(0xFF0B0D18),
contentPadding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 17,
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: const BorderSide(
color: Color(0xFF252A45),
),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: const BorderSide(
color: Color(0xFF7B3FFF),
width: 1.5,
),
),
),
);
}
}
