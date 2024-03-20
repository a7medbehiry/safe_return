import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/data/models/get_one_missing_form_model/get_one_missing_form_model.dart';
import 'package:safe_return/Features/homeView/data/models/get_one_missing_form_model/missing_one_report.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';

import '../../../../constants.dart';
import '../../../../core/utils/functions/custom_snack_bar.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import 'widgets/edit_missing_person_form_view_body.dart';

class EditMissingPersonFormView extends StatefulWidget {
  final String? id;

  const EditMissingPersonFormView({super.key, this.id});

  @override
  State<EditMissingPersonFormView> createState() =>
      _EditMissingPersonFormViewState();
}

class _EditMissingPersonFormViewState extends State<EditMissingPersonFormView> {
  bool isLoading = false;
  GetOneMissingFormModel? missingOneFormModel;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController city = TextEditingController();

  late Future<void> initialization;
  MissingOneReport? report;

  @override
  void initState() {
    super.initState();
    firstName = TextEditingController();
    lastName = TextEditingController();
    number = TextEditingController();
    date = TextEditingController();
    city = TextEditingController();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    missingOneFormModel =
        GetOneMissingFormModel(message: 'initial Message', report: report);
    await BlocProvider.of<FormsCubit>(context).getOneMissingForm(
      missingOneFormModel!,
      id: widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is GetOneMissingFormLoading) {
          isLoading = true;
        } else if (state is GetOneMissingFormSuccess) {
          missingOneFormModel = GetOneMissingFormModel(
              message: 'success', report: state.missingOneReport);
          firstName.text = missingOneFormModel?.report?.firstReporterName ?? '';
          lastName.text = missingOneFormModel?.report?.lastReporterName ?? '';
          number.text = missingOneFormModel?.report?.phoneNumber ?? '';
          id.text = missingOneFormModel?.report?.nationalId?.toString() ?? '';
          date.text = missingOneFormModel?.report?.date != null
              ? DateFormat('yyyy-MM-dd')
                  .format(missingOneFormModel!.report!.date!)
              : '';
          city.text = missingOneFormModel?.report?.governorate ?? '';
          isLoading = false;
        } else if (state is GetOneMissingFormFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBarForms(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
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
      },
    );
  }
}
