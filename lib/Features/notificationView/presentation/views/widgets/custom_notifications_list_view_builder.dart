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

  Future<void> _refresh() {
    setState(() {
      initializeData();
    });
    return Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
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
      },
      builder: (context, state) {
        if (notificationsModel?.notifications?.isEmpty == true) {
          return Column(
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
                  SvgPicture.asset('assets/myReportsPhotos/loading.svg'),
                ],
              ),
            ],
          );
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            itemCount: notificationsModel?.notifications?.length,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
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
              );
            },
          ),
        );
      },
    );
  }
}
