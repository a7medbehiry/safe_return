import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/edit_find_person_form_view_body.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

import '../../../homeView/data/models/get_one_find_form_model/find_one_report.dart';
import '../../../homeView/data/models/get_one_find_form_model/get_one_find_form_model.dart';

class EditFindPersonFormView extends StatefulWidget {
  const EditFindPersonFormView({super.key});

  @override
  State<EditFindPersonFormView> createState() => _EditFindPersonFormViewState();
}

class _EditFindPersonFormViewState extends State<EditFindPersonFormView> {
  bool isLoading = false;
  GetOneFindFormModel? findOneFormModel;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController childName = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController desc = TextEditingController();

  late Future<void> initialization;
  FindOneReport? report;

  @override
  void initState() {
    super.initState();
    firstName = TextEditingController();
    lastName = TextEditingController();
    number = TextEditingController();
    childName = TextEditingController();
    year = TextEditingController();
    date = TextEditingController();
    city = TextEditingController();
    desc = TextEditingController();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    findOneFormModel =
        GetOneFindFormModel(message: 'initial Message', report: report);
    await BlocProvider.of<FormsCubit>(context)
        .getOneFindForm(findOneFormModel!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is GetOneFindFormLoading) {
          isLoading = true;
        } else if (state is GetOneFindFormSuccess) {
          findOneFormModel =
              GetOneFindFormModel(message: 'success', report: state.findReport);
          firstName.text = findOneFormModel?.report?.firstReporterName ?? '';
          lastName.text = findOneFormModel?.report?.lastReporterName ?? '';
          number.text = findOneFormModel?.report?.phoneNumber ?? '';
          childName.text = findOneFormModel?.report?.childName ?? '';
          year.text = findOneFormModel?.report?.age?.toString() ?? '';
          date.text = findOneFormModel?.report?.date != null
              ? DateFormat('yyyy-MM-dd').format(findOneFormModel!.report!.date!)
              : '';
          city.text = findOneFormModel?.report?.governorate ?? '';
          desc.text = findOneFormModel?.report?.description ?? '';
          isLoading = false;
        } else if (state is GetOneFindFormFailure) {
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
                title: 'Report of a missing person found',
              ),
              body: const SingleChildScrollView(
                child: EditFindPersonFormViewBody(),
              ),
            ),
          ),
        );
      },
    );
  }
}
