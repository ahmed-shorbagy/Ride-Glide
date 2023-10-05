part of 'email_paswword_cubit.dart';

@immutable
sealed class EmailPaswwordState {}

final class EmailPaswwordInitial extends EmailPaswwordState {}

final class EmailPaswwordLoadin extends EmailPaswwordState {}

final class EmailPaswwordSuccess extends EmailPaswwordState {}

final class EmailPaswwordFaluire extends EmailPaswwordState {
  final String errMessage;

  EmailPaswwordFaluire({required this.errMessage});
}
