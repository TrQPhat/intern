import 'package:equatable/equatable.dart';

abstract class ContractEvent extends Equatable {
  const ContractEvent();

  @override
  List<Object> get props => [];
}

class LoadContracts extends ContractEvent {}
