import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/Features/notificationView/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:safe_return/Features/notificationView/presentation/views/widgets/custom_notification.dart';
import 'package:safe_return/Features/notificationView/data/get_notifications_model/get_notifications_model.dart';
import 'package:safe_return/Features/notificationView/data/get_notifications_model/notification.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomNotificationsListViewBuilder extends StatefulWidget {
  const CustomNotificationsListViewBuilder({super.key});

  @override
  State<CustomNotificationsListViewBuilder> createState() =>
      _CustomNotificationsListViewBuilderState();
}

class _CustomNotificationsListViewBuilderState
    extends State<CustomNotificationsListViewBuilder> {
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

  Future<void> _refresh() async {
    await initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is GetNotificationsLoading) {
          isLoading = true;
        } else if (state is GetNotificationsSuccess) {
          notificationsModel = GetNotificationsModel(
              message: 'success', notifications: state.notifications);
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
        if (state is DeleteNotificationLoading) {
          isLoading = true;
        } else if (state is DeleteNotificationSuccess) {
          SnackBarManager.showSnackBar(
            context,
            'Report Deleted Successfully',
          );
          setState(() {
            notificationsModel?.notifications?.removeAt(state.index);
          });
          isLoading = false;
        } else if (state is DeleteNotificationFailure) {
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
        if (notificationsModel?.notifications?.isEmpty == true) {
          return RefreshIndicator(
            onRefresh: _refresh,
            displacement: 25,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "There are no Notifications yet!",
                        style: Styles.textStyleSemi16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: _refresh,
                        child: SvgPicture.asset(
                            'assets/myReportsPhotos/loading.svg'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          displacement: 25,
          child: ListView.builder(
            itemCount: notificationsModel?.notifications?.length,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  BlocProvider.of<NotificationsCubit>(context)
                      .deleteNotification(
                    id: notificationsModel?.notifications?[index].id,
                    index: index,
                  );
                },
                child: Column(
                  children: [
                    CustomNotification(
                      text: "${notificationsModel?.notifications?[index].body}",
                      date:
                          '${notificationsModel?.notifications?[index].date?.split(" ").last}',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
