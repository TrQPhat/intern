// features/home/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/database/contract_controller.dart';
import 'package:my_app/features/auth/screen/LoginScreen.dart';
import 'package:my_app/features/contract/bloc/ContractBloc.dart';
import 'package:my_app/features/contract/bloc/ContractEvent.dart';
import 'package:my_app/features/contract/bloc/ContractState.dart';
import 'package:my_app/features/contract/widgets/AddContractDialog.dart';
import 'package:my_app/models/contract.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () {
    //   context.read<ContractBloc>().add(LoadContracts());
    // });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Hợp Đồng'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ContractBloc>().add(LoadContracts());
            },
          ),
        ],
      ),
      body: BlocBuilder<ContractBloc, ContractState>(
        builder: (context, state) {
          if (state is ContractLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContractError) {
            return Center(child: Text(state.message));
          } else if (state is ContractLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text("Đăng xuất"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await addContractDialog(context);

                        if (result != null) {
                          context.read<ContractBloc>().add(AddContract(result));
                        }
                      },
                      child: Text("Tạo hợp đồng"),
                    ),
                  ],
                ),
                Expanded(child: _buildContractList(state.contracts)),
              ],
            );
          } else {
            return const Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }

  Widget _buildContractList(List<Contract> contracts) {
    return ListView.builder(
      itemCount: contracts.length,
      itemBuilder: (context, index) {
        final contract = contracts[index];
        return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onDoubleTap: () async {
                final result = await addContractDialog(context,
                    contract: contracts[index]);

                if (result != null) {
                  context.read<ContractBloc>().add(UpdateContract(result));
                }
              },
              child: ListTile(
                title: Text(
                  'Hợp đồng ${contract.contractId}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Loại: ${contract.contractType}'),
                    Text('Trạng thái: ${contract.status}'),
                    Text(
                      'Thời hạn: ${_formatDate(contract.startDate)} - ${_formatDate(contract.endDate)}',
                    ),
                  ],
                ),
                trailing: _buildStatusIcon(contract.status),
                onTap: () {
                  // Xử lý khi nhấn vào hợp đồng
                  _showContractDetails(context, contract);
                },
                onLongPress: () async {
                  if (contracts[index].contractId != null) {
                    bool? confirmDelete = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Xác nhận xóa'),
                          content:
                              Text('Bạn có chắc chắn muốn xóa hợp đồng này?'),
                          actions: [
                            TextButton(
                              child: Text('Hủy'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: Text('Xóa',
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmDelete == true) {
                      await ContractController.deleteContract(
                          contracts[index].contractId!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Đã xóa hợp đồng')),
                      );
                      context.read<ContractBloc>().add(LoadContracts());
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('ID của hợp đồng null')),
                    );
                  }
                },
              ),
            ));
      },
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;

    switch (status.toLowerCase()) {
      case 'active':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'pending':
        icon = Icons.pending;
        color = Colors.orange;
        break;
      case 'expired':
        icon = Icons.warning;
        color = Colors.red;
        break;
      default:
        icon = Icons.help;
        color = Colors.grey;
    }

    return Icon(icon, color: color);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showContractDetails(BuildContext context, Contract contract) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chi tiết hợp đồng ${contract.contractId}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Mã hợp đồng', "${contract.contractId}"),
              _buildDetailRow('Mã người dùng', "${contract.userId}"),
              _buildDetailRow('Loại hợp đồng', contract.contractType),
              _buildDetailRow(
                'Ngày bắt đầu',
                _formatDate(contract.startDate),
              ),
              _buildDetailRow(
                'Ngày kết thúc',
                _formatDate(contract.endDate),
              ),
              _buildDetailRow('Trạng thái', contract.status),
              _buildDetailRow('Ngày tạo', _formatDate(contract.createdAt)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
