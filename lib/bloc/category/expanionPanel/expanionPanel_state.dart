import 'package:freezed_annotation/freezed_annotation.dart';

part 'expanionPanel_state.freezed.dart';

@freezed
abstract class ExpansionPanelState with _$ExpansionPanelState {
  const factory ExpansionPanelState.loaded(final int pressedIndex) = Loaded;
}
