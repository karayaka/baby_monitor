class BaseError {
  String? date;
  String? key;
  List<String>? values;

  BaseError({this.date, this.key, this.values});
  BaseError.fromJson(Map<String, dynamic> map) {
    date = map["date"];
    key = map["key"];
    values = (map["values"] ?? map["Values"] ?? map["errors"]["model"][0])
        .cast<String>();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "date": date,
        "key": key,
        "values": values,
      };
}
