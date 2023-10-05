import 'package:equatable/equatable.dart';

class Term extends Equatable {
  final int? offset;
  final String? value;

  const Term({this.offset, this.value});

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        offset: json['offset'] as int?,
        value: json['value'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'offset': offset,
        'value': value,
      };

  @override
  List<Object?> get props => [offset, value];
}
