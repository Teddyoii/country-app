import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/country.dart';

part 'country_api.g.dart';

@RestApi(baseUrl: "https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population,capital")
abstract class CountryApi {
  factory CountryApi(Dio dio, {String baseUrl}) = _CountryApi;

  @GET("region/europe?fields=name,capital,flags,region,languages,population")
  Future<List<Country>> getEuropeanCountries();
}
