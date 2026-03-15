import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _marketingNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات الإشعارات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile(
            title: 'الإشعارات الفورية',
            subtitle: 'استلام الإشعارات على الجهاز',
            value: _pushNotifications,
            onChanged: (value) => setState(() => _pushNotifications = value),
          ),
          _buildSwitchTile(
            title: 'إشعارات البريد الإلكتروني',
            subtitle: 'استلام الإشعارات على البريد',
            value: _emailNotifications,
            onChanged: (value) => setState(() => _emailNotifications = value),
          ),
          _buildSwitchTile(
            title: 'إشعارات الرسائل النصية',
            subtitle: 'استلام إشعارات عبر SMS',
            value: _smsNotifications,
            onChanged: (value) => setState(() => _smsNotifications = value),
          ),
          _buildSwitchTile(
            title: 'العروض والتسويق',
            subtitle: 'استلام العروض الترويجية',
            value: _marketingNotifications,
            onChanged: (value) => setState(() => _marketingNotifications = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.goldColor,
      ),
    );
  }
}
