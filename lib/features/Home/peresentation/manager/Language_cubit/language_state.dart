part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageSuccess extends LanguageState {
  final Locale local;

  LanguageSuccess({required this.local});
}
