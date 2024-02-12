import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

class MyReportsViewBody extends StatelessWidget {
  const MyReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customAppBar(
          context,
          title: 'My Reports',
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
          child: Text(
            'History',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(
            color: kThirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/notification.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Report ',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Lost',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Date: 27/1/2024',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Name: Sohaila Ali',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'National ID: 5060701265348',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                  ),
                  child: Text(
                    '10:15 AM',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(
            color: kThirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/reportPhoto.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Report ',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Found',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Date: 27/1/2024',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Name: Ali',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  width: 120,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                  ),
                  child: Text(
                    '10:15 AM',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
