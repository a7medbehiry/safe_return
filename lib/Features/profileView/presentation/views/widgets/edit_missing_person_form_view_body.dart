import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_drop_down.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_reports_date.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';

import '../../../../homeView/data/models/get_one_missing_form_model/get_one_missing_form_model.dart';
import '../../../../homeView/data/models/get_one_missing_form_model/missing_one_report.dart';
import '../../../../homeView/presentation/views/widgets/custom_text_container.dart';
import '../../../../homeView/presentation/views/widgets/custom_text_container_with_radius.dart';

class EditMissingPersonFormViewBody extends StatefulWidget {
  const EditMissingPersonFormViewBody({super.key});

  @override
  State<EditMissingPersonFormViewBody> createState() =>
      _EditMissingPersonFormViewBodyState();
}

class _EditMissingPersonFormViewBodyState
    extends State<EditMissingPersonFormViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController city = TextEditingController();

  String? fName;
  String? lName;
  String? phoneNumber;
  String? nId;
  DateTime? dob;
  String? governorate;

  GetOneMissingFormModel? missingOneFormModel;
  MissingOneReport? report;
  late Future<void> initialization;

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
    await BlocProvider.of<FormsCubit>(context)
        .getOneMissingForm(missingOneFormModel!);
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
        if (state is UpdateMissingFormLoading) {
          isLoading = true;
        } else if (state is UpdateMissingFormSuccess) {
          context.goNamed('myReportsView');
          SnackBarManager.showSnackBar(
            context,
            'Missing Form Updated Successfully',
          );
          isLoading = false;
        } else if (state is UpdateMissingFormFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
                context, errorMessage['message'].toString());
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextContainerWithRadius(
                    width: 160,
                    height: 40,
                    text: 'personal',
                    style: Styles.textStyleLight16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        onChanged: (data) {
                          fName = data;
                        },
                        label: Text(
                          "${missingOneFormModel?.report?.firstReporterName}",
                        ),
                        width: 160,
                        height: 45,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTextFormField(
                        onChanged: (data) {
                          lName = data;
                        },
                        label: Text(
                          "${missingOneFormModel?.report?.lastReporterName}",
                        ),
                        width: 160,
                        height: 45,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      phoneNumber = data;
                    },
                    keyboardType: TextInputType.phone,
                    label: Text(
                      "${missingOneFormModel?.report?.phoneNumber}",
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/FormsViewPhotos/phone.svg',
                      ),
                    ),
                    width: 330,
                    height: 45,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextContainer(
                    width: 330,
                    height: 50,
                    text: 'Information about the missing person',
                    style: Styles.textStyleLight16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      nId = data;
                    },
                    keyboardType: TextInputType.number,
                    label: Text(
                      "${missingOneFormModel?.report?.nationalId}",
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/FormsViewPhotos/id.svg',
                      ),
                    ),
                    width: 330,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomReportsDate(
                        onChanged: (data) {
                          dob = data;
                        },
                        hintText: "${missingOneFormModel?.report?.date}",
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomDropDown(
                        width: 160,
                        height: 45,
                        onGovernorateSelected: (data) {
                          governorate = data;
                        },
                        text: "${missingOneFormModel?.report?.governorate}",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<FormsCubit>(context).updateMissingForm(
                          fName: fName ?? firstName.text,
                          lName: lName ?? lastName.text,
                          phoneNumber: phoneNumber ?? number.text,
                          nId: nId ?? id.text,
                          dob: dob ?? DateTime.parse(date.text),
                          governorate: governorate ?? city.text,
                        );
                      }
                    },
                    width: 340,
                    height: 50,
                    text: Text(
                      'Confirm',
                      style: Styles.textStyleSemi14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
