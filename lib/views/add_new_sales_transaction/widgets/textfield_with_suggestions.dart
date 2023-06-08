import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';

class TextFieldWithSuggestions extends StatefulWidget {

  final List<String> suggestions;

  const TextFieldWithSuggestions({Key? key, required this.suggestions,}): super(key: key);

  @override
  _TextFieldWithSuggestionsState createState() => _TextFieldWithSuggestionsState();
}

class _TextFieldWithSuggestionsState extends State<TextFieldWithSuggestions> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextField
        TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
          ),
          suggestionsCallback: (pattern) {
            // Filter the suggestions based on the input pattern
            return widget.suggestions.where((suggestion) =>
                suggestion.toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            _controller.text = suggestion;
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DottedLine(
            dashColor: ConstantAppColors.primaryColor.withOpacity(0.5),
            lineThickness: 2,
          ),
        ),
      ],
    );
  }
}
