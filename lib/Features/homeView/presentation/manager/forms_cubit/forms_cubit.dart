import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:safe_return/core/utils/api_services.dart';

part 'forms_state.dart';

class FormsCubit extends Cubit<FormsState> {
  FormsCubit() : super(FormsInitial());

  findForm({
    required String fName,
    required String lName,
    required String phoneNumber,
    required String name,
    required int age,
    required DateTime dob,
    String? governorate,
    String? description,
  }) async {
    emit(FindFormLoading());

    try {
      await FindPersonService(Dio()).findForm(
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
}
