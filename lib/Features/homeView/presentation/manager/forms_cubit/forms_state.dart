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
