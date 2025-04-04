import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/database/db_helper.dart';
import 'package:my_app/features/contract/bloc/ContractEvent.dart';
import 'package:my_app/features/contract/bloc/ContractState.dart';
import 'package:my_app/models/contract.dart';
import 'package:my_app/features/contract/repositories/ContractRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractRepository repository;
  List<Contract> listContract = [];

  ContractBloc(this.repository) : super(ContractInitial()) {
    on<LoadContracts>((event, emit) async {
      emit(ContractLoading());

      try {
        WidgetsFlutterBinding.ensureInitialized();
        final prefs = await SharedPreferences.getInstance();
        final savedTime = prefs.getInt('lastApiCallTime');
        DateTime savedDateTime =
            DateTime.fromMillisecondsSinceEpoch(savedTime ?? 0);
        DateTime currentDateTime = DateTime.now();
        Duration difference = currentDateTime.difference(savedDateTime);
        if (difference.inMinutes < 5) {
          //lấy từ database
          print("chua duoc 5 phut__________________________________________");
          listContract = await DBHelper.getAllContracts();
          emit(ContractLoaded(listContract));

          return;
        } else {
          print("da duoc 5 phut__________________________________________");
          listContract = await repository.getContracts();
          emit(ContractLoaded(listContract));
        }
      } catch (e) {
        emit(ContractError(e.toString()));
        print("Error: ${e.toString()}");
      }
    });
  }
}
