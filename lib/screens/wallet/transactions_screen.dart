import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {'name': 'تحويل إلى أحمد', 'amount': -500, 'date': 'اليوم', 'icon': Icons.send, 'currency': 'ر.ي'},
    {'name': 'إيداع نقدي', 'amount': 5000, 'date': 'أمس', 'icon': Icons.add, 'currency': 'ر.ي'},
    {'name': 'شراء من متجر', 'amount': -1200, 'date': 'أمس', 'icon': Icons.shopping_cart, 'currency': 'ر.س'},
    {'name': 'استلام تحويل', 'amount': 10000, 'date': '22/03', 'icon': Icons.arrow_downward, 'currency': 'ر.ي'},
    {'name': 'دفع فاتورة', 'amount': -3500, 'date': '20/03', 'icon': Icons.receipt, 'currency': 'ر.ي'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل العمليات'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final tx = _transactions[index];
          final isPositive = tx['amount'] > 0;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  tx['icon'],
                  color: isPositive ? Colors.green : Colors.red,
                  size: 20,
                ),
              ),
              title: Text(tx['name']),
              subtitle: Text('${tx['date']} • ${tx['currency']}'),
              trailing: Text(
                '${isPositive ? '+' : ''}${tx['amount'].toStringAsFixed(0)}',
                style: TextStyle(
                  color: isPositive ? Colors.green : (isDark ? Colors.white : Colors.black87),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
