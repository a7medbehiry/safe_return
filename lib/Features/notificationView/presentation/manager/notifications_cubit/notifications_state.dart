part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class GetNotificationsInitial extends NotificationsState {}

final class GetNotificationsLoading extends NotificationsState {}

final class GetNotificationsSuccess extends NotificationsState {
  final List<Notifications>? notifications;
  GetNotificationsSuccess({this.notifications});
}

final class GetNotificationsFailure extends NotificationsState {
  final List<Map<String, dynamic>> errorMessages;
  GetNotificationsFailure({required this.errorMessages});
}
