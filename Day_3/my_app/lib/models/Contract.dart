class Contract {
  final int? contractId;
  final int userId;
  final String contractType;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;

  Contract({
    this.contractId,
    required this.userId,
    required this.contractType,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
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
    );
  }
}
