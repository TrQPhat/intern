import 'package:isar/isar.dart';

part 'contract.g.dart';

@Collection()
class Contract {
  Id? contractId; // Đúng cú pháp rồi, không cần @Id(), vì Isar tự hiểu 'Id'

  @Name("user_id")
  final int userId;

  @Name("contract_type")
  final String contractType;

  @Name("start_date")
  final DateTime startDate;

  @Name("end_date")
  final DateTime endDate;

  final String status;

  @Name("created_at")
  final DateTime createdAt;

  @Name("sync_status")
  late String syncStatus;

  Contract({
    this.contractId,
    required this.userId,
    required this.contractType,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    this.syncStatus = 'created',
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractId: json['contract_id'],
      userId: json['user_id'],
      contractType: json['contract_type'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      syncStatus: 'synced',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contract_id': contractId,
      'user_id': userId,
      'contract_type': contractType,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
