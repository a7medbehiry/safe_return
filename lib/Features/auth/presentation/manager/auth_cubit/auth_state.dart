part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignUpInitial extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {}

final class SignUpFailure extends AuthState {
  final List<Map<String, dynamic>> errorMessages;
  SignUpFailure({required this.errorMessages});
}

final class LoginInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final List<Map<String, dynamic>> errorMessages;
  LoginFailure({required this.errorMessages});
}

final class GoogleLoginInitial extends AuthState {}

final class GoogleLoginLoading extends AuthState {}

final class GoogleLoginSuccess extends AuthState {}

final class GoogleLoginFailure extends AuthState {
  final String errorMessages;
  GoogleLoginFailure({required this.errorMessages});
}

final class ForgetPasswordInitial extends AuthState {}

final class ForgetPasswordLoading extends AuthState {}

final class ForgetPasswordSuccess extends AuthState {}

final class ForgetPasswordFailure extends AuthState {
  final List<Map<String, dynamic>> errorMessages;
  ForgetPasswordFailure({required this.errorMessages});
}

final class ResetPasswordInitial extends AuthState {}

final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordFailure extends AuthState {
  final List<Map<String, dynamic>> errorMessages;
  ResetPasswordFailure({required this.errorMessages});
}
