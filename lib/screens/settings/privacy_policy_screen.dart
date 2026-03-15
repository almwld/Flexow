import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سياسة الخصوصية',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '1. جمع المعلومات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'نقوم بجمع المعلومات اللازمة فقط لتقديم خدماتنا بشكل أفضل.',
            ),
            SizedBox(height: 16),
            Text(
              '2. استخدام المعلومات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'نستخدم معلوماتك فقط للأغراض المحددة مثل تحسين الخدمة والتواصل معك.',
            ),
            SizedBox(height: 16),
            Text(
              '3. حماية المعلومات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'نستخدم تقنيات أمان متقدمة لحماية بياناتك من الوصول غير المصرح به.',
            ),
          ],
        ),
      ),
    );
  }
}
