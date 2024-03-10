// import 'package:dio/dio.dart';
// import 'package:safe_return/Features/profileView/data/repositories/user_repo.dart';
// import 'package:safe_return/core/errors/failures.dart';
// import 'package:safe_return/core/utils/api_services.dart';

// class UserRepoImpl implements UserRepo {
//   @override
//   Future getUserData() async {
//     try {
//       await GetUserService(Dio()).getUser();
//     } catch (e) {
//       if (e is DioException) {
//         return ServerFailure.fromDioException(e);
//       } else {
//         return ServerFailure(e.toString());
//       }
//     }
//   }
// }
