import 'package:dartx/dartx.dart';

extension StringExtension on String {
  String camelCaseToWords() {
    List<String> words = this.split(RegExp(r'(?=[A-Z])'));
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].capitalize();
    }
    return words.join(' ');
  }
}
