import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/database/contract_controller.dart';
import 'package:my_app/features/contract/bloc/ContractEvent.dart';
import 'package:my_app/features/contract/bloc/ContractState.dart';
import 'package:my_app/models/contract.dart';
import 'package:my_app/features/contract/repositories/ContractRepository.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractRepository repository;
  List<Contract> listContract = [];

  ContractBloc(this.repository) : super(ContractInitial()) {
    on<LoadContracts>((event, emit) async {
      emit(ContractLoading());

      try {
        listContract = await ContractController.getAllContracts();
        emit(ContractLoaded(listContract));
      } catch (e) {
        emit(ContractError(e.toString()));
        print("Error: ${e.toString()}");
      }
    });

    on<AddContract>((event, emit) async {
      emit(ContractLoading());
      try {
        await ContractController.addContract(event.contract);
        final contracts = await ContractController.getAllContracts();
        emit(ContractLoaded(contracts));
      } catch (e) {
        emit(ContractError("Thêm hợp đồng thất bại: $e"));
      }
    });

    on<DeleteContract>((event, emit) async {
      emit(ContractLoading());
      try {
        await ContractController.deleteContract(event.contractId);
        final contracts = await ContractController.getAllContracts();
        emit(ContractLoaded(contracts));
      } catch (e) {
        emit(ContractError("Xóa hợp đồng thất bại: $e"));
      }
    });

    on<UpdateContract>((event, emit) async {
      emit(ContractLoading());
      try {
        await ContractController.updateContract(event.contract);
        final contracts = await ContractController.getAllContracts();
        print("Đã đồng bộ dữ liệu, ${DateTime.now()}");
        emit(ContractLoaded(contracts));
      } catch (e) {
        emit(ContractError("Cập nhật hợp đồng thất bại: $e"));
      }
    });

    on<SyncContractsFromIsar>((event, emit) async {
      //emit(ContractLoading());

      try {
        final contractsToSync = await ContractController.getUnsyncedContracts();

        await repository.syncContractsToServer(contractsToSync);

        // final newContracts = await repository.getContracts();

        // await ContractController.saveContracts(newContracts);

        //emit(ContractLoaded(newContracts));
      } catch (e) {
        emit(ContractError("Đồng bộ thất bại: $e"));
      }
    });

    on<SyncContractsFromServer>((event, emit) async {
      emit(ContractLoading());

      try {
        final newContracts = await repository.getContracts();
        await ContractController.clearContract();
        await ContractController.saveContracts(newContracts);

        emit(ContractLoaded(await ContractController.getAllContracts()));
      } catch (e) {
        emit(ContractError("Đồng bộ thất bại: $e"));
      }
    });
  }
}
