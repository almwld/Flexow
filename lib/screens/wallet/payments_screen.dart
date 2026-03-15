import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final List<Map<String, dynamic>> _services = [
    {'name': 'فاتورة الكهرباء', 'icon': Icons.electric_bolt},
    {'name': 'فاتورة المياه', 'icon': Icons.water_drop},
    {'name': 'فاتورة الانترنت', 'icon': Icons.wifi},
    {'name': 'فاتورة الهاتف', 'icon': Icons.phone},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دفع الفواتير'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(service['icon'], color: AppTheme.goldColor),
              title: Text(service['name']),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
