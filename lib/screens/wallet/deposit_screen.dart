import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  String? _selectedMethod;

  final List<Map<String, dynamic>> _methods = [
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance},
    {'name': 'محفظة إلكترونية', 'icon': Icons.wallet},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إيداع'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'الرصيد الحالي',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '32,450.75 ر.ي',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.goldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'المبلغ',
                suffixText: 'ر.ي',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'اختر طريقة الإيداع',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._methods.map((method) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              color: _selectedMethod == method['name']
                  ? AppTheme.goldColor.withOpacity(0.1)
                  : null,
              child: ListTile(
                leading: Icon(method['icon'], color: AppTheme.goldColor),
                title: Text(method['name']),
                trailing: _selectedMethod == method['name']
                    ? const Icon(Icons.check_circle, color: AppTheme.goldColor)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedMethod = method['name'];
                  });
                },
              ),
            )),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('إيداع'),
            ),
          ],
        ),
      ),
    );
  }
}
