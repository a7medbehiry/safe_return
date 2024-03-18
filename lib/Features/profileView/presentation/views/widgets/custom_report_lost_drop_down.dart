import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/Features/homeView/data/models/get_missing_form_model/missing_report.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../homeView/data/models/get_missing_form_model/get_missing_form_model.dart';
import '../../../../homeView/presentation/manager/forms_cubit/forms_cubit.dart';

class CustomReportLostDropDown extends StatefulWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final MissingReport? missingFormModel;
  final int currentIndex;

  const CustomReportLostDropDown(
      {super.key,
      this.onEdit,
      this.onDelete,
      this.missingFormModel,
      required this.currentIndex});

  @override
  State<CustomReportLostDropDown> createState() =>
      _CustomReportLostDropDownState();
}

class _CustomReportLostDropDownState extends State<CustomReportLostDropDown> {
  String? selectedOption;

  GetMissingFormModel? missingFormModel;
  List<MissingReport>? reports;
  bool isLoading = false;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    missingFormModel =
        GetMissingFormModel(message: 'initial message', reports: reports);
    await BlocProvider.of<FormsCubit>(context)
        .getMissingForm(missingFormModel!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is GetMissingFormLoading) {
          isLoading = true;
        } else if (state is GetMissingFormSuccess) {
          missingFormModel =
              GetMissingFormModel(message: 'success', reports: state.report);
          isLoading = false;
        } else if (state is GetFindFormFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(
            color: kThirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/myReportsPhotos/girl.jpg'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Report ',
                          style: Styles.textStyleReg14,
                        ),
                        Text(
                          'Lost',
                          style: Styles.textStyleBold14,
                        ),
                      ],
                    ),
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(missingFormModel?.reports?[widget.currentIndex].date ?? DateTime.now())}',
                      style: Styles.textStyleReg14,
                    ),
                    Text(
                      'Name:  ${missingFormModel?.reports?[widget.currentIndex].firstReporterName}',
                      style: Styles.textStyleReg14,
                    ),
                    Text(
                      'National ID:  ${missingFormModel?.reports?[widget.currentIndex].nationalId}',
                      style: Styles.textStyleReg14,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: Colors.white,
                      value: selectedOption,
                      icon: SvgPicture.asset(
                          'assets/myReportsPhotos/dropDown.svg'),
                      style:
                          Styles.textStyleReg16.copyWith(color: Colors.black),
                      onChanged: (data) {
                        setState(() {
                          selectedOption = data;
                          if (data == 'Edit' && widget.onEdit != null) {
                            widget.onEdit!();
                          } else if (data == 'Delete' &&
                              widget.onDelete != null) {
                            widget.onDelete!();
                          }
                        });
                      },
                      items: <String>['Edit', 'Delete']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Text(value),
                              const SizedBox(
                                width: 10,
                              ),
                              value == 'Edit'
                                  ? SvgPicture.asset(
                                      'assets/myReportsPhotos/edit.svg')
                                  : SvgPicture.asset(
                                      'assets/myReportsPhotos/delete.svg'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Text(
                      DateFormat('MMM dd').format(missingFormModel
                              ?.reports?[widget.currentIndex].date ??
                          DateTime.now()),
                      style: Styles.textStyleBold14.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
