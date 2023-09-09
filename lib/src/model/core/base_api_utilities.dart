Map<String, dynamic> apiHeaders(String token) {
  return {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };
}
