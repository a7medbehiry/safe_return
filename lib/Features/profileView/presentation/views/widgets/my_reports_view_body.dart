import 'package:flutter/material.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_my_reports_list_view_builder.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

class MyReportsViewBody extends StatefulWidget {
  const MyReportsViewBody({super.key});

  @override
  State<MyReportsViewBody> createState() => _MyReportsViewBodyState();
}

class _MyReportsViewBodyState extends State<MyReportsViewBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customAppBar(
            context,
            title: 'My Reports',
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: CustomMyReportsListViewBuilder(
            ),
          ),
        ],
      ),
    );
  }
}
