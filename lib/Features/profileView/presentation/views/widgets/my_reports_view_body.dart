import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_my_reports_drop_down.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

class MyReportsViewBody extends StatefulWidget {
  const MyReportsViewBody({super.key});

  @override
  State<MyReportsViewBody> createState() => _MyReportsViewBodyState();
}

class _MyReportsViewBodyState extends State<MyReportsViewBody> {
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
        const CustomMyReportsDropDown(),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/myReportsPhotos/boy.jpg'),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Report ',
                          style: Styles.textStyleReg14,
                        ),
                        Text(
                          'Found',
                          style: Styles.textStyleBold14,
                        ),
                      ],
                    ),
                    Text(
                      'Date: 27/1/2024',
                      style: Styles.textStyleReg14,
                    ),
                    Text(
                      'Name: Ali',
                      style: Styles.textStyleReg14,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 120,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/myReportsPhotos/dropDown.svg'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                      ),
                      child: Text(
                        '10:10 AM',
                        style: Styles.textStyleBold14.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
