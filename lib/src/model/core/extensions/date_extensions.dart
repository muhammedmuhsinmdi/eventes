extension DateExtension on DateTime {
  String formattedDate() {
    return "${this.year}-${_twoDigits(this.month)}-${_twoDigits(this.day)}";
  }

  String formattedTime() {
    return "${_twoDigits(this.hour)}:${_twoDigits(this.minute)}:${_twoDigits(this.second)}";
  }

  String formattedDateTime() {
    return "${formattedDate()} ${formattedTime()}";
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
  
}

extension StringToDateExtension on String {
  DateTime toDate() {
    try {
      if (this.contains('T')) {
        // Parse the "2023-11-21T00:00:00.000" format
        return DateTime.parse(this);
      } else {
        // Parse the "10-Nov-2023" format
        final List<String> parts = this.split('-');
        final int day = int.parse(parts[0]);
        final int month = _getMonthNumber(parts[1]);
        final int year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      // Handle parsing error
      print("Error parsing date: $e");
      return DateTime.now();
    }
  }

  int _getMonthNumber(String monthAbbreviation) {
    const monthAbbreviations = [
      "", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return monthAbbreviations.indexOf(monthAbbreviation);
  }
}