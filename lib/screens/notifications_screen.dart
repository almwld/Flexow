import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'رسالة جديدة',
      'message': 'أحمد محمد أرسل لك رسالة',
      'time': 'منذ 5 دقائق',
      'icon': Icons.message,
      'color': Colors.blue,
      'isRead': false,
    },
    {
      'title': 'إعلان منتهي',
      'message': 'إعلانك "تويوتا كامري" سينتهي غداً',
      'time': 'منذ ساعة',
      'icon': Icons.timer,
      'color': Colors.orange,
      'isRead': false,
    },
    {
      'title': 'عرض جديد',
      'message': 'هناك عرض جديد على إعلانك',
      'time': 'منذ 3 ساعات',
      'icon': Icons.local_offer,
      'color': Colors.green,
      'isRead': true,
    },
    {
      'title': 'تم التحقق',
      'message': 'تم التحقق من حسابك بنجاح',
      'time': 'منذ يوم',
      'icon': Icons.verified,
      'color': Colors.purple,
      'isRead': true,
    },
    {
      'title': 'تحديث',
      'message': 'تم إصدار تحديث جديد للتطبيق',
      'time': 'منذ يومين',
      'icon': Icons.system_update,
      'color': Colors.teal,
      'isRead': true,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _clearAll() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'read') {
                _markAllAsRead();
              } else if (value == 'clear') {
                _clearAll();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'read',
                child: Text('تحديد الكل كمقروء'),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Text('مسح الكل', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState(isDark)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد إشعارات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'سيتم إشعارك عند وجود تحديثات جديدة',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey[600] : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRead = notification['isRead'] as bool;

    return GestureDetector(
      onTap: () {
        setState(() {
          notification['isRead'] = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRead
              ? (isDark ? AppTheme.darkCard : AppTheme.lightCard)
              : AppTheme.goldColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: !isRead ? Border.all(color: AppTheme.goldColor.withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: notification['color'].withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification['icon'],
                color: notification['color'],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        notification['title'],
                        style: TextStyle(
                          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      if (!isRead) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.goldColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['message'],
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['time'],
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.grey[500] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
