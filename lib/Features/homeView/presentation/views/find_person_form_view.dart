import 'package:flutter/material.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

import 'widgets/find_person_form_view_body.dart';

class FindPersonFormView extends StatelessWidget {
  const FindPersonFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'Report of a missing person found',
      ),
      body: const SingleChildScrollView(
        child: FindPersonFormViewBody(),
      ),
    );
  }
}
