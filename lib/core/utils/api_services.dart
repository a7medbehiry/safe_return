import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:safe_return/Features/profileView/data/models/get_user_model/get_user_model.dart';
import '../../Features/auth/data/models/error_message_model.dart';
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
        ErrorMessageModel.fromJson(jsonDecode(response.data));
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
        ErrorMessageModel.fromJson(jsonDecode(response.data));
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

class ForgetPasswordService {
  final Dio dio;
  ForgetPasswordService(this.dio);

  Future<void> userForgetPassword({
    required String email,
  }) async {
    try {
      Response response = await dio.post(
        '${baseUrl}auth/forgetpassword',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode({
          "email": email,
        }),
      );
      if (response.statusCode == 200) {
        log(json.encode(response.data));
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

class ResetPasswordService {
  final Dio dio;
  ResetPasswordService(this.dio);

  Future<void> userResetPassword({
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    try {
      Response response = await dio.post(
        '${baseUrl}auth/resetpassword/$resetPasswordToken',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token",
          },
        ),
        data: json.encode({
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );
      if (response.statusCode == 200) {
        log('Reset Password Success: ${json.encode(response.data)}');
      } else {
        log('Reset Password Failure: ${json.encode(response.statusMessage)}');
        throw Exception(
            'Reset Password failed with status ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('Dio error: ${e.message}');
      throw Exception('Oops, there was an error, please try again');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Oops, there was an unexpected error, please try again');
    }
  }
}

class GetUserService {
  final Dio dio;
  GetUserService(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('Request: ${options.method} ${options.path}');
          log('Headers: ${options.headers}');
          log('Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response: ${response.statusCode}');
          log('Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('DioError: $e');
          return handler.next(e);
        },
      ),
    );
  }

  Future<GetUserModel> getUser() async {
    try {
      Response response = await dio.get(
        '${baseUrl}user/',
        options: Options(
          headers: {
            'token': tokenAccess,
          },
        ),
      );
      if (response.statusCode == 201) {
        log(json.encode(response.data));
        log('Response status code: ${response.statusCode}');
        log('Response data: ${json.encode(response.data)}');
        final Map<String, dynamic> jsonData = response.data;
        return GetUserModel.fromJson(jsonData);
      } else {
        log('Response status code: ${response.statusCode}');
        log(json.encode(response.statusMessage));
        throw Exception('Failed to get user data');
      }
    } on DioException catch (e) {
      log('DioException: ${e.message}');
      final String errorMessage = e.response?.data['error']['message'] ??
          'Oops, there was an error. Please try again.';
      throw Exception(errorMessage);
    }
  }
}

class UpdateUserService {
  final Dio dio;
  UpdateUserService(this.dio);

  Future<void> updateUser({
    required String userName,
    required String phoneNumber,
    required String governorate,
    required DateTime dob,
  }) async {
    try {
      Response response = await dio.request(
        '${baseUrl}user/',
        options: Options(
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'token': tokenAccess,
          },
        ),
        data: json.encode({
          "userName": userName,
          "phoneNumber": phoneNumber,
          "governorate": governorate,
          "DOB": dob.toIso8601String(),
        }),
      );
      if (response.statusCode == 200) {
        log(json.encode(response.data));
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

class UserPictureService {
  final Dio dio;
  UserPictureService(
    this.dio,
  );

  Future<void> uploadProfilePicture(File imageFile) async {
    try {
      FormData formData = FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        },
      );

      Response response = await dio.post(
        'http://10.0.2.2:3000l/user/profilePic',
        data: formData,
        options: Options(
          headers: {'token': tokenAccess},
        ),
      );

      if (response.statusCode == 200) {
        log('Profile picture uploaded successfully');
        log(json.encode(response.data));
      } else {
        log('Failed to upload profile picture');
        log(json.encode(response.statusMessage));
      }
    } catch (e) {
      log('Error uploading profile picture: $e');
    }
  }
}

class LogOutService {
  final Dio dio;
  LogOutService(this.dio);

  Future<void> userLogOut() async {
    try {
      Response response = await dio.post(
        '${baseUrl}user',
        options: Options(
          headers: {'token': tokenAccess},
        ),
      );
      if (response.statusCode == 200) {
        log(json.encode(response.data));
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
