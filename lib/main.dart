import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إنشاء اختبارات',
      debugShowCheckedModeBanner: false,
      // دعم اللغة العربية من اليمين لليسار
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117), // لون الخلفية الأصلي
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF161B22),
          elevation: 1,
        ),
      ),
      home: const QuizCreatorPage(),
    );
  }
}

class QuizCreatorPage extends StatefulWidget {
  const QuizCreatorPage({super.key});

  @override
  State<QuizCreatorPage> createState() => _QuizCreatorPageState();
}

class _QuizCreatorPageState extends State<QuizCreatorPage> {
  // متغيرات للتحكم في شكل النص (مثل الوورد)
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;
  TextAlign _textAlign = TextAlign.right;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إنشاء اختبار جديد',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: 'نشر الاختبار',
            onPressed: () {
              // كود حفظ الاختبار هنا
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'إعدادات الاختبار',
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط أدوات التنسيق (يشبه Word)
          Container(
            color: const Color(0xFF21262D),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildToolIcon(Icons.format_bold, _isBold, () {
                    setState(() => _isBold = !_isBold);
                  }),
                  _buildToolIcon(Icons.format_italic, _isItalic, () {
                    setState(() => _isItalic = !_isItalic);
                  }),
                  _buildToolIcon(Icons.format_underline, _isUnderlined, () {
                    setState(() => _isUnderlined = !_isUnderlined);
                  }),
                  _buildVerticalDivider(),
                  _buildToolIcon(Icons.format_align_right, _textAlign == TextAlign.right, () {
                    setState(() => _textAlign = TextAlign.right);
                  }),
                  _buildToolIcon(Icons.format_align_center, _textAlign == TextAlign.center, () {
                    setState(() => _textAlign = TextAlign.center);
                  }),
                  _buildToolIcon(Icons.format_align_left, _textAlign == TextAlign.left, () {
                    setState(() => _textAlign = TextAlign.left);
                  }),
                  _buildVerticalDivider(),
                  _buildToolIcon(Icons.format_list_bulleted, false, () {}),
                  _buildToolIcon(Icons.format_list_numbered, false, () {}),
                  _buildVerticalDivider(),
                  _buildToolIcon(Icons.image_outlined, false, () {}), // إضافة صورة
                  _buildToolIcon(Icons.link, false, () {}), // إضافة رابط
                ],
              ),
            ),
          ),
          
          // منطقة كتابة السؤال أو المحتوى
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: null, // يسمح بكتابة أسطر غير محدودة
                expands: true,
                textAlign: _textAlign,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration: _isUnderlined ? TextDecoration.underline : TextDecoration.none,
                ),
                decoration: const InputDecoration(
                  hintText: 'اكتب سؤالك هنا...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none, // إخفاء الخط السفلي لتبدو كصفحة وورد
                ),
              ),
            ),
          ),
        ],
      ),
      
      // زر عائم (أيقونة إنشاء اختبار / إضافة سؤال)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // إجراء إضافة سؤال جديد
        },
        backgroundColor: const Color(0xFF1F6FEB), // اللون الأزرق من تصميمك
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'إضافة سؤال',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء أيقونات شريط الأدوات
  Widget _buildToolIcon(IconData icon, bool isActive, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      color: isActive ? const Color(0xFF58A6FF) : Colors.grey[400],
      onPressed: onPressed,
      splashRadius: 20,
    );
  }

  // دالة مساعدة لإنشاء الخط الفاصل بين الأدوات
  Widget _buildVerticalDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.grey[700],
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }
}