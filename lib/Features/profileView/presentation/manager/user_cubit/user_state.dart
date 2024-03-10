part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class GetUserInitial extends UserState {}

final class GetUserLoading extends UserState {}

final class GetUserSuccess extends UserState {}

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

final class SaveUpdatedUserInitial extends UserState {}

final class SaveUpdatedUserLoading extends UserState {}

final class SaveUpdatedUserSuccess extends UserState {}

final class SaveUpdatedUserFailure extends UserState {
  final String errorMessages;
  SaveUpdatedUserFailure({required this.errorMessages});
}

final class ReadUpdatedUserInitial extends UserState {}

final class ReadUpdatedUserSuccess extends UserState {}

final class UserLogOutInitial extends UserState {}

final class UserLogOutLoading extends UserState {}

final class UserLogOutSuccess extends UserState {}

final class UserLogOutFailure extends UserState {
  final List<Map<String, dynamic>> errorMessages;
  UserLogOutFailure({required this.errorMessages});
}
