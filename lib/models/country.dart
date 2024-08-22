import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Flags? flags;
  Name? name;
  List<String>? capital;
  String? region;
  Map<String, dynamic>? languages;
  int? population;

  Country({
    this.flags,
    this.name,
    this.capital,
    this.region,
    this.languages,
    this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        flags: json["flags"] == null ? null : Flags.fromJson(json["flags"]),
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        capital: json["capital"] == null ? [] : List<String>.from(json["capital"]!.map((x) => x)),
        region: json["region"],
        languages: json["languages"] == null ? null : Map<String, dynamic>.from(json["languages"]),
        population: json["population"],
      );

  Map<String, dynamic> toJson() => {
        "flags": flags?.toJson(),
        "name": name?.toJson(),
        "capital": capital == null ? [] : List<dynamic>.from(capital!.map((x) => x)),
        "region": region,
        "languages": languages,
        "population": population,
      };
}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({
    this.png,
    this.svg,
    this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
        "alt": alt,
      };
}

class Name {
  String? common;
  String? official;
  Map<String, dynamic>? nativeName;

  Name({
    this.common,
    this.official,
    this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
        nativeName: json["nativeName"] == null ? null : Map<String, dynamic>.from(json["nativeName"]),
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
        "nativeName": nativeName,
      };
}
