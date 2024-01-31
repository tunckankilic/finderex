import 'dart:convert';

class DeleteAccountResponseModel {
  DeleteAccountResponseModel({
    this.deletedUsers,
  });

  final _Deleted? deletedUsers;

  DeleteAccountResponseModel copyWith({
    _Deleted? deletedUsers,
  }) =>
      DeleteAccountResponseModel(
        deletedUsers: deletedUsers ?? this.deletedUsers,
      );

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => DeleteAccountResponseModel(
        deletedUsers: json["deletedUsers"] == null
            ? null
            : _Deleted.fromJson(json["deletedUsers"]),
      );

  Map<String, dynamic> toJson() => {
        "deletedUsers": deletedUsers?.toJson(),
      };
}

class _Deleted {
  _Deleted({
    this.count,
  });

  final int? count;

  _Deleted copyWith({
    int? count,
  }) =>
      _Deleted(
        count: count ?? this.count,
      );

  factory _Deleted.fromRawJson(String str) =>
      _Deleted.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory _Deleted.fromJson(Map<String, dynamic> json) => _Deleted(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}
