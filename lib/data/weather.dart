// To parse this JSON data, do
//
//     final weatherJson = weatherJsonFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

WeatherJson weatherJsonFromJson(String str) => WeatherJson.fromJson(json.decode(str));

String weatherJsonToJson(WeatherJson data) => json.encode(data.toJson());

class WeatherJson {
    Response response;

    WeatherJson({
        required this.response,
    });

    factory WeatherJson.fromJson(Map<String, dynamic> json) => WeatherJson(
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response.toJson(),
    };
}

class Response {
    Header header;
    Body body;

    Response({
        required this.header,
        required this.body,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        header: Header.fromJson(json["header"]),
        body: Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "body": body.toJson(),
    };
}

class Body {
    String dataType;
    Items items;
    int pageNo;
    int numOfRows;
    int totalCount;

    Body({
        required this.dataType,
        required this.items,
        required this.pageNo,
        required this.numOfRows,
        required this.totalCount,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        dataType: json["dataType"],
        items: Items.fromJson(json["items"]),
        pageNo: json["pageNo"],
        numOfRows: json["numOfRows"],
        totalCount: json["totalCount"],
    );

    Map<String, dynamic> toJson() => {
        "dataType": dataType,
        "items": items.toJson(),
        "pageNo": pageNo,
        "numOfRows": numOfRows,
        "totalCount": totalCount,
    };
}

class Items {
    List<Item> item;

    Items({
        required this.item,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item": List<dynamic>.from(item.map((x) => x.toJson())),
    };
}

class Item {
    String baseDate;
    String baseTime;
    Category category;
    String fcstDate;
    String fcstTime;
    String fcstValue;
    int nx;
    int ny;

    Item({
        required this.baseDate,
        required this.baseTime,
        required this.category,
        required this.fcstDate,
        required this.fcstTime,
        required this.fcstValue,
        required this.nx,
        required this.ny,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        baseDate: json["baseDate"],
        baseTime: json["baseTime"],
        category: categoryValues.map[json["category"]]!,
        fcstDate: json["fcstDate"],
        fcstTime: json["fcstTime"],
        fcstValue: json["fcstValue"],
        nx: json["nx"],
        ny: json["ny"],
    );

    Map<String, dynamic> toJson() => {
        "baseDate": baseDate,
        "baseTime": baseTime,
        "category": categoryValues.reverse[category],
        "fcstDate": fcstDate,
        "fcstTime": fcstTime,
        "fcstValue": fcstValue,
        "nx": nx,
        "ny": ny,
    };
}

enum Category {
    PCP,
    POP,
    PTY,
    REH,
    SKY,
    SNO,
    TMN,
    TMP,
    TMX,
    UUU,
    VEC,
    VVV,
    WAV,
    WSD
}

final categoryValues = EnumValues({
    "PCP": Category.PCP,
    "POP": Category.POP,
    "PTY": Category.PTY,
    "REH": Category.REH,
    "SKY": Category.SKY,
    "SNO": Category.SNO,
    "TMN": Category.TMN,
    "TMP": Category.TMP,
    "TMX": Category.TMX,
    "UUU": Category.UUU,
    "VEC": Category.VEC,
    "VVV": Category.VVV,
    "WAV": Category.WAV,
    "WSD": Category.WSD
});

class Header {
    String resultCode;
    String resultMsg;

    Header({
        required this.resultCode,
        required this.resultMsg,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        resultCode: json["resultCode"],
        resultMsg: json["resultMsg"],
    );

    Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "resultMsg": resultMsg,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
