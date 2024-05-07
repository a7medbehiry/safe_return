import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/core/utils/api_services.dart';

part 'push_notifications_state.dart';

class PushNotificationsCubit extends Cubit<PushNotificationsState> {
  PushNotificationsCubit() : super(PushNotificationsInitial());

  pushNotifications({
    required String fcmToken,
  }) async {
    try {
      await PushNotificationsService(Dio()).pushNotifications(
        fcmToken: fcmToken,
      );
      emit(PushNotificationsSuccess());
    } catch (e) {
      emit(
        PushNotificationsFailure(
          errorMessages: 'Failed to send FCM Token',
        ),
      );
    }
  }
}
