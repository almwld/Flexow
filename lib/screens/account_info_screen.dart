import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final _nameController = TextEditingController(text: 'أحمد محمد');
  final _emailController = TextEditingController(text: 'ahmed@example.com');
  final _phoneController = TextEditingController(text: '777123456');
  final _addressController = TextEditingController(text: 'صنعاء، حدة');

  String? _selectedCity = 'صنعاء';
  bool _isEditing = false;

  final List<String> _yemenCities = [
    'صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'المكلا',
    'إب',
    'سيئون',
    'ذمار',
    'عمران',
    'البيضاء',
    'حجة',
    'لحج',
    'أبين',
    'شبوة',
    'مأرب',
    'الجوف',
    'صعدة',
    'حضرموت',
    'المهرة',
    'سقطرى',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات الحساب'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
              if (!_isEditing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم حفظ التغييرات بنجاح'),
                    backgroundColor: AppTheme.success,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.goldColor, AppTheme.goldLight],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.goldColor,
                        width: 4,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: AppTheme.goldColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (_isEditing)
              TextButton(
                onPressed: () {},
                child: const Text('تغيير الصورة'),
              ),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: 'المعلومات الشخصية',
              children: [
                _buildTextField(
                  label: 'الاسم الكامل',
                  controller: _nameController,
                  icon: Icons.person,
                  enabled: _isEditing,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'البريد الإلكتروني',
                  controller: _emailController,
                  icon: Icons.email,
                  enabled: _isEditing,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'رقم الهاتف',
                  controller: _phoneController,
                  icon: Icons.phone,
                  enabled: _isEditing,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'معلومات الموقع',
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  decoration: InputDecoration(
                    labelText: 'المدينة',
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabled: _isEditing,
                  ),
                  items: _yemenCities.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: _isEditing
                      ? (value) {
                          setState(() {
                            _selectedCity = value;
                          });
                        }
                      : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'العنوان التفصيلي',
                  controller: _addressController,
                  icon: Icons.location_on,
                  enabled: _isEditing,
                  maxLines: 2,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'إحصائيات الحساب',
              children: [
                _buildStatRow('تاريخ الانضمام', '15 يناير 2024'),
                const Divider(),
                _buildStatRow('عدد الإعلانات', '12 إعلان'),
                const Divider(),
                _buildStatRow('التقييم', '4.8 ⭐'),
                const Divider(),
                _buildStatRow('حالة الحساب', 'نشط', valueColor: Colors.green),
              ],
            ),
            const SizedBox(height: 24),
            if (_isEditing)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock_outline),
                  label: const Text('تغيير كلمة المرور'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.goldColor,
                    side: const BorderSide(color: AppTheme.goldColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.goldColor,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool enabled,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: !enabled,
        fillColor: enabled ? null : Colors.grey[900],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {Color? valueColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? (isDark ? Colors.white : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
