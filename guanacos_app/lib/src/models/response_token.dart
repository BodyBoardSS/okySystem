import 'dart:convert';

RequestToken requestTokenFromJson(String str) => RequestToken.fromJson(json.decode(str));

String requestTokenToJson(RequestToken data) => json.encode(data.toJson());

class RequestToken {
    String? accessToken;
    int? expiresIn;
    String? tokenType;
    String? scope;

    RequestToken({
        this.accessToken,
        this.expiresIn,
        this.tokenType,
        this.scope,
    });


    factory RequestToken.fromJson(Map<String, dynamic> json) => RequestToken(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        tokenType: json["token_type"],
        scope: json["scope"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "token_type": tokenType,
        "scope": scope,
    };
}
