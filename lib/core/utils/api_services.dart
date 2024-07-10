import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/Features/profileView/data/models/get_user_model/get_user_model.dart';
import '../../Features/homeView/data/models/get_missing_form_model/get_missing_form_model.dart';
import '../../Features/homeView/data/models/get_one_find_form_model/get_one_find_form_model.dart';
import '../../Features/homeView/data/models/get_one_missing_form_model/get_one_missing_form_model.dart';
import '../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Features/notificationView/data/get_notifications_model/get_notifications_model.dart';

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
      if (response.statusCode == 201) {
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

class LoginService {
  final Dio dio;
  LoginService(this.dio) {
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
      if (response.statusCode == 201) {
        log(json.encode(response.data));
        _saveToken(response.data['token']);
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

  _saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    const key = "token";
    final value = token;
    pref.setString(key, value);
  }

  readToken() async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    log('readToken: $token');
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
        _saveToken(response.data['accesstoken']);
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

  _saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    const key = "accesstoken";
    final value = token;
    pref.setString(key, value);
  }
}

class CheckMailService {
  final Dio dio;
  CheckMailService(this.dio);

  Future<void> checkMail({
    required String resetCode,
  }) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'accesstoken';
    final accessToken = pref.get(key);
    try {
      Response response = await dio.post(
        '${baseUrl}auth/checkResetCode',
        options: Options(
          headers: {
            'accesstoken': accessToken,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode({
          "resetCode": resetCode,
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
      log(e.toString());
      log('Dio error: ${e.message}');
      throw Exception('Oops, there was an error, please try again');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Oops, there was an unexpected error, please try again');
    }
  }
}

class ResetPasswordService {
  final Dio dio;
  ResetPasswordService(this.dio);

  Future<void> userResetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'accesstoken';
    final accessToken = pref.get(key);
    try {
      Response response = await dio.post(
        '${baseUrl}auth/resetpassword',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'accesstoken': accessToken,
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
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.get(
        '${baseUrl}user/',
        options: Options(
          headers: {
            'token': token,
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
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.request(
        '${baseUrl}user/',
        options: Options(
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'token': token,
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
  UserPictureService(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.validateStatus = (status) => true;
          handler.next(options);
        },
      ),
    );
  }

  Future<void> userPicture({required File picture}) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      FormData formData = FormData.fromMap(
        {
          'image': [
            await MultipartFile.fromFile(
              picture.path,
              filename: picture.path.split('/').last,
            ),
          ],
        },
      );

      Response response = await dio.patch(
        '${baseUrl}user/profilePic',
        data: formData,
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      log('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        log('Profile picture uploaded successfully');
        log('Response Data: ${json.encode(response.data)}');
      } else {
        log('Failed to upload profile picture');
        log('Error Message: ${json.encode(response.statusMessage)}');
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
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.post(
        '${baseUrl}user',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 201) {
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

class GoogleLoginService {
  final Dio dio;
  GoogleLoginService(this.dio);

  Future<void> googleLogin({
    required String email,
    required String? userName,
  }) async {
    try {
      Response response = await dio.post(
        '${baseUrl}auth/loginWithGmail',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode({
          "email": email,
          "userName": userName,
        }),
      );

      if (response.statusCode == 200) {
        log(json.encode(response.data));
        _saveToken(response.data['token']);
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

  _saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    const key = "token";
    final value = token;
    pref.setString(key, value);
  }

  readToken() async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    log('readToken: $token');
  }
}

class FaceBookLoginService {
  final Dio dio;
  FaceBookLoginService(this.dio);

  Future<void> facebookLogin({
    required String accountId,
    required String? userName,
  }) async {
    try {
      Response response = await dio.post(
        '${baseUrl}auth/loginWithFacebook',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode({
          "accountId": accountId,
          "userName": userName,
        }),
      );

      if (response.statusCode == 200) {
        log(json.encode(response.data));
        _saveToken(response.data['token']);
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

  _saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    const key = "token";
    final value = token;
    pref.setString(key, value);
  }

  readToken() async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    log('readToken: $token');
  }
}

class FindPersonService {
  final Dio dio;
  FindPersonService(this.dio);

  Future<void> findForm({
    required File image,
    required String fName,
    required String lName,
    required String phoneNumber,
    required String name,
    required int age,
    required DateTime dob,
    required String governorate,
    String? description,
  }) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.post(
        '${baseUrl}foundReport/',
        options: Options(
          headers: {
            'token': token,
          },
        ),
        data: FormData.fromMap(
          {
            "image": [
              await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
              ),
            ],
            "firstReporterName": fName,
            "lastReporterName": lName,
            "phoneNumber": phoneNumber,
            "childName": name,
            "age": age,
            "date": dob.toIso8601String(),
            "governorate": governorate,
            "description": description,
          },
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

class GetFindFormService {
  final Dio dio;
  GetFindFormService(this.dio) {
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

  Future<GetFindFormModel> getFindForm() async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.get(
        '${baseUrl}foundReport/',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 201) {
        log(json.encode(response.data));
        log('Response status code: ${response.statusCode}');
        log('Response data: ${json.encode(response.data)}');
        final Map<String, dynamic> jsonData = response.data;
        return GetFindFormModel.fromJson(jsonData);
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

class GetOneFindFormService {
  final Dio dio;
  GetOneFindFormService(this.dio) {
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

  Future<GetOneFindFormModel> getOneFindForm({required String? id}) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.get(
        '${baseUrl}foundReport/$id',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 201) {
        log(json.encode(response.data));
        log('Response status code: ${response.statusCode}');
        log('Response data: ${json.encode(response.data)}');
        final Map<String, dynamic> jsonData = response.data;
        return GetOneFindFormModel.fromJson(jsonData);
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

class UpdateFindPersonService {
  final Dio dio;
  UpdateFindPersonService(this.dio);

  Future<void> updateFindForm({
    required String? id,
    File? image,
    String? fName,
    String? lName,
    String? phoneNumber,
    String? name,
    int? age,
    DateTime? dob,
    String? governorate,
    String? description,
  }) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.put(
        '${baseUrl}foundReport/$id',
        options: Options(
          headers: {
            'token': token,
          },
        ),
        data: FormData.fromMap(
          {
            "image": [
              await MultipartFile.fromFile(
                image!.path,
                filename: image.path.split('/').last,
              ),
            ],
            "firstReporterName": fName,
            "lastReporterName": lName,
            "phoneNumber": phoneNumber,
            "childName": name,
            "age": age,
            "date": dob?.toIso8601String(),
            "governorate": governorate,
            "description": description,
          },
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

class DeleteFindReportService {
  final Dio dio;
  DeleteFindReportService(this.dio) {
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

  Future<void> deleteFindReport({required String? id}) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.delete(
        '${baseUrl}foundReport/$id',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 201) {
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

class MissingPersonService {
  final Dio dio;
  MissingPersonService(this.dio);

  Future<void> missingForm({
    required String fName,
    required String lName,
    required String phoneNumber,
    required String email,
    required String nId,
    required DateTime dob,
    required String governorate,
  }) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.post(
        '${baseUrl}missingReport',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          },
        ),
        data: json.encode({
          "firstReporterName": fName,
          "lastReporterName": lName,
          "phoneNumber": phoneNumber,
          "email": email,
          "nationalID": nId,
          "governorate": governorate,
          "date": dob.toIso8601String(),
        }),
      );
      if (response.statusCode == 201) {
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

class GetMissingFormService {
  final Dio dio;
  GetMissingFormService(this.dio) {
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

  Future<GetMissingFormModel> getMissingForm() async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.get(
        '${baseUrl}missingReport',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 201) {
        log(json.encode(response.data));
        log('Response status code: ${response.statusCode}');
        log('Response data: ${json.encode(response.data)}');
        final Map<String, dynamic> jsonData = response.data;
        return GetMissingFormModel.fromJson(jsonData);
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

class GetOneMissingFormService {
  final Dio dio;
  GetOneMissingFormService(this.dio) {
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

  Future<GetOneMissingFormModel> getOneMissingForm(
      {required String? id}) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.get(
        '${baseUrl}missingReport/$id',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 201) {
        log(json.encode(response.data));
        log('Response status code: ${response.statusCode}');
        log('Response data: ${json.encode(response.data)}');
        final Map<String, dynamic> jsonData = response.data;
        return GetOneMissingFormModel.fromJson(jsonData);
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

class UpdateMissingPersonService {
  final Dio dio;
  UpdateMissingPersonService(this.dio);

  Future<void> updateMissingForm({
    required String? id,
    String? fName,
    String? lName,
    String? phoneNumber,
    String? email,
    String? nId,
    DateTime? dob,
    String? governorate,
  }) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.put(
        '${baseUrl}missingReport/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          },
        ),
        data: json.encode({
          "firstReporterName": fName,
          "lastReporterName": lName,
          "phoneNumber": phoneNumber,
          "email": email,
          "nationalID": nId,
          "governorate": governorate,
          "date": dob?.toIso8601String(),
        }),
      );
      if (response.statusCode == 201) {
        log(json.encode(response.data));
      } else {
        log(json.encode(response.statusMessage));
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ?? 'oops there was an error';
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops there was an error');
    }
  }
}

class DeleteMissingReportService {
  final Dio dio;
  DeleteMissingReportService(this.dio);

  Future<void> deleteMissingReport({required String? id}) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.delete(
        '${baseUrl}missingReport/$id',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 201) {
        log(json.encode(response.data));
      } else {
        log(json.encode(response.statusMessage));
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ?? 'oops there was an error';
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops there was an error');
    }
  }
}

class PushNotificationsService {
  final Dio dio;
  PushNotificationsService(this.dio);

  Future<void> pushNotifications() async {
    try {
      final pref = await SharedPreferences.getInstance();
      const key = 'token';
      final token = pref.getString(key);

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      var fcmToken = preferences.getString('fcmToken');

      if (token == null || fcmToken == null) {
        throw Exception('Token or FCM token is null');
      }

      Response response = await dio.post(
        '${baseUrl}notification/registerDeviceToken',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          },
        ),
        data: json.encode({
          "deviceToken": fcmToken,
        }),
      );

      if (response.statusCode == 201) {
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

class GetNotificationsService {
  final Dio dio;
  GetNotificationsService(this.dio) {
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

  Future<GetNotificationsModel> getNotifications() async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.get(
        '${baseUrl}notification/getAllNotifications',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      if (response.statusCode == 200) {
        log(json.encode(response.data));
        log('Response status code: ${response.statusCode}');
        log('Response data: ${json.encode(response.data)}');
        final Map<String, dynamic> jsonData = response.data;
        return GetNotificationsModel.fromJson(jsonData);
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

class DeleteNotificationService {
  final Dio dio;
  DeleteNotificationService(this.dio) {
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

  Future<void> deleteNotification({required String? id}) async {
    final pref = await SharedPreferences.getInstance();
    const key = 'token';
    final token = pref.get(key);
    try {
      Response response = await dio.delete(
        '${baseUrl}notification/deleteNotification/$id',
        options: Options(
          headers: {
            'token': token,
          },
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
