import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'settings/notifications_settings_screen.dart';
import 'settings/security_settings_screen.dart';
import 'settings/payment_methods_screen.dart';
import 'settings/language_screen.dart';
import 'settings/about_screen.dart';
import 'settings/privacy_policy_screen.dart';
import 'settings/help_support_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('الإشعارات'),
            _buildSettingsCard([
              _buildSettingsItem(
                icon: Icons.notifications_outlined,
                iconColor: Colors.blue,
                title: 'الإشعارات',
                subtitle: 'تفعيل الإشعارات',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  activeColor: AppTheme.goldColor,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationsSettingsScreen(),
                    ),
                  );
                },
              ),
            ]),
            const SizedBox(height: 16),

            _buildSectionTitle('الأمان والخصوصية'),
            _buildSettingsCard([
              _buildSettingsItem(
                icon: Icons.security_outlined,
                iconColor: Colors.green,
                title: 'الأمان',
                subtitle: 'كلمة المرور، المصادقة',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SecuritySettingsScreen(),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              _buildSettingsItem(
                icon: Icons.fingerprint,
                iconColor: Colors.purple,
                title: 'البصمة',
                subtitle: 'تسجيل الدخول بالبصمة',
                trailing: Switch(
                  value: _biometricEnabled,
                  onChanged: (value) {
                    setState(() {
                      _biometricEnabled = value;
                    });
                  },
                  activeColor: AppTheme.goldColor,
                ),
              ),
              const Divider(height: 1),
              _buildSettingsItem(
                icon: Icons.privacy_tip_outlined,
                iconColor: Colors.orange,
                title: 'سياسة الخصوصية',
                subtitle: 'شروط الاستخدام',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
            ]),
            const SizedBox(height: 16),

            _buildSectionTitle('الدفع'),
            _buildSettingsCard([
              _buildSettingsItem(
                icon: Icons.payment_outlined,
                iconColor: Colors.teal,
                title: 'طرق الدفع',
                subtitle: 'إدارة بطاقاتك',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PaymentMethodsScreen(),
                    ),
                  );
                },
              ),
            ]),
            const SizedBox(height: 16),

            _buildSectionTitle('اللغة والمظهر'),
            _buildSettingsCard([
              _buildSettingsItem(
                icon: Icons.language_outlined,
                iconColor: Colors.indigo,
                title: 'اللغة',
                subtitle: 'العربية',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const LanguageScreen(),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              _buildSettingsItem(
                icon: Icons.dark_mode_outlined,
                iconColor: Colors.amber,
                title: 'الوضع الليلي',
                subtitle: 'تفعيل الوضع الليلي',
                trailing: Switch(
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                  activeColor: AppTheme.goldColor,
                ),
              ),
            ]),
            const SizedBox(height: 16),

            _buildSectionTitle('المساعدة والدعم'),
            _buildSettingsCard([
              _buildSettingsItem(
                icon: Icons.help_outline,
                iconColor: Colors.cyan,
                title: 'المساعدة والدعم',
                subtitle: 'تواصل معنا',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HelpSupportScreen(),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              _buildSettingsItem(
                icon: Icons.info_outline,
                iconColor: Colors.pink,
                title: 'عن التطبيق',
                subtitle: 'الإصدار 1.0.0',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AboutScreen(),
                    ),
                  );
                },
              ),
            ]),
            const SizedBox(height: 32),

            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    size: 48,
                    color: AppTheme.goldColor,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'FLEX YEMEN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'الإصدار 1.0.0 (Build 100)',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[500] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
    );
  }
}
