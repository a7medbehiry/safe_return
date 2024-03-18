import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_drop_down.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/functions/custom_snack_bar.dart';
import '../../../../homeView/data/models/get_one_find_form_model/find_one_report.dart';
import '../../../../homeView/data/models/get_one_find_form_model/get_one_find_form_model.dart';
import '../../../../homeView/presentation/views/widgets/custom_reports_date.dart';
import '../../../../homeView/presentation/views/widgets/custom_text_container.dart';
import '../../../../homeView/presentation/views/widgets/custom_text_container_with_radius.dart';
import 'custom_edit_find_form_image_picker_function.dart';

class EditFindPersonFormViewBody extends StatefulWidget {
  const EditFindPersonFormViewBody({super.key});

  @override
  State<EditFindPersonFormViewBody> createState() =>
      _EditFindPersonFormViewBodyState();
}

class _EditFindPersonFormViewBodyState
    extends State<EditFindPersonFormViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController childName = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController desc = TextEditingController();

  File? image;
  String? fName;
  String? lName;
  String? phoneNumber;
  String? name;
  int? age;
  DateTime? dob;
  String? governorate;
  String? description;

  GetOneFindFormModel? findOneFormModel;
  FindOneReport? report;
  late Future<void> initialization;

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
        if (state is UpdateFindFormLoading) {
          isLoading = true;
        } else if (state is UpdateFindFormSuccess) {
          context.goNamed('myReportsView');
          SnackBarManager.showSnackBar(
            context,
            'Find Form Updated Successfully',
          );
          isLoading = false;
        } else if (state is UpdateFindFormFailure) {
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
                    height: 10,
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
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        onChanged: (data) {
                          fName = data;
                        },
                        label: Text(
                          '${findOneFormModel?.report?.firstReporterName}',
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
                          '${findOneFormModel?.report?.lastReporterName}',
                        ),
                        width: 160,
                        height: 45,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      phoneNumber = data;
                    },
                    keyboardType: TextInputType.phone,
                    label: Text(
                      '${findOneFormModel?.report?.phoneNumber}',
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
                    height: 15,
                  ),
                  CustomTextContainer(
                    width: 330,
                    height: 50,
                    text: 'Information about the  person you found',
                    style: Styles.textStyleLight14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 130,
                      ),
                      Text(
                        'Option',
                        style: Styles.textStyle12,
                      ),
                      SizedBox(
                        width: 135,
                      ),
                      Text(
                        'Option',
                        style: Styles.textStyle12,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        onChanged: (data) {
                          name = data;
                        },
                        label: Text(
                          '${findOneFormModel?.report?.childName}',
                        ),
                        width: 160,
                        height: 45,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomTextFormField(
                        onChanged: (data) {
                          age = int.parse(data);
                        },
                        keyboardType: TextInputType.number,
                        label: Text(
                          '${findOneFormModel?.report?.age}',
                        ),
                        width: 160,
                        height: 45,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomReportsDate(
                        onChanged: (data) {
                          dob = data;
                        },
                        hintText: DateFormat('yyyy-MM-dd').format(
                            findOneFormModel?.report?.date ?? DateTime.now()),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomEditFindFormImagePickerFunction(
                        onImageSelected: (data) {
                          setState(() {
                            image = data;
                          });
                        },
                        src: findOneFormModel?.report?.image?.secureUrl,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDropDown(
                    width: 330,
                    height: 45,
                    onGovernorateSelected: (data) {
                      governorate = data;
                    },
                    text: findOneFormModel?.report?.governorate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      description = data;
                    },
                    hintText: findOneFormModel?.report?.description ??
                        'Additional information',
                    width: 330,
                    height: 110,
                    maxLines: 30,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (image == null) {
                          SnackBarManager.showSnackBarForms(
                            context,
                            'Please select an image.',
                          );
                          return;
                        }
                        BlocProvider.of<FormsCubit>(context).updateFindForm(
                          image: image,
                          fName: fName ?? firstName.text,
                          lName: lName ?? lastName.text,
                          phoneNumber: phoneNumber ?? number.text,
                          name: name ?? childName.text,
                          age: age ?? int.parse(year.text),
                          dob: dob ?? DateTime.parse(date.text),
                          governorate: governorate ?? city.text,
                          description: description ?? desc.text,
                        );
                      }
                    },
                    width: 330,
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
