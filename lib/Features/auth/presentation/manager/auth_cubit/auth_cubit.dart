import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/api_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  userSignUp({
    required String fName,
    required String lName,
    required String email,
    required String password,
    required String confirmPassword,
    required DateTime dob,
    required Gender gender,
  }) async {
    emit(SignUpLoading());

    try {
      await SignUpService(Dio()).userSignUp(
        fName: fName,
        lName: lName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        dob: dob,
        gender: gender,
      );
      emit(SignUpSuccess());
    } catch (e) {
      final errorMessage = _getSignUpErrorMessage(e.toString());
      emit(
        SignUpFailure(
          errorMessages: [
            {'message': errorMessage},
          ],
        ),
      );
    }
  }

  String _getSignUpErrorMessage(String error) {
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
        return 'account already exists';
    }
  }

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
      final errorMessage = _getLoginErrorMessage(e.toString());
      emit(
        LoginFailure(
          errorMessages: [
            {'message': errorMessage},
          ],
        ),
      );
    }
  }

  String _getLoginErrorMessage(String error) {
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

  // googleLogin() async {
  //   emit(GoogleLoginLoading());
  //   try {
  //     await GoogleLoginService(Dio()).googleLogin();
  //     emit(GoogleLoginSuccess());
  //   } catch (e) {
      
  //     emit(
  //       GoogleLoginFailure(
  //         errorMessages: 'Google login failed',
  //       ),
  //     );
  //   }
  // }

  userForgetPassword({
    required String email,
  }) async {
    emit(ForgetPasswordLoading());

    try {
      await ForgetPasswordService(Dio()).userForgetPassword(
        email: email,
      );
      emit(ForgetPasswordSuccess());
    } catch (e) {
      final errorMessage = _getForgetPasswordErrorMessage(e.toString());
      emit(
        ForgetPasswordFailure(
          errorMessages: [
            {'message': errorMessage},
          ],
        ),
      );
    }
  }

  String _getForgetPasswordErrorMessage(String error) {
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
        return 'email not exist';
    }
  }

  userResetPassword(
      {required String password,
      required String confirmPassword,
      required String token}) async {
    emit(ResetPasswordLoading());

    try {
      await ResetPasswordService(Dio()).userResetPassword(
        password: password,
        confirmPassword: confirmPassword,
        token: "Bearer $resetPasswordToken",
      );
      emit(ResetPasswordSuccess());
    } catch (e) {
      final errorMessage = _getResetPasswordErrorMessage(e.toString());
      emit(
        ResetPasswordFailure(
          errorMessages: [
            {'message': errorMessage},
          ],
        ),
      );
    }
  }

  String _getResetPasswordErrorMessage(String error) {
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
        return 'jwt expired';
    }
  }
}
