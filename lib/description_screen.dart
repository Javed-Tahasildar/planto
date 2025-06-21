// import 'package:flutter/material.dart';
// import 'package:planto/detail_screen_base.dart';
// import 'package:planto/plant_data.dart';

// class DescriptionScreen extends StatelessWidget {
//   final PlantData plantData;

//   const DescriptionScreen({super.key, required this.plantData});

//   @override
//   Widget build(BuildContext context) {
//     return DetailScreenBase(
//       title: 'Description',
//       icon: Icons.description,
//       color: Colors.blue,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Plant Header Card
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.blue[50]!, Colors.blue[100]!],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.local_florist,
//                       size: 36,
//                       color: Colors.blue[600],
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           plantData.commonName ?? 'Unknown Plant',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue[900],
//                           ),
//                         ),
//                         if (plantData.scientificName != null)
//                           Text(
//                             plantData.scientificName!,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontStyle: FontStyle.italic,
//                               color: Colors.blue[800],
//                             ),
//                           ),
//                         if (plantData.family != null)
//                           Padding(
//                             padding: EdgeInsets.only(top: 4),
//                             child: Text(
//                               'Family: ${plantData.family}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.blue[700],
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),

//             // Description Card
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.article,
//                         color: Colors.blue[600],
//                         size: 24,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Detailed Description',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     plantData.description ?? 'No description available for this plant.',
//                     style: TextStyle(
//                       fontSize: 15,
//                       height: 1.6,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Divider(),
//                   SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.history_edu,
//                         color: Colors.blue[600],
//                         size: 24,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Historical Significance',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     plantData.historicalInfo ??
//                     'This plant has been valued in various cultures for its beauty and utility. Many plants like this have played important roles in traditional medicine, ceremonies, and daily life throughout history.',
//                     style: TextStyle(
//                       fontSize: 15,
//                       height: 1.6,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),

//             // Visual Characteristics
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Visual Characteristics',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: [
//                       _buildFeatureChip(
//                         icon: Icons.palette,
//                         label: 'Color: ${plantData.primaryColor ?? 'Green'}',
//                         color: Colors.blue,
//                       ),
//                       _buildFeatureChip(
//                         icon: Icons.straighten,
//                         label: 'Height: ${plantData.matureSize ?? 'Medium'}',
//                         color: Colors.green,
//                       ),
//                       _buildFeatureChip(
//                         icon: Icons.eco,
//                         label: 'Leaf Type: ${plantData.leafType ?? 'Broad'}',
//                         color: Colors.teal,
//                       ),
//                       _buildFeatureChip(
//                         icon: Icons.wb_sunny,
//                         label: 'Season: ${plantData.bloomSeason ?? 'Various'}',
//                         color: Colors.orange,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),

//             // Did You Know Section
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.blue[100]!, Colors.blue[50]!],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.lightbulb,
//                         color: Colors.blue[800],
//                         size: 24,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Did You Know?',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue[900],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     plantData.interestingFacts ??
//                         'Plants like this contribute significantly to their ecosystems, providing oxygen, food, and habitat for wildlife. Many also have surprising uses in medicine, industry, and culture that aren\'t widely known.',
//                     style: TextStyle(
//                       fontSize: 15,
//                       height: 1.6,
//                       color: Colors.blue[800],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureChip({
//     required IconData icon,
//     required String label,
//     required Color color,
//   }) {
//     return Chip(
//       avatar: Icon(
//         icon,
//         size: 18,
//         color: color,
//       ),
//       label: Text(
//         label,
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.grey[700],
//         ),
//       ),
//       backgroundColor: color.withOpacity(0.1),
//       side: BorderSide(
//         color: color.withOpacity(0.3),
//         width: 1,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:planto/detail_screen_base.dart';
import 'package:planto/plant_data.dart';

// Description Screen
class DescriptionScreen extends StatelessWidget {
  final PlantData plantData;

  const DescriptionScreen({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return DetailScreenBase(
      title: 'Description',
      icon: Icons.description,
      color: Colors.blue,
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
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.description,
                    color: Colors.blue[600],
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
              'Plant Description',
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
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Text(
                plantData.description ?? 'Description not available.',
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
