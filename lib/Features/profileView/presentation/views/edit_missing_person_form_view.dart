import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_app_bar.dart';
import 'widgets/edit_missing_person_form_view_body.dart';

class EditMissingPersonFormView extends StatelessWidget {
  const EditMissingPersonFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'Report of a missing person',
      ),
      body: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: EditMissingPersonFormViewBody(),
      ),
    );
  }
}
