import 'package:flutter/material.dart';
import '../models/country.dart';

class CountryDetailPage extends StatelessWidget {
  final Country country;

  CountryDetailPage({required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name!.common!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  country.flags!.png!,
                  height: 150,
                  width: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              country.name!.official!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(height: 24, thickness: 2),
            Text(
              'Population: ${country.population}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Region: ${country.region}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Capital: ${country.capital!.isNotEmpty ? country.capital![0] : 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Languages: ${country.languages?.values.join(', ') ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
