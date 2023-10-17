class AuthResponse {
  final String? refresh;
  final String? access;

  AuthResponse({
    this.refresh,
    this.access,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
