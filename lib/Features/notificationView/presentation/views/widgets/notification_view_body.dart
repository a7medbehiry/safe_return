import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

import 'custom_notification_app_bar.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customNotificationAppBar(),
        const Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            bottom: 5,
          ),
          child: Text(
            'New',
            style: Styles.textStyleReg18,
          ),
        ),
        Container(
          width: double.infinity,
          height: 67,
          decoration: const BoxDecoration(
            color: kThirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('assets/notificationPhotos/girl.jpg'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: 'Your ',
                      //         style: Styles.textStyleReg15.copyWith(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: 'son ',
                      //         style: Styles.textStyleBold15.copyWith(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: 'has been ',
                      //         style: Styles.textStyleReg15.copyWith(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: 'found ',
                      //         style: Styles.textStyleBold15.copyWith(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: 'and the',
                      //         style: Styles.textStyleReg15.copyWith(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        'organization will contact you',
                        style: Styles.textStyleReg14.copyWith(
                          color: Colors.black,
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Text(
                  '10:15 AM',
                  style: Styles.textStyleBold14.copyWith(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            bottom: 5,
          ),
          child: Text(
            'Today',
            style: Styles.textStyleReg18,
          ),
        ),
        Container(
          width: double.infinity,
          height: 67,
          decoration: const BoxDecoration(
            color: kThirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage:
                    AssetImage('assets/notificationPhotos/girl.jpg'),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We are currently reviewing your ',
                    style: Styles.textStyleReg14.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'request and will ',
                          style: Styles.textStyleReg15.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'update you',
                          style: Styles.textStyleBold15.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 17,
              ),
              Text(
                '10:10 AM',
                style: Styles.textStyleBold14.copyWith(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
