part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class GetUserInitial extends UserState {}

final class GetUserLoading extends UserState {}

final class GetUserSuccess extends UserState {
  final User? user;

  GetUserSuccess({this.user});
}

final class GetUserFailure extends UserState {
  final List<Map<String, dynamic>> errorMessages;
  GetUserFailure({required this.errorMessages});
}

final class UpdateUserInitial extends UserState {}

final class UpdateUserLoading extends UserState {}

final class UpdateUserSuccess extends UserState {}

final class UpdateUserFailure extends UserState {
  final List<Map<String, dynamic>> errorMessages;
  UpdateUserFailure({required this.errorMessages});
}


final class UserPictureInitial extends UserState {}

final class UserPictureLoading extends UserState {}

final class UserPictureSuccess extends UserState {}

final class UserPictureFailure extends UserState {
  final List<Map<String, dynamic>> errorMessages;
  UserPictureFailure({required this.errorMessages});
}




final class UserLogOutInitial extends UserState {}

final class UserLogOutLoading extends UserState {}

final class UserLogOutSuccess extends UserState {}

final class UserLogOutFailure extends UserState {
  final List<Map<String, dynamic>> errorMessages;
  UserLogOutFailure({required this.errorMessages});
}
