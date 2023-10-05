import 'package:equatable/equatable.dart';

class MainTextMatchedSubstring extends Equatable {
  final int? length;
  final int? offset;

  const MainTextMatchedSubstring({this.length, this.offset});

  factory MainTextMatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MainTextMatchedSubstring(
      length: json['length'] as int?,
      offset: json['offset'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'length': length,
        'offset': offset,
      };

  @override
  List<Object?> get props => [length, offset];
}
