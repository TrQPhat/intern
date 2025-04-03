import 'package:flutter/material.dart';
import 'package:tuan_01/model/customer.dart';

class ViewDetailScreen extends StatelessWidget {
  final Customer customer;

  const ViewDetailScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chi tiết khách hàng")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("ID:", customer.id.toString()),
            const SizedBox(height: 10),
            _buildInfoRow("Họ và tên:", customer.name),
            const SizedBox(height: 10),
            _buildInfoRow("Tên đăng nhập:", customer.username),
            const SizedBox(height: 10),
            _buildInfoRow("Email:", customer.email),
            const SizedBox(height: 10),
            _buildInfoRow("Địa chỉ:", customer.getAddress()),
            const SizedBox(height: 10),
            _buildInfoRow("Số điện thoại:", customer.phone),
            const SizedBox(height: 10),
            _buildInfoRow("Website:", customer.website),
            const SizedBox(height: 10),
            _buildInfoRow("Công ty:", customer.company.name),
            _buildInfoRow("Thành phố:", customer.city ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(value)),
      ],
    );
  }
}
