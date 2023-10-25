extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension MapExtensions on Map<String, dynamic> {
  String jsonToQueryParam() {
    List<String> parts = [];

    forEach((key, value) {
      if (value != null) {
        parts.add('$key=${Uri.encodeQueryComponent(value.toString())}');
      }
    });

    return parts.join('&');
  }
}