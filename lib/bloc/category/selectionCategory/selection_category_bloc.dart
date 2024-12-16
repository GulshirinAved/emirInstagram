import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'selection_category_event.dart';
import 'selection_category_state.dart';

class SelectionCategoryBloc
    extends Bloc<SelectionCategoryEvent, SelectionCategoryState> {
  SelectionCategoryBloc() : super(const SelectionCategoryState.initial()) {
    on<SelectionCategoryEvent>((event, emit) {
      event.map(
          started: (e) => emit(const SelectionCategoryState.initial()),
          select: (e) {
            final updates = List.from(state.maybeWhen(
                load: (selectedList) => selectedList, orElse: () => []));
            if (updates.contains(e.subcategoryName) == false) {
              updates.add(e.subcategoryName);
            } else {
              updates.remove(e.subcategoryName);
            }
            log(updates.toString());
            emit(SelectionCategoryState.load(selectedList: updates));
          });
    });
  }
}
