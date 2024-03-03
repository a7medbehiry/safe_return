import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:safe_return/Features/loginView/presentation/data/models/login_error_message_model.dart';
import 'package:safe_return/Features/signUpView/presentation/data/models/sign_up_error_message_model.dart';
import '../../constants.dart';

class SignUpService {
  final Dio dio;
  SignUpService(this.dio);

  Future<void> userSignUp({
    required String fName,
    required String lName,
    required String email,
    required String password,
    required String confirmPassword,
    required DateTime dob,
    required Gender gender,
  }) async {
    try {
      Response response = await dio.post(
        '${baseUrl}auth/signUp',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode({
          "Fname": fName,
          "Lname": lName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "DOB": dob.toIso8601String(),
          "gender": gender.toString().split('.').last,
        }),
      );
      if (response.statusCode == 200) {
        log(json.encode(response.data));
        SignUPErrorMessageModel.fromJson(jsonDecode(response.data));
      } else {
        log(json.encode(response.statusMessage));
      }
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops there was an error, please try again';
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops there was an error, please try again');
    }
  }
}

class LoginService {
  final Dio dio;
  LoginService(this.dio);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        '${baseUrl}auth/signIn',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode({
          "email": email,
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        log(json.encode(response.data));
        LoginErrorMessageModel.fromJson(jsonDecode(response.data));
      } else {
        log(json.encode(response.statusMessage));
      }
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops there was an error, please try again';
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops there was an error, please try again');
    }
  }
}
