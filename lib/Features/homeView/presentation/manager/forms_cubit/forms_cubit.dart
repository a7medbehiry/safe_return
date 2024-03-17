import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/find_report.dart';
import 'package:safe_return/core/utils/api_services.dart';

part 'forms_state.dart';

class FormsCubit extends Cubit<FormsState> {
  FormsCubit() : super(FormsInitial());

  findForm({
    required File image,
    required String fName,
    required String lName,
    required String phoneNumber,
    required String name,
    required int age,
    required DateTime dob,
    required String governorate,
    String? description,
  }) async {
    emit(FindFormLoading());

    try {
      await FindPersonService(Dio()).findForm(
        image: image,
        fName: fName,
        lName: lName,
        phoneNumber: phoneNumber,
        name: name,
        age: age,
        dob: dob,
        governorate: governorate,
        description: description,
      );
      emit(FindFormSuccess());
    } catch (e) {
      emit(
        FindFormFailure(
          errorMessages: const [
            {
              'message': 'Something wrong happen',
            },
          ],
        ),
      );
    }
  }

  getFindForm(GetFindFormModel findFormModel) async {
    emit(GetFindFormLoading());

    try {
      GetFindFormModel findFormModelData =
          await GetFindFormService(Dio()).getFindForm();
      if (findFormModelData.reports != null) {
        log('getUser success: ${findFormModelData.reports}');
        emit(GetFindFormSuccess(report: findFormModelData.reports!));
      } else {
        log('getUser error: User data is null');
        emit(
          GetFindFormFailure(
            errorMessages: const [
              {'message': 'Failed to get user data'},
            ],
          ),
        );
      }
    } catch (e) {
      log('getUser error: $e');
      emit(
        GetFindFormFailure(
          errorMessages: const [
            {'message': 'Failed to get user data'},
          ],
        ),
      );
    }
  }
}
