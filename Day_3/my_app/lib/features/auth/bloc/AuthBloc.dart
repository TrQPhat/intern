import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/auth/bloc/AuthEvent.dart';
import 'package:my_app/features/auth/bloc/AuthState.dart';
import 'package:my_app/features/auth/repositories/AuthRepository.dart';
import 'package:my_app/models/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
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
  }
}
