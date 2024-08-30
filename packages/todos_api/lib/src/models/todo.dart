import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'json_map.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  /// The unique identifier of the  `todo`.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of `todo`.
  ///
  /// The title might be empty.
  final String title;

  /// The description of the `todo`.
  ///
  /// Defaults to an empty string.
  final String description;

  /// Whether the `todo` is completed.
  ///
  /// Default to `false`.
  final bool isCompleted;

  Todo({
    required this.title,
    String? id,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or empty',
        ),
        id = id ?? const Uuid().v4();

  /// Returns a copy of this `todo` with the given values updated
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  /// Deserializes the given [JsonMap] into [Todo].
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  /// Converts this [Todo] into a [Todo].
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
