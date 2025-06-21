import 'package:flutter/material.dart';
import 'package:planto/detail_screen_base.dart';
import 'package:planto/plant_data.dart';

// Plant Care Guide Screen
class PlantCareGuideScreen extends StatelessWidget {
  final PlantData plantData;

  const PlantCareGuideScreen({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return DetailScreenBase(
      title: 'Plant Care Guide',
      icon: Icons.wb_sunny,
      color: Colors.orange,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.wb_sunny,
                    color: Colors.orange[600],
                    size: 28,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plantData.commonName ?? 'Unknown Plant',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      if (plantData.scientificName != null)
                        Text(
                          plantData.scientificName!,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            _buildCareItem(
              icon: Icons.wb_sunny,
              title: 'Sunlight',
              value: plantData.sunlight ?? 'Not specified',
              color: Colors.orange,
            ),
            SizedBox(height: 12),
            _buildCareItem(
              icon: Icons.water_drop,
              title: 'Water',
              value: plantData.water ?? 'Not specified',
              color: Colors.blue,
            ),
            SizedBox(height: 12),
            _buildCareItem(
              icon: Icons.terrain,
              title: 'Soil',
              value: plantData.soil ?? 'Not specified',
              color: Colors.brown,
            ),
            SizedBox(height: 12),
            _buildCareItem(
              icon: Icons.thermostat,
              title: 'Temperature',
              value: plantData.temperature ?? 'Not specified',
              color: Colors.red,
            ),
            SizedBox(height: 12),
            _buildCareItem(
              icon: Icons.air,
              title: 'Humidity',
              value: plantData.humidity ?? 'Not specified',
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
