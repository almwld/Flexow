import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import 'account_info_screen.dart';
import 'settings_screen.dart';
import 'my_ads_screen.dart';
import 'favorites_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isGuest;

  const ProfileScreen({super.key, this.isGuest = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = true;

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'إعلاناتي',
      'icon': Icons.campaign,
      'color': Colors.blue,
      'screen': const MyAdsScreen(),
    },
    {
      'title': 'المفضلة',
      'icon': Icons.favorite,
      'color': Colors.red,
      'screen': const FavoritesScreen(),
    },
    {
      'title': 'معلومات الحساب',
      'icon': Icons.person,
      'color': Colors.green,
      'screen': const AccountInfoScreen(),
    },
    {
      'title': 'الإعدادات',
      'icon': Icons.settings,
      'color': Colors.purple,
      'screen': const SettingsScreen(),
    },
    {
      'title': 'المساعدة والدعم',
      'icon': Icons.help_outline,
      'color': Colors.orange,
      'screen': null,
    },
    {
      'title': 'عن التطبيق',
      'icon': Icons.info_outline,
      'color': Colors.teal,
      'screen': null,
    },
  ];

  Future<void> _logout() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.goldColor.withOpacity(0.3),
                      isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppTheme.goldColor, AppTheme.goldLight],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.goldColor,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppTheme.goldColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.isGuest ? 'ضيف' : 'أحمد محمد',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.isGuest ? 'سجل دخول للوصول لجميع الميزات' : 'ahmed@example.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (!widget.isGuest)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('الإعلانات', '12'),
                    Container(
                      width: 1,
                      height: 40,
                      color: isDark ? Colors.grey[800] : Colors.grey[300],
                    ),
                    _buildStatItem('المفضلة', '45'),
                    Container(
                      width: 1,
                      height: 40,
                      color: isDark ? Colors.grey[800] : Colors.grey[300],
                    ),
                    _buildStatItem('المشاهدات', '1.2K'),
                  ],
                ),
              ),
            ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _menuItems[index];
                  return _buildMenuItem(item);
                },
                childCount: _menuItems.length,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.dark_mode,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'الوضع الليلي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                    activeColor: AppTheme.goldColor,
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: widget.isGuest
                      ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        }
                      : _logout,
                  icon: Icon(
                    widget.isGuest ? Icons.login : Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    widget.isGuest ? 'تسجيل الدخول' : 'تسجيل الخروج',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.goldColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        if (item['screen'] != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => item['screen']),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item['color'].withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['icon'],
                color: item['color'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
