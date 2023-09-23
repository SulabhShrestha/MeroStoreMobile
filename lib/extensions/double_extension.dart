extension DoubleExtension on double {
  String formatWithIntegerCheck() {
    int intValue = this.toInt();
    double decimalValue = this - intValue;

    if (decimalValue == 0.0) {
      return intValue.toString(); // Display as integer if no decimal part
    } else if (decimalValue.toStringAsFixed(2) == "0.00") {
      return intValue.toString(); // Display as integer if decimal is .00
    } else {
      return this.toStringAsFixed(2); // Display with 2 decimal places otherwise
    }
  }
}
