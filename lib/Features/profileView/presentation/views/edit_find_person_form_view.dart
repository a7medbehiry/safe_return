import 'package:flutter/material.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/edit_find_person_form_view_body.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

class EditFindPersonFormView extends StatelessWidget {
  const EditFindPersonFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'Report of a missing person found',
      ),
      body: const SingleChildScrollView(
        child: EditFindPersonFormViewBody(),
      ),
    );
  }
}
