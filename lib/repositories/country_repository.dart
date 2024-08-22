import 'package:dio/dio.dart';
import '../api/country_api.dart';
import '../models/country.dart';

class CountryRepository {
  final CountryApi _countryApi;

  CountryRepository(this._countryApi);

  Future<List<Country>> fetchEuropeanCountries() async {
    try {
      return await _countryApi.getEuropeanCountries();
    } catch (e) {
      throw Exception("Failed to load countries");
    }
  }
}
