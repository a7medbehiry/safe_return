import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/notificationView/data/get_notification_model/get_notification_model.dart';
import 'package:safe_return/Features/notificationView/data/get_notification_model/notification.dart';
import 'package:safe_return/Features/notificationView/presentation/views/widgets/custom_notifications_list_view_builder.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';

import '../../manager/notifications_cubit/notifications_cubit.dart';
import 'custom_notification_app_bar.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  bool isLoading = false;

  GetNotificationsModel? notificationsModel;
  List<Notifications>? notifications;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    notificationsModel = GetNotificationsModel(
        message: 'initial message', notifications: notifications);
    await BlocProvider.of<NotificationsCubit>(context)
        .getNotifications(notificationsModel!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is GetNotificationsLoading) {
          isLoading = true;
        } else if (state is GetNotificationsSuccess) {
          setState(() {
            notificationsModel = GetNotificationsModel(
                message: 'success', notifications: state.notifications);
          });
          isLoading = false;
        } else if (state is GetNotificationsFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ModalProgressHUD(
            progressIndicator: const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
            inAsyncCall: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customNotificationAppBar(),
                const SizedBox(
                  height: 25,
                ),
                const Expanded(
                  child: CustomNotificationsListViewBuilder(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
