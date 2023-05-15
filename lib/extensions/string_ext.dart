extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (this == null || this.isEmpty || this.runtimeType != String) {
      return this;
    }
    int number;
    if (int.tryParse(this) != null) {
      number = int.parse(this);
      return number.toString();
    }
    return this[0].toUpperCase() + this.substring(1);
  }
}
