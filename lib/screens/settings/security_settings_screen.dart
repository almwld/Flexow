import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأمان'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSecurityCard(
            icon: Icons.lock_outline,
            title: 'تغيير كلمة المرور',
            subtitle: 'قم بتحديث كلمة المرور الخاصة بك',
            onTap: () {},
          ),
          _buildSecurityCard(
            icon: Icons.devices,
            title: 'إدارة الأجهزة',
            subtitle: 'عرض الأجهزة المتصلة بحسابك',
            onTap: () {},
          ),
          _buildSecurityCard(
            icon: Icons.history,
            title: 'سجل النشاط',
            subtitle: 'مراجعة آخر الأنشطة على حسابك',
            onTap: () {},
          ),
          _buildSecurityCard(
            icon: Icons.verified_user,
            title: 'التحقق بخطوتين',
            subtitle: 'تفعيل المصادقة الثنائية',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityCard({
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
}
