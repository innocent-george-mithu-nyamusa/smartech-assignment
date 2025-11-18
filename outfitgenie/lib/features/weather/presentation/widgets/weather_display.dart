import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';

/// Weather display widget
class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  final bool isCached;

  const WeatherDisplay({
    super.key,
    required this.weather,
    this.isCached = false,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Trigger refresh
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Location
            Text(
              weather.location,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Cached indicator
            if (isCached)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.offline_bolt, size: 16, color: Colors.orange[700]),
                    const SizedBox(width: 4),
                    Text(
                      'Cached Data',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Main weather card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Temperature
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '°C',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Condition
                    Text(
                      weather.condition,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),

                    // Feels like
                    Text(
                      'Feels like ${weather.feelsLike.toStringAsFixed(1)}°C',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Details grid
            Row(
              children: [
                Expanded(
                  child: _DetailCard(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: '${weather.humidity}%',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _DetailCard(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Weather category chip
            Center(
              child: Chip(
                avatar: Icon(
                  _getWeatherIcon(weather.weatherCategory),
                  size: 20,
                ),
                label: Text(weather.weatherCategory),
                backgroundColor: _getWeatherColor(weather.weatherCategory).withOpacity(0.2),
              ),
            ),
            const SizedBox(height: 16),

            // Weather indicators
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                if (weather.isRainy)
                  const Chip(
                    avatar: Icon(Icons.umbrella, size: 16),
                    label: Text('Rainy'),
                    backgroundColor: Colors.blue,
                  ),
                if (weather.isSunny)
                  const Chip(
                    avatar: Icon(Icons.wb_sunny, size: 16),
                    label: Text('Sunny'),
                    backgroundColor: Colors.orange,
                  ),
                if (weather.isWindy)
                  const Chip(
                    avatar: Icon(Icons.wind_power, size: 16),
                    label: Text('Windy'),
                    backgroundColor: Colors.teal,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String category) {
    switch (category) {
      case 'Hot':
        return Icons.local_fire_department;
      case 'Warm':
        return Icons.wb_sunny;
      case 'Mild':
        return Icons.wb_cloudy;
      case 'Cool':
        return Icons.cloud;
      case 'Cold':
        return Icons.ac_unit;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color _getWeatherColor(String category) {
    switch (category) {
      case 'Hot':
        return Colors.red;
      case 'Warm':
        return Colors.orange;
      case 'Mild':
        return Colors.green;
      case 'Cool':
        return Colors.blue;
      case 'Cold':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
