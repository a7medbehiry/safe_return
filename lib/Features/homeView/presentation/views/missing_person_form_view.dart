import 'package:flutter/material.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/missing_person_form_view_body.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

class MissingPersonFormView extends StatelessWidget {
  const MissingPersonFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'Report of a missing person',
      ),
      body: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: MissingPersonFormViewBody(),
      ),
    );
  }
}
