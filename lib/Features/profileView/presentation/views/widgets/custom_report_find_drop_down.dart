import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/find_report.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

import '../../../../../core/utils/functions/custom_snack_bar.dart';

class CustomReportFindDropDown extends StatefulWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final FindReport? findFormModel;
  final int currentIndex;
  const CustomReportFindDropDown(
      {super.key,
      this.onEdit,
      this.onDelete,
      this.findFormModel,
      required this.currentIndex});

  @override
  State<CustomReportFindDropDown> createState() =>
      _CustomReportLostDropDownState();
}

class _CustomReportLostDropDownState extends State<CustomReportFindDropDown> {
  String? selectedOption;

  GetFindFormModel? findFormModel;
  List<FindReport>? reports;
  bool isLoading = false;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    findFormModel =
        GetFindFormModel(message: 'initial message', reports: reports);
    await BlocProvider.of<FormsCubit>(context).getFindForm(findFormModel!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is GetFindFormLoading) {
          isLoading = true;
        } else if (state is GetFindFormSuccess) {
          findFormModel =
              GetFindFormModel(message: 'success', reports: state.report);
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
                  backgroundImage: AssetImage('assets/myReportsPhotos/boy.jpg'),
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
                          'Found',
                          style: Styles.textStyleBold14,
                        ),
                      ],
                    ),
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(findFormModel?.reports?[widget.currentIndex].date ?? DateTime.now())}',
                      style: Styles.textStyleReg14,
                    ),
                    Text(
                      'Name: ${findFormModel?.reports?[widget.currentIndex].childName}',
                      style: Styles.textStyleReg14,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 90,
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
                      DateFormat('MMM dd').format(
                          findFormModel?.reports?[widget.currentIndex].date ??
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
