import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApiPage extends StatefulWidget {
  const WeatherApiPage({super.key});

  @override
  State<WeatherApiPage> createState() => _WeatherApiPageState();
}

class _WeatherApiPageState extends State<WeatherApiPage> {
  List<dynamic> weatherData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather API"),
      ),
      body: weatherData.isEmpty
          ? const Center(child: Text("No data available. Tap the button to fetch data."))
          : ListView.builder(
              itemCount: weatherData.length,
              itemBuilder: (context, index) {
                final data = weatherData[index];
                final time = data['time'] ?? 'N/A';
                final temperature = data['temperature_2m']?.toString() ?? 'N/A';

                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text("Time: $time"),
                  subtitle: Text("Temperature: $temperature°C"),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchWeatherData,
        child: const Icon(Icons.add),
      ),
    );
  }

  void fetchWeatherData() async {
    const url =
        'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m&past_days=2';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);

        setState(() {
          weatherData = json['hourly']['time']
              .asMap()
              .entries
              .map((entry) => {
                    'time': entry.value,
                    'temperature_2m': json['hourly']['temperature_2m'][entry.key]
                  })
              .toList();
        });

        print("Fetch completed successfully.");
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
