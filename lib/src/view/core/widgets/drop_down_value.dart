class DropDownValue {
  DropDownValue({
    this.id,
    this.value,
    this.code,
    this.ratio,
  });

  int? id;
  String? value;
  dynamic code;
  double? ratio;
  factory DropDownValue.fromJson(Map<String, dynamic> json) => DropDownValue(
      id: int.parse(json['id'].toString()),
      value: json['value'].toString(),
      code: json['code'].toString(),
      ratio: json['ratio']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'code': code,
        'ratio': ratio,
      };
  @override
  String toString() {
    return value ?? '';
  }
}
