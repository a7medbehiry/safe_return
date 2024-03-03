import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/api_services.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

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
      final errorMessage = _getErrorMessage(e.toString());
      emit(
        SignUpFailure(
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
        return 'account already exists';
    }
  }
}
