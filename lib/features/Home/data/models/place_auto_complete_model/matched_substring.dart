import 'package:equatable/equatable.dart';

class MatchedSubstring extends Equatable {
  final int? length;
  final int? offset;

  const MatchedSubstring({this.length, this.offset});

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MatchedSubstring(
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
