import 'package:flutter/material.dart';
import 'models/weather_model.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🌦 Weather App")),
      body: FutureBuilder<Weather>(
        future: _weatherService.fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text("Lỗi: ${snapshot.error}",
                    style: const TextStyle(fontSize: 16)));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Không có dữ liệu"));
          }

          final weather = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weather.cityName,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Image.network(
                    "https://openweathermap.org/img/wn/${weather.icon}@2x.png"),
                Text("${weather.temperature.toStringAsFixed(1)}°C",
                    style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 10),
                Text(weather.description,
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.refresh),
                  label: const Text("Làm mới"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
