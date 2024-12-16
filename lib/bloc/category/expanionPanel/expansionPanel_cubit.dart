import 'package:bloc/bloc.dart';
import 'package:emir_proyekt/bloc/category/expanionPanel/expanionPanel_state.dart';

class ExpansionPanelCubit extends Cubit<ExpansionPanelState> {
  ExpansionPanelCubit() : super(const ExpansionPanelState.loaded(0));

  void updatePanel(int index) {
    emit(ExpansionPanelState.loaded(index));
  }
}
