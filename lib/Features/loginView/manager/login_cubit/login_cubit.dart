import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/core/utils/api_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      await LoginService(Dio()).userLogin(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } catch (e) {
      final errorMessage = _getErrorMessage(e.toString());
      emit(
        LoginFailure(
          errorMessages: [
            {'message': errorMessage},
          ],
        ),
      );
    }
  }

  String _getErrorMessage(String error) {
    switch (error) {
      case 'account already exists':
        return 'account already exists';
      case 'incorrect email or password':
        return 'incorrect email or password';
      case 'unverified email,Please verify it and try again':
        return 'unverified email,Please verify it and try again';
      case 'error in token or error not provided':
        return 'error in token or error not provided';
      case 'user not found':
        return 'user not found';
      case 'invalid token':
        return 'invalid token';
      case 'user not exist':
        return 'user not exist';
      case 'email not exist':
        return 'email not exist';
      case 'password must match confirm password':
        return 'password must match confirm password';
      case 'In-valid email':
        return 'In-valid email';
      default:
        return 'incorrect email or password';
    }
  }
}
