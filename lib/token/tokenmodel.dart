import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TokenModel {
  TokenModel({
    this.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        token: asT<String?>(json['token']),
      );

  String? token;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
      };

  TokenModel copy() {
    return TokenModel(
      token: token,
    );
  }
}
