part of 'push_notifications_cubit.dart';

@immutable
sealed class PushNotificationsState {}

final class PushNotificationsInitial extends PushNotificationsState {}
final class PushNotificationsSuccess extends PushNotificationsState {}
final class PushNotificationsFailure extends PushNotificationsState {
  final String errorMessages;
  PushNotificationsFailure({required this.errorMessages});
}

