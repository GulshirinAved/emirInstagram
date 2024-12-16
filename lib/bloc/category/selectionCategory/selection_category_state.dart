import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection_category_state.freezed.dart';

@freezed
class SelectionCategoryState with _$SelectionCategoryState {
  const factory SelectionCategoryState.initial() = _Initial;
  const factory SelectionCategoryState.load({required List selectedList}) =
      _Loaded;
}
