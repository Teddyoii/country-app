import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../api/country_api.dart';
import '../models/country.dart';
import '../repositories/country_repository.dart';
import 'country_detail_page.dart';

class CountryListPage extends StatefulWidget {
  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  late Future<List<Country>> _countries;
  late CountryRepository _countryRepository;
  String _sortCriteria = 'name';

  @override
  void initState() {
    super.initState();
    Dio dio = Dio();
    _countryRepository = CountryRepository(CountryApi(dio));
    _countries = _countryRepository.fetchEuropeanCountries();
  }

  List<Country> _sortCountries(List<Country> countries) {
    if (_sortCriteria == 'name') {
      countries.sort((a, b) => a.name!.common!.compareTo(b.name!.common!));
    } else if (_sortCriteria == 'population') {
      countries.sort((a, b) => a.population!.compareTo(b.population!));
    } else if (_sortCriteria == 'capital') {
      countries.sort((a, b) => a.capital![0].compareTo(b.capital![0]));
    }
    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('European Countries'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButton<String>(
              value: _sortCriteria,
              items: [
                DropdownMenuItem(value: 'name', child: Text('Name')),
                DropdownMenuItem(value: 'population', child: Text('Population')),
                DropdownMenuItem(value: 'capital', child: Text('Capital')),
              ],
              onChanged: (value) {
                setState(() {
                  _sortCriteria = value!;
                });
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Country>>(
        future: _countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load countries'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No countries found'));
          } else {
            List<Country> countries = _sortCountries(snapshot.data!);
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(country.flags!.png!),
                      radius: 30,
                    ),
                    title: Text(
                      country.name!.common!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      country.capital!.isNotEmpty ? country.capital![0] : 'No capital',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryDetailPage(country: country),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
