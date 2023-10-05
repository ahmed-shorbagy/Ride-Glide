import 'package:equatable/equatable.dart';

import 'result.dart';

class PlaceDetailsModel extends Equatable {
  final List<dynamic>? htmlAttributions;
  final Result? result;
  final String? status;

  const PlaceDetailsModel({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
      htmlAttributions: json['html_attributions'] as List<dynamic>?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'html_attributions': htmlAttributions,
        'result': result?.toJson(),
        'status': status,
      };

  @override
  List<Object?> get props => [htmlAttributions, result, status];
}
