import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/core/utils/api_services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  updateUser({
    required String phoneNumber,
    required String governorate,
    required String userName,
    required String mail,
    required DateTime dob,
  }) async {
    emit(UpdateUserLoading());

    try {
      await UpdateUserService(Dio()).updateUser(
        userName: userName,
        phoneNumber: phoneNumber,
        governorate: governorate,
        mail: mail,
        dob: dob,
      );
      emit(UpdateUserSuccess());
    } catch (e) {
      emit(
        UpdateUserFailure(
          errorMessages: const [
            {'message': 'something wrong happen'},
          ],
        ),
      );
    }
  }

  userLogOut() async {
    emit(UserLogOutLoading());

    try {
      await UserLogOutService(Dio()).userLogOut();
      emit(UserLogOutSuccess());
    } catch (e) {
      emit(
        UserLogOutFailure(
          errorMessages: const [
            {'message': 'something wrong happen'},
          ],
        ),
      );
    }
  }
}
