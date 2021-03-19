import 'dart:convert';

import 'package:http/http.dart' as http;



class OfficesList {
  List<Office>? offices;
  OfficesList({this.offices});

  // For handle serializable
    factory OfficesList.fromJson(Map<String?, dynamic>?/*?*//*?*/ json) {
    var officesJson = json!['offices'] as List;

    List<Office> officesList = officesJson.map((i) => Office.fromJson(i)).toList();

    return OfficesList(
      offices: officesList,
    );
  }

/*  factory OfficesList.fromJson(Map<String, dynamic> json) => _$OfficesListFromJson(json);
  Map<String, dynamic> toJson() => _$OfficesListToJson(this);*/
}


class Office {
/*  @JsonKey(name: 'dt') // dt
  DateTime dateTime;*/
  final String? name;
  final String? address;
  final String? image;

  Office({ this.name, this.address, this.image });

  //  For handle serializable
  factory Office.fromJson(Map<String?, dynamic>? json) {
    return Office(
      name: json!['name'] as String?,
      address: json['address'] as String?,
      image: json['image'] as String?,
    );
  }


  /*factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);*/
}

Future<OfficesList> getOfficesList() async {
  var url = Uri.https('about.google', 'static/data/locations.json', {'q': '{https}'});

  final response = await http.get(url);

  if(response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
