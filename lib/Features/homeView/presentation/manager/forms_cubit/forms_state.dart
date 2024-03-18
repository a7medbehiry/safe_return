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
  final FindOneReport? report;

  GetOneFindFormSuccess({this.report});
}

final class GetOneFindFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  GetOneFindFormFailure({required this.errorMessages});
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