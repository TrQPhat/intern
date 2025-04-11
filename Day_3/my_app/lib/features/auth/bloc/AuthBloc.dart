import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/database/user_controller.dart';
import 'package:my_app/features/auth/bloc/AuthEvent.dart';
import 'package:my_app/features/auth/bloc/AuthState.dart';
import 'package:my_app/features/auth/repositories/AuthRepository.dart';
import 'package:my_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<CheckOldLogin>((event, emit) async {
      emit(AuthLoading());

      try {
        final prefs = await SharedPreferences.getInstance();
        final userId = int.tryParse(prefs.getString('user_id') ?? "0") ?? 0;

        if (userId != null) {
          final user = await UserController.getUserById(userId);
          emit(AuthSuccess(user!));
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        print("Chưa đăng nhập___________________________________________");
        emit(AuthInitial());
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading()); // Hiển thị trạng thái loading

      if (event.username == "" || event.password == "") {
        emit(AuthFailure("Vui lòng nhập đầy đủ thông tin"));
      } else {
        try {
          final User user = await authRepository.login(
            event.username,
            event.password,
          );

          final prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('device_token');

          await authRepository.updateDeviceToken(user.id!, token!);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading()); // Hiển thị trạng thái loading

      if (event.username == "" ||
          event.password == "" ||
          event.email == "" ||
          event.full_name == "" ||
          event.confirmPassword == "") {
        emit(AuthFailure("Vui lòng nhập đầy đủ thông tin"));
      } else if (event.password != event.confirmPassword) {
        emit(AuthFailure("Mật khẩu không khớp"));
      } else {
        try {
          final User user = await authRepository.register(
            event.username,
            event.password,
            event.email,
            event.full_name,
          );
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }
    });

    on<LogOut>(
      (event, emit) async {
        final prefs = await SharedPreferences.getInstance();
        final userId = int.tryParse(prefs.getString('user_id') ?? "0") ?? 0;
        await UserController.deleteUser(userId);
        await authRepository.updateDeviceToken(userId, "offline");
        await prefs.remove('user_id');
        emit(AuthInitial());
      },
    );
  }
}
