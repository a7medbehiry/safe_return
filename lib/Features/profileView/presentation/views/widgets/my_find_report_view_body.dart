import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/functions/shimmer_effect.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

import '../../../../homeView/data/models/get_find_form_model/find_report.dart';
import 'custom_my_find_reports_list_view_builder.dart';

class MyFindReportsViewBody extends StatefulWidget {
  const MyFindReportsViewBody({super.key});

  @override
  State<MyFindReportsViewBody> createState() => _MyFindReportsViewBodyState();
}

class _MyFindReportsViewBodyState extends State<MyFindReportsViewBody> {
  GetFindFormModel? findFormModel;
  List<FindReport>? findReports;

  bool isLoading = false;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    findFormModel =
        GetFindFormModel(message: 'initial message', reports: findReports);
    await BlocProvider.of<FormsCubit>(context).getFindForm(findFormModel!);
  }

  Future<void> _refresh() {
    setState(() {
      initializeData();
    });
    return Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is GetFindFormLoading) {
          isLoading = true;
        } else if (state is GetFindFormSuccess) {
          findFormModel =
              GetFindFormModel(message: 'success', reports: state.findReport);
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
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ModalProgressHUD(
            progressIndicator: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                formsLoadingCard(),
                const SizedBox(
                  height: 15,
                ),
                formsLoadingCard(),
                const SizedBox(
                  height: 15,
                ),
                formsLoadingCard(),
                const SizedBox(
                  height: 15,
                ),
                formsLoadingCard(),
                const SizedBox(
                  height: 15,
                ),
                formsLoadingCard(),
                const SizedBox(
                  height: 15,
                ),
                formsLoadingCard(),
                const SizedBox(
                  height: 15,
                ),
                formsLoadingCard(),
              ],
            ),
            inAsyncCall: isLoading,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.1,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customAppBar(
                      context,
                      title: 'My Find Reports',
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: _refresh,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Expanded(
                      child: CustomMyFindReportsListViewBuilder(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
