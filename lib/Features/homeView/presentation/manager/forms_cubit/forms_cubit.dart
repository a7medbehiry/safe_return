import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/find_report.dart';
import 'package:safe_return/Features/homeView/data/models/get_missing_form_model/missing_report.dart';
import 'package:safe_return/core/utils/api_services.dart';

import '../../../data/models/get_missing_form_model/get_missing_form_model.dart';
import '../../../data/models/get_one_find_form_model/find_one_report.dart';
import '../../../data/models/get_one_find_form_model/get_one_find_form_model.dart';
import '../../../data/models/get_one_missing_form_model/get_one_missing_form_model.dart';
import '../../../data/models/get_one_missing_form_model/missing_one_report.dart';

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
        emit(GetFindFormSuccess(findReport: findFormModelData.reports!));
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

  getOneFindForm(GetOneFindFormModel findOneFormModel, {String? id}) async {
    emit(GetOneFindFormLoading());

    try {
      GetOneFindFormModel findOneFormModelData =
          await GetOneFindFormService(Dio()).getOneFindForm(
        id: id,
      );
      if (findOneFormModelData.report != null) {
        log('getUser success: ${findOneFormModelData.report}');
        emit(GetOneFindFormSuccess(findOneReport: findOneFormModelData.report));
      } else {
        log('getUser error: User data is null');
        emit(
          GetOneFindFormFailure(
            errorMessages: const [
              {'message': 'Failed to get user data'},
            ],
          ),
        );
      }
    } catch (e) {
      log('getUser error: $e');
      emit(
        GetOneFindFormFailure(
          errorMessages: const [
            {'message': 'Failed to get user data'},
          ],
        ),
      );
    }
  }

  updateFindForm({
    String? id,
    File? image,
    String? fName,
    String? lName,
    String? phoneNumber,
    String? name,
    int? age,
    DateTime? dob,
    String? governorate,
    String? description,
  }) async {
    emit(UpdateFindFormLoading());

    try {
      await UpdateFindPersonService(Dio()).updateFindForm(
        id: id,
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
      emit(UpdateFindFormSuccess());
    } catch (e) {
      emit(
        UpdateFindFormFailure(
          errorMessages: const [
            {
              'message': 'Something wrong happen',
            },
          ],
        ),
      );
    }
  }

  deleteFindForm({required String? id, required int index}) async {
    emit(DeleteFindFormLoading());

    try {
      await DeleteFindReportService(Dio()).deleteFindReport(
        id: id,
      );
      emit(DeleteFindFormSuccess(index: index));
    } catch (e) {
      emit(
        DeleteFindFormFailure(
          errorMessages: const [
            {'message': 'Something wrong happened'},
          ],
        ),
      );
    }
  }

  missingForm({
    required String fName,
    required String lName,
    required String phoneNumber,
    required String nId,
    required DateTime dob,
    required String governorate,
  }) async {
    emit(MissingFormLoading());

    try {
      await MissingPersonService(Dio()).missingForm(
        fName: fName,
        lName: lName,
        phoneNumber: phoneNumber,
        nId: nId,
        governorate: governorate,
        dob: dob,
      );
      emit(MissingFormSuccess());
    } catch (e) {
      emit(
        MissingFormFailure(
          errorMessages: const [
            {
              'message': 'Something wrong happen',
            },
          ],
        ),
      );
    }
  }

  getMissingForm(GetMissingFormModel missingFormModel) async {
    emit(GetMissingFormLoading());

    try {
      GetMissingFormModel missingFormModelData =
          await GetMissingFormService(Dio()).getMissingForm();
      if (missingFormModelData.reports != null) {
        log('getUser success: ${missingFormModelData.reports}');
        emit(GetMissingFormSuccess(report: missingFormModelData.reports!));
      } else {
        log('getUser error: User data is null');
        emit(
          GetMissingFormFailure(
            errorMessages: const [
              {'message': 'Failed to get user data'},
            ],
          ),
        );
      }
    } catch (e) {
      log('getUser error: $e');
      emit(
        GetMissingFormFailure(
          errorMessages: const [
            {'message': 'Failed to get user data'},
          ],
        ),
      );
    }
  }

  getOneMissingForm(GetOneMissingFormModel missingOneFormModel,
      {String? id}) async {
    emit(GetOneMissingFormLoading());

    try {
      GetOneMissingFormModel missingOneFormModel =
          await GetOneMissingFormService(Dio()).getOneMissingForm(
        id: id,
      );
      if (missingOneFormModel.report != null) {
        log('get missing form data success: ${missingOneFormModel.report}');
        emit(GetOneMissingFormSuccess(
            missingOneReport: missingOneFormModel.report));
      } else {
        log('getUser error:  data is null');
        emit(
          GetOneMissingFormFailure(
            errorMessages: const [
              {'message': 'Failed to get  data'},
            ],
          ),
        );
      }
    } catch (e) {
      log('get one missing form error: $e');
      emit(
        GetOneMissingFormFailure(
          errorMessages: const [
            {'message': 'Failed to get  data'},
          ],
        ),
      );
    }
  }

  updateMissingForm({
    String? id,
    String? fName,
    String? lName,
    String? phoneNumber,
    String? nId,
    DateTime? dob,
    String? governorate,
  }) async {
    emit(UpdateMissingFormLoading());

    try {
      await UpdateMissingPersonService(Dio()).updateMissingForm(
        id: id,
        fName: fName,
        lName: lName,
        phoneNumber: phoneNumber,
        nId: nId,
        governorate: governorate,
        dob: dob,
      );
      emit(UpdateMissingFormSuccess());
    } catch (e) {
      emit(
        UpdateMissingFormFailure(
          errorMessages: const [
            {
              'message': 'SORRY Something wrong happen',
            },
          ],
        ),
      );
    }
  }

  deleteMissingReport({required String? id, required int index}) async {
    emit(DeleteMissingLoading());

    try {
      await DeleteMissingReportService(Dio()).deleteMissingReport(
        id: id,
      );
      emit(DeleteMissingSuccess(
        index: index,
      ));
    } catch (e) {
      emit(
        DeleteMissingFailure(
          errorMessages: const [
            {'message': 'something wrong happen sorry'},
          ],
        ),
      );
    }
  }
}
