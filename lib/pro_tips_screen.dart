import 'package:flutter/material.dart';
import 'package:planto/detail_screen_base.dart';

// Pro Tips Screen
class ProTipsScreen extends StatelessWidget {
  const ProTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailScreenBase(
      title: 'Pro Tips',
      icon: Icons.tips_and_updates,
      color: Colors.teal,
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
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.tips_and_updates,
                    color: Colors.teal[600],
                    size: 28,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Plant Care Tips',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            _buildTipItem(
              icon: Icons.camera_alt,
              title: 'Better Identification',
              tip:
                  'Take photos in good natural light, focusing on leaves, flowers, and distinctive features.',
            ),
            SizedBox(height: 12),
            _buildTipItem(
              icon: Icons.water_drop,
              title: 'Watering Wisdom',
              tip:
                  'Check soil moisture 1-2 inches deep. Overwatering is more harmful than underwatering for most plants.',
            ),
            SizedBox(height: 12),
            _buildTipItem(
              icon: Icons.wb_sunny,
              title: 'Light Requirements',
              tip:
                  'Observe how your plant responds to its location. Yellow leaves may indicate too much light, while leggy growth suggests too little.',
            ),
            SizedBox(height: 12),
            _buildTipItem(
              icon: Icons.clean_hands,
              title: 'Plant Hygiene',
              tip:
                  'Regularly clean leaves to remove dust and allow for better photosynthesis. Check for pests during cleaning.',
            ),
            SizedBox(height: 12),
            _buildTipItem(
              //              icon: Icons.seasonal_considerations,
              icon: Icons.cloud,
              title: 'Seasonal Care',
              tip:
                  'Most plants need less water in winter. Adjust care routines with seasonal changes in temperature and light.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem({
    required IconData icon,
    required String title,
    required String tip,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.teal[600], size: 20),
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
                SizedBox(height: 8),
                Text(
                  tip,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
