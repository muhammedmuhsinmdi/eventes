import 'dart:async';

Timer? _debounce;

void debounceSearch(String query, Function(String) callback) {
  if (_debounce != null && _debounce!.isActive) {
    _debounce!.cancel();
  }

  _debounce = Timer(const Duration(milliseconds: 500), () {
    callback(query);
  });
}
