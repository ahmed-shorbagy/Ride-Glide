import 'package:equatable/equatable.dart';

import 'northeast.dart';
import 'southwest.dart';

class Viewport extends Equatable {
  final Northeast? northeast;
  final Southwest? southwest;

  const Viewport({this.northeast, this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json['northeast'] == null
            ? null
            : Northeast.fromJson(json['northeast'] as Map<String, dynamic>),
        southwest: json['southwest'] == null
            ? null
            : Southwest.fromJson(json['southwest'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'northeast': northeast?.toJson(),
        'southwest': southwest?.toJson(),
      };

  @override
  List<Object?> get props => [northeast, southwest];
}
