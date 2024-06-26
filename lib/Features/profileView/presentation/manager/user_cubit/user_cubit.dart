import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/Features/profileView/data/models/get_user_model/get_user_model.dart';
import 'package:safe_return/core/utils/api_services.dart';

import '../../../../auth/presentation/manager/auth_cubit/firebase_service.dart';
import '../../../data/models/get_user_model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  getUser(
    GetUserModel userModel,
  ) async {
    emit(GetUserLoading());

    try {
      GetUserModel userModelData = await GetUserService(Dio()).getUser();
      if (userModelData.user != null) {
        log('getUser success: ${userModelData.user}');
        emit(GetUserSuccess(user: userModelData.user!));
      } else {
        log('getUser error: User data is null');
        emit(
          GetUserFailure(
            errorMessages: const [
              {'message': 'Failed to get user data'},
            ],
          ),
        );
      }
    } catch (e) {
      log('getUser error: $e');
      emit(
        GetUserFailure(
          errorMessages: const [
            {'message': 'Failed to get user data'},
          ],
        ),
      );
    }
  }

  updateUser({
    required String userName,
    required String phoneNumber,
    required String governorate,
    required DateTime dob,
  }) async {
    emit(UpdateUserLoading());

    try {
      await UpdateUserService(Dio()).updateUser(
        userName: userName,
        phoneNumber: phoneNumber,
        governorate: governorate,
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

  userPicture({required File picture}) async {
    emit(UserPictureLoading());

    try {
      await UserPictureService(Dio()).userPicture(
        picture: picture,
      );
      emit(UserPictureSuccess());
    } catch (e) {
      emit(
        UserPictureFailure(
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
      await LogOutService(Dio()).userLogOut();
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

  googleLogOut() async {
    emit(GoogleLogOutLoading());

    try {
      await FirebaseGoogleServiceLogin().signOut();
      emit(GoogleLogOutSuccess());
    } catch (e) {
      emit(
        GoogleLogOutFailure(
          errorMessages: const [
            {'message': 'something wrong happen'},
          ],
        ),
      );
    }
  }

  facebookLogOut() async {
    emit(FaceBookLogOutLoading());

    try {
      await FirebaseFaceBookServiceLogin().signOut();
      emit(FaceBookLogOutSuccess());
    } catch (e) {
      emit(
        FaceBookLogOutFailure(
          errorMessages: const [
            {'message': 'something wrong happen'},
          ],
        ),
      );
    }
  }
}
