import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class DynamicCheckboxList extends StatefulWidget {
  final List<String> options;
  final String heading;
  final ValueChanged<List<String>> onSelectOptionsChanged;
  final bool showOtherOption;
  final List<dynamic>?
      selectedOptions; // if it is edit, it might have some data

  const DynamicCheckboxList({
    Key? key,
    this.selectedOptions,
    required this.heading,
    required this.options,
    required this.onSelectOptionsChanged,
    required this.showOtherOption,
  }) : super(key: key);

  @override
  State<DynamicCheckboxList> createState() => _DynamicCheckboxListState();
}

class _DynamicCheckboxListState extends State<DynamicCheckboxList> {
  List<String> options = []; // Copying passed argument data into this
  List<String> selectedOptions = []; // what user has selected

  bool isOtherSelected = false; // For popping up TextField to add

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    options = List.from(widget.options);

    // adding previously selected option to the [selectedOptions]
    for (String option in widget.selectedOptions ?? []) {
      selectedOptions.add(option.capitalize());
    }
    // this is crucial when editing store, passing already selected options back to the parent for handling
    widget.onSelectOptionsChanged(selectedOptions);
    super.initState();
  }

  void _addOption() {
    var newOption = controller.text;
    if (newOption.isNotEmpty) {
      setState(() {
        options.add(newOption);
        controller.text = "";
        selectedOptions.add(options.last);
      });
      widget.onSelectOptionsChanged(selectedOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.heading}:'),
        Wrap(
          spacing: MediaQuery.of(context).size.width * 0.02,
          children: [
            ...options.map(
              (option) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: CheckboxListTile(
                  title: Text(option),
                  value: selectedOptions.contains(option),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedOptions.add(option);
                      } else {
                        selectedOptions.remove(option);
                      }
                    });
                    widget.onSelectOptionsChanged(selectedOptions);
                  },
                ),
              ),
            ),

            // Adding more to the options by the user
            if (widget.showOtherOption)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: CheckboxListTile(
                    value: isOtherSelected,
                    title: const Text("Other"),
                    onChanged: (value) {
                      setState(() => isOtherSelected = value!);
                    }),
              ),
          ],
        ),
        if (isOtherSelected)
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                ),
              ),
              TextButton(
                onPressed: _addOption,
                child: const Text('Add'),
              ),
            ],
          ),
      ],
    );
  }
}
