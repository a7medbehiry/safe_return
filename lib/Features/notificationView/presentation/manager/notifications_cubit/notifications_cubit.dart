import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/Features/notificationView/data/get_notifications_model/get_notifications_model.dart';
import 'package:safe_return/Features/notificationView/data/get_notifications_model/notification.dart';
import 'package:safe_return/core/utils/api_services.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  getNotifications(GetNotificationsModel notificationsModel) async {
    emit(GetNotificationsLoading());

    try {
      GetNotificationsModel notificationsModelData =
          await GetNotificationsService(Dio()).getNotifications();
      if (notificationsModelData.notifications != null) {
        log('getUser success: ${notificationsModelData.notifications}');
        emit(GetNotificationsSuccess(
            notifications: notificationsModelData.notifications!));
      } else {
        log('getUser error: User data is null');
        emit(
          GetNotificationsFailure(
            errorMessages: const [
              {'message': 'Failed to get user data'},
            ],
          ),
        );
      }
    } catch (e) {
      log('getUser error: $e');
      emit(
        GetNotificationsFailure(
          errorMessages: const [
            {'message': 'Failed to get user data'},
          ],
        ),
      );
    }
  }
}
