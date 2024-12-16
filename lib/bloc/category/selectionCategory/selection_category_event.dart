import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection_category_event.freezed.dart';

@freezed
class SelectionCategoryEvent with _$SelectionCategoryEvent {
  const factory SelectionCategoryEvent.started() = _Started;
  const factory SelectionCategoryEvent.select({
    required String subcategoryName,
  }) = _Select;
}
