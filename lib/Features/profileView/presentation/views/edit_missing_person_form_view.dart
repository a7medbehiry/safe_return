import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../constants.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import 'widgets/edit_missing_person_form_view_body.dart';

class EditMissingPersonFormView extends StatefulWidget {
  const EditMissingPersonFormView({super.key});

  @override
  State<EditMissingPersonFormView> createState() =>
      _EditMissingPersonFormViewState();
}

class _EditMissingPersonFormViewState extends State<EditMissingPersonFormView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
        child: Scaffold(
          appBar: customAppBar(
            context,
            title: 'Report of a missing person',
          ),
          body: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: EditMissingPersonFormViewBody(),
          ),
        ),
      ),
    );
  }
}
