import 'package:equatable/equatable.dart';
import 'package:my_app/models/contract.dart';

abstract class ContractState extends Equatable {
  const ContractState();

  @override
  List<Object> get props => [];
}

class ContractInitial extends ContractState {}

class ContractLoading extends ContractState {}

class ContractLoaded extends ContractState {
  final List<Contract> contracts;

  const ContractLoaded(this.contracts);

  @override
  List<Object> get props => [contracts];
}

class ContractError extends ContractState {
  final String message;

  const ContractError(this.message);

  @override
  List<Object> get props => [message];
}

class ContractSynced extends ContractState {
  final String message;

  const ContractSynced([this.message = "Đồng bộ thành công"]);

  @override
  List<Object> get props => [message];
}
