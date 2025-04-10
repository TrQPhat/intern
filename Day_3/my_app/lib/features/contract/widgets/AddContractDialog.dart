import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/models/contract.dart';

Future<Contract?> addContractDialog(BuildContext context,
    {Contract? contract}) {
  final TextEditingController contractTypeController =
      TextEditingController(text: contract?.contractType ?? '');
  final TextEditingController startDateController = TextEditingController(
    text: contract != null
        ? DateFormat('dd/MM/yyyy').format(contract.startDate)
        : '',
  );
  final TextEditingController endDateController = TextEditingController(
    text: contract != null
        ? DateFormat('dd/MM/yyyy').format(contract.endDate)
        : '',
  );

  return showDialog<Contract>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(contract == null ? 'Thêm hợp đồng' : 'Cập nhật hợp đồng'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            Future<void> _selectDate(
                BuildContext context, bool isStartDate) async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (picked != null) {
                final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
                setState(() {
                  if (isStartDate) {
                    startDateController.text = formattedDate;
                  } else {
                    endDateController.text = formattedDate;
                  }
                });
              }
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: contractTypeController,
                    decoration:
                        const InputDecoration(labelText: 'Loại hợp đồng'),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      startDateController.text.isEmpty
                          ? 'Chọn ngày bắt đầu'
                          : 'Ngày bắt đầu: ${startDateController.text}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context, true),
                  ),
                  ListTile(
                    title: Text(
                      endDateController.text.isEmpty
                          ? 'Chọn ngày kết thúc'
                          : 'Ngày kết thúc: ${endDateController.text}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context, false),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            child: const Text('Hủy'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(contract == null ? 'Thêm' : 'Cập nhật'),
            onPressed: () {
              if (contractTypeController.text.isEmpty ||
                  startDateController.text.isEmpty ||
                  endDateController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Vui lòng điền đầy đủ thông tin hợp đồng')),
                );
                return;
              }

              final startDate =
                  DateFormat('dd/MM/yyyy').parse(startDateController.text);
              final endDate =
                  DateFormat('dd/MM/yyyy').parse(endDateController.text);

              if (endDate.isBefore(startDate)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Ngày kết thúc phải sau ngày bắt đầu')),
                );
                return;
              }

              final result = Contract(
                contractId: contract?.contractId ?? 0,
                userId: contract?.userId ?? 1,
                contractType: contractTypeController.text,
                startDate: startDate,
                endDate: endDate,
                status: contract?.status ?? 'active',
                createdAt: contract?.createdAt ?? DateTime.now(),
              );

              Navigator.of(context).pop(result);
            },
          ),
        ],
      );
    },
  );
}
