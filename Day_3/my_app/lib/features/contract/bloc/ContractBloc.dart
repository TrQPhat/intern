import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/contract/bloc/ContractEvent.dart';
import 'package:my_app/features/contract/bloc/ContractState.dart';
import 'package:my_app/models/Contract.dart';
import 'package:my_app/features/contract/repositories/ContractRepository.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractRepository repository;
  List<Contract> listContract = [];

  ContractBloc(this.repository) : super(ContractInitial()) {
    on<LoadContracts>((event, emit) async {
      emit(ContractLoading());

      try {
        final List<Contract> listContract = await repository.getContracts();
        emit(ContractLoaded(listContract));
      } catch (e) {
        emit(ContractError(e.toString()));
      }
    });
  }
}
