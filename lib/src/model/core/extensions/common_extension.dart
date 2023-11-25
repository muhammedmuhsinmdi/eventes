extension AmountFormatting on int {
  String get formattedAmount {
    final String amountString = this.toString();
    final RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return amountString.replaceAllMapped(regExp, (Match match) => '${match[1]},');
  }
}