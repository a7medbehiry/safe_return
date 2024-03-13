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
  final List<Report>? report;

  GetFindFormSuccess({this.report});
}

final class GetFindFormFailure extends FormsState {
  final List<Map<String, dynamic>> errorMessages;
  GetFindFormFailure({required this.errorMessages});
}