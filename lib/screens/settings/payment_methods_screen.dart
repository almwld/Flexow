import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طرق الدفع'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildPaymentCard(
                  type: 'بطاقة ائتمان',
                  number: '**** **** **** 1234',
                  expiry: '12/25',
                  isDefault: true,
                ),
                _buildPaymentCard(
                  type: 'بطاقة مدى',
                  number: '**** **** **** 5678',
                  expiry: '10/26',
                  isDefault: false,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('إضافة بطاقة جديدة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard({
    required String type,
    required String number,
    required String expiry,
    required bool isDefault,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.credit_card, color: AppTheme.goldColor),
        title: Text(type),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(number),
            Text('تنتهي: $expiry'),
          ],
        ),
        trailing: isDefault
            ? Chip(
                label: const Text('افتراضية'),
                backgroundColor: AppTheme.goldColor.withOpacity(0.2),
              )
            : null,
      ),
    );
  }
}
