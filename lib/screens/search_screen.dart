import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedCity;
  RangeValues _priceRange = const RangeValues(0, 1000000);

  final List<String> _recentSearches = [
    'سيارات تويوتا',
    'شقق للإيجار',
    'iPhone',
    'لابتوب',
  ];

  final List<String> _categories = [
    'الكل',
    'سيارات',
    'عقارات',
    'إلكترونيات',
    'أثاث',
    'ملابس',
    'مطاعم',
    'خدمات',
  ];

  final List<String> _cities = [
    'الكل',
    'صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'المكلا',
    'إب',
  ];

  final List<Map<String, dynamic>> _searchResults = [
    {
      'title': 'تويوتا كامري 2020',
      'price': '35,000',
      'location': 'صنعاء',
      'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3968e3bb?w=400',
    },
    {
      'title': 'تويوتا هايلوكس 2019',
      'price': '45,000',
      'location': 'عدن',
      'image': 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
    },
    {
      'title': 'تويوتا كورولا 2021',
      'price': '28,000',
      'location': 'تعز',
      'image': 'https://images.unsplash.com/photo-1629897048514-3dd74151ae2b?w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          textAlign: TextAlign.right,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'ابحث عن...',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: isDark ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
          onSubmitted: (value) {
            // Perform search
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    label: _selectedCategory ?? 'الفئة',
                    icon: Icons.category,
                    onTap: () => _showCategoryFilter(),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: _selectedCity ?? 'المدينة',
                    icon: Icons.location_on,
                    onTap: () => _showCityFilter(),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: 'السعر',
                    icon: Icons.attach_money,
                    onTap: () => _showPriceFilter(),
                  ),
                ],
              ),
            ),
          ),
          if (_searchController.text.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عمليات البحث الأخيرة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _recentSearches.clear();
                          });
                        },
                        child: const Text('مسح الكل'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _recentSearches.map((search) {
                      return GestureDetector(
                        onTap: () {
                          _searchController.text = search;
                        },
                        child: Chip(
                          label: Text(search),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            setState(() {
                              _recentSearches.remove(search);
                            });
                          },
                          backgroundColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ] else ...[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final result = _searchResults[index];
                  return _buildResultCard(result);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppTheme.goldColor),
            const SizedBox(width: 4),
            Text(label),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> result) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(16),
            ),
            child: Image.network(
              result['image'],
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${result['price']} ر.ي',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.goldColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        result['location'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'اختر الفئة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : null;
                      });
                      Navigator.of(context).pop();
                    },
                    selectedColor: AppTheme.goldColor,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCityFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'اختر المدينة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _cities.map((city) {
                  final isSelected = _selectedCity == city;
                  return ChoiceChip(
                    label: Text(city),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCity = selected ? city : null;
                      });
                      Navigator.of(context).pop();
                    },
                    selectedColor: AppTheme.goldColor,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPriceFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'نطاق السعر',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000000,
                    divisions: 100,
                    labels: RangeLabels(
                      '${_priceRange.start.round()}',
                      '${_priceRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_priceRange.start.round()} ر.ي'),
                      Text('${_priceRange.end.round()} ر.ي'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldColor,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('تطبيق'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
