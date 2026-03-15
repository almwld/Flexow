import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعدة والدعم'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildContactCard(
            icon: Icons.chat,
            title: 'الدردشة المباشرة',
            subtitle: 'تواصل معنا مباشرة',
            onTap: () {},
          ),
          _buildContactCard(
            icon: Icons.phone,
            title: 'اتصل بنا',
            subtitle: '777-123-456',
            onTap: () {},
          ),
          _buildContactCard(
            icon: Icons.email,
            title: 'البريد الإلكتروني',
            subtitle: 'support@flexyemen.com',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            'الأسئلة الشائعة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFaqTile('كيف أضيف إعلاناً؟'),
          _buildFaqTile('كيف أشتري منتجاً؟'),
          _buildFaqTile('كيف أتواصل مع البائع؟'),
          _buildFaqTile('ما هي طرق الدفع المتاحة؟'),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.goldColor),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFaqTile(String question) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(question),
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'إجابة على السؤال ستظهر هنا. يمكنك توسيع هذا القسم لرؤية المزيد من التفاصيل.',
            ),
          ),
        ],
      ),
    );
  }
}
