import 'package:equatable/equatable.dart';
import 'package:my_app/models/contract.dart';

abstract class ContractEvent extends Equatable {
  const ContractEvent();

  @override
  List<Object> get props => [];
}

class LoadContracts extends ContractEvent {}

class AddContract extends ContractEvent {
  final Contract contract;

  const AddContract(this.contract);

  @override
  List<Object> get props => [contract];
}

class UpdateContract extends ContractEvent {
  final Contract contract;

  const UpdateContract(this.contract);

  @override
  List<Object> get props => [contract];
}

class DeleteContract extends ContractEvent {
  final int contractId;

  const DeleteContract(this.contractId);

  @override
  List<Object> get props => [contractId];
}

class SyncContractsFromIsar extends ContractEvent {}

class SyncContractsFromServer extends ContractEvent {}
