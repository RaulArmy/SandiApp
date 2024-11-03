import 'package:flutter/material.dart';

import 'custom_buttom.dart';

class FilterDrawer extends StatefulWidget {
  final Map<String, List<String>> data;
  final Function(Map<String, List<String>> dataFiltered) ontapFilter;

  const FilterDrawer({
    Key? key,
    required this.data,
    required this.ontapFilter,
  }) : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  int panelIndexExpanded = -1;
  Map<String, List<String>> dataFiltered = {};
  List<bool> isOpen = [];

  @override
  void initState() {
    widget.data.forEach((key, value) {
      dataFiltered.addAll({key: []});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.data.keys.length; i++) {
      isOpen.add(false);
    }
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Text(
                  "FIltrar por",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ExpansionPanelList(
                elevation: 0,
                dividerColor: Colors.transparent,
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    // panelIndexExpanded = panelIndex;
                    isOpen[panelIndex] = !isExpanded;
                  });
                  // panelIndexExpanded = panelIndex;
                  // setState(() {});
                },
                children: [
                  for (int i = 0; i < widget.data.keys.length; i++)
                    ExpansionPanel(
                      isExpanded: isOpen[i],
                      headerBuilder: (context, _) {
                        return ListTile(
                          title: Text(
                            widget.data.keys.toList()[i],
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                      body: Column(
                        children: [
                          for (int j = 0;
                              j <
                                  widget.data[widget.data.keys.toList()[i]]!
                                      .length;
                              j++)
                            StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: dataFiltered[
                                                  widget.data.keys.toList()[i]]
                                              ?.contains(widget.data[widget
                                                  .data.keys
                                                  .toList()[i]]![j]) ??
                                          false,
                                      onChanged: (value) {
                                        if (value!) {
                                          dataFiltered[
                                                  widget.data.keys.toList()[i]]!
                                              .add(widget.data[widget.data.keys
                                                  .toList()[i]]![j]);
                                        } else if (!value &&
                                            dataFiltered[widget.data.keys
                                                        .toList()[i]]
                                                    ?.contains(widget.data[
                                                            widget
                                                                .data.keys
                                                                .toList()[i]]![
                                                        j]) !=
                                                null) {
                                          dataFiltered[
                                                  widget.data.keys.toList()[i]]!
                                              .remove(widget.data[widget
                                                  .data.keys
                                                  .toList()[i]]![j]);
                                        }
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: size.width * 0.6,
                                      child: Text(
                                        widget.data[
                                            widget.data.keys.toList()[i]]![j],
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    label: "cancelar",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      dataFiltered.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  CustomButton(
                    label: "filtrar",
                    onPressed: () {
                      widget.ontapFilter(dataFiltered);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
