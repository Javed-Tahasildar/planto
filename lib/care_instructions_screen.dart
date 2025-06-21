import 'package:flutter/material.dart';
import 'package:planto/detail_screen_base.dart';
import 'package:planto/plant_data.dart';

// Care Instructions Screen
class CareInstructionsScreen extends StatelessWidget {
  final PlantData plantData;

  const CareInstructionsScreen({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return DetailScreenBase(
      title: 'Care Instructions',
      icon: Icons.water_drop,
      color: Colors.cyan,
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
                    // Care Instructions Screen (continued)
                    color: Colors.cyan[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.water_drop,
                    color: Colors.cyan[600],
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
            Text(
              'Care Instructions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.cyan[200]!),
              ),
              child: Text(
                plantData.careInstructions ??
                    'Care instructions not available.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
