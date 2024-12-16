import 'package:emir_proyekt/bloc/category/expanionPanel/expanionPanel_state.dart';
import 'package:emir_proyekt/bloc/category/expanionPanel/expansionPanel_cubit.dart';
import 'package:emir_proyekt/bloc/category/selectionCategory/selection_category_bloc.dart';
import 'package:emir_proyekt/bloc/category/selectionCategory/selection_category_event.dart';
import 'package:emir_proyekt/bloc/category/selectionCategory/selection_category_state.dart';
import 'package:emir_proyekt/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpansionPanelCubit(),
        ),
        BlocProvider(
          create: (context) => SelectionCategoryBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(' Category Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: ListView(
                children: [
                  BlocBuilder<ExpansionPanelCubit, ExpansionPanelState>(
                    builder: (context, state) {
                      return state.when(
                        loaded: (pressedIndex) => ExpansionPanelList.radio(
                          expansionCallback: (panelIndex, isExpanded) {
                            context
                                .read<ExpansionPanelCubit>()
                                .updatePanel(panelIndex);
                          },
                          children: categoryList.map(
                            (entry) {
                              return ExpansionPanelRadio(
                                  value: entry['name'],
                                  headerBuilder: (context, isExpanded) =>
                                      ListTile(
                                        title: Text(entry['name']),
                                      ),
                                  body: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 3 / 1,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5),
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: entry['brands'].length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          context
                                              .read<SelectionCategoryBloc>()
                                              .add(
                                                  SelectionCategoryEvent.select(
                                                      subcategoryName:
                                                          entry['brands'][index]
                                                              ['title']));
                                        },
                                        child: BlocBuilder<
                                            SelectionCategoryBloc,
                                            SelectionCategoryState>(
                                          builder: (context, state) {
                                            return state.when(
                                              load: (selectedList) {
                                                final isSelected = selectedList
                                                    .contains(entry['brands']
                                                        [index]['title']);
                                                return Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: isSelected
                                                          ? Colors.orange
                                                          : Colors.grey
                                                              .withOpacity(
                                                                  0.5)),
                                                  child: Text(entry['brands']
                                                      [index]['title']),
                                                );
                                              },
                                              initial: () {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.5)),
                                                  child: Text(entry['brands']
                                                      [index]['title']),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ).toList(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            BlocBuilder<SelectionCategoryBloc, SelectionCategoryState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  load: (selectedList) {
                    return selectedList.isEmpty
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(
                                          color:
                                              Colors.grey.withOpacity(0.5)))),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemExtent: 100,
                                itemCount: selectedList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    context.read<SelectionCategoryBloc>().add(
                                        SelectionCategoryEvent.select(
                                            subcategoryName:
                                                selectedList[index]));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Text(selectedList[index]),
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
