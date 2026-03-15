import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  String _selectedFilter = 'الكل';

  final List<String> _filters = ['الكل', 'نشط', 'منتهي', 'مراجعة'];

  final List<Map<String, dynamic>> _myAds = [
    {
      'title': 'تويوتا كامري 2020',
      'price': '35,000',
      'views': 120,
      'status': 'نشط',
      'statusColor': Colors.green,
      'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3968e3bb?w=400',
      'date': '15/03/2024',
    },
    {
      'title': 'iPhone 14 Pro Max',
      'price': '250,000',
      'views': 85,
      'status': 'نشط',
      'statusColor': Colors.green,
      'image': 'https://images.unsplash.com/photo-1678685888221-cda773a3dcdb?w=400',
      'date': '10/03/2024',
    },
    {
      'title': 'شقة للإيجار - حدة',
      'price': '45,000',
      'views': 200,
      'status': 'منتهي',
      'statusColor': Colors.red,
      'image': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400',
      'date': '01/02/2024',
    },
    {
      'title': 'لابتوب Dell Gaming',
      'price': '180,000',
      'views': 45,
      'status': 'مراجعة',
      'statusColor': Colors.orange,
      'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
      'date': '20/03/2024',
    },
  ];

  List<Map<String, dynamic>> get _filteredAds {
    if (_selectedFilter == 'الكل') return _myAds;
    return _myAds.where((ad) => ad['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إعلاناتي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.goldColor
                          : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.goldColor
                            : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : (isDark ? Colors.white : Colors.black87),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('الإعلانات', _myAds.length.toString()),
                Container(width: 1, height: 40, color: Colors.grey[700]),
                _buildStatItem('النشطة', '2'),
                Container(width: 1, height: 40, color: Colors.grey[700]),
                _buildStatItem('المشاهدات', '450'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredAds.length,
              itemBuilder: (context, index) {
                final ad = _filteredAds[index];
                return _buildAdCard(ad);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.goldColor,
        child: const Icon(Icons.add, color: Colors.black),
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

  Widget _buildAdCard(Map<String, dynamic> ad) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              ad['image'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ad['statusColor'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ad['status'],
                        style: TextStyle(
                          color: ad['statusColor'],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.visibility, size: 16, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      '${ad['views']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  ad['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${ad['price']} ر.ي',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ad['date'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('تعديل'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.goldColor,
                          side: const BorderSide(color: AppTheme.goldColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.delete, size: 16),
                        label: const Text('حذف'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
