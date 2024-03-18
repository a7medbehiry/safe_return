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

  GetOneFindFormModel? findOneFormModel;
  FindOneReport? report;
  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
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
              GetOneFindFormModel(message: 'success', report: state.report);
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
                        onChanged: (data) {},
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
                        onChanged: (data) {},
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
                    onChanged: (data) {},
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
                        onChanged: (data) {},
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
                        onChanged: (data) {},
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
                        onChanged: (data) {},
                        hintText: DateFormat('yyyy-MM-dd').format(
                            findOneFormModel?.report?.date ?? DateTime.now()),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomEditFindFormImagePickerFunction(
                        onImageSelected: (data) {},
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
                    onGovernorateSelected: (data) {},
                    text: findOneFormModel?.report?.governorate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {},
                    hintText:
                        findOneFormModel?.report?.description ?? 'Description',
                    width: 330,
                    height: 110,
                    maxLines: 30,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () {
                      context.goNamed('myReportsView');
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
