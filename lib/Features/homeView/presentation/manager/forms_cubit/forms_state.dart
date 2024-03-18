part of 'forms_cubit.dart';

@immutable
sealed class FormsState {}

final class FormsInitial extends FormsState {}

final class FindFormInitial extends FormsState {}

final class FindFormLoading extends FormsState {}

final class FindFormSuccess extends FormsState {}

final class FindFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  FindFormFailure({required this.errorMessages});
}

final class GetFindFormInitial extends FormsState {}

final class GetFindFormLoading extends FormsState {}

final class GetFindFormSuccess extends FormsState {
  final List<FindReport>? report;

  GetFindFormSuccess({this.report});
}

final class GetFindFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  GetFindFormFailure({required this.errorMessages});
}

final class GetOneFindFormInitial extends FormsState {}

final class GetOneFindFormLoading extends FormsState {}

final class GetOneFindFormSuccess extends FormsState {
  final FindOneReport? findReport;

  GetOneFindFormSuccess({this.findReport});
}

final class GetOneFindFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  GetOneFindFormFailure({required this.errorMessages});
}

final class UpdateFindFormInitial extends FormsState {}

final class UpdateFindFormLoading extends FormsState {}

final class UpdateFindFormSuccess extends FormsState {}

final class UpdateFindFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  UpdateFindFormFailure({required this.errorMessages});
}

final class DeleteFindFormInitial extends FormsState {}

final class DeleteFindFormLoading extends FormsState {}

final class DeleteFindFormSuccess extends FormsState {}

final class DeleteFindFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  DeleteFindFormFailure({required this.errorMessages});
}

final class GetMissingFormInitial extends FormsState {}

final class GetMissingFormLoading extends FormsState {}

final class GetMissingFormSuccess extends FormsState {
  final List<MissingReport>? report;

  GetMissingFormSuccess({this.report});
}

final class GetMissingFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  GetMissingFormFailure({required this.errorMessages});
}
