// Main Home Screen
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:planto/care_instructions_screen.dart';
import 'package:planto/climate_requirements_screen.dart';
import 'package:planto/description_screen.dart';
import 'package:planto/growth_size_screen.dart';
import 'package:planto/interesting_facts_screen.dart';
import 'package:planto/native_region_screen.dart';
import 'package:planto/plant_care_guide_screen.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:planto/plant_data.dart';
import 'package:planto/pro_tips_screen.dart';
import 'package:planto/toxicity_info_screen.dart';

class PlantIdentifierHome extends StatefulWidget {
  const PlantIdentifierHome({super.key});

  @override
  _PlantIdentifierHomeState createState() => _PlantIdentifierHomeState();
}

class _PlantIdentifierHomeState extends State<PlantIdentifierHome>
    with TickerProviderStateMixin {
  File? _selectedImage;
  PlantData? _plantData;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Replace with your actual Google Gemini API key
  final String _apiKey = 'AIzaSyC0FZUpgH4-qoiWUKoX3gbF6952ZdKuMEI';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _plantData = null;
        });
        _fadeController.forward();
        await _identifyPlant();
      }
    } catch (e) {
      _showErrorDialog('Failed to pick image: $e');
    }
  }

  Future<void> _identifyPlant() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Uint8List imageBytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text':
                      'Please identify this plant and provide the following information in JSON format:\n\n'
                      '{\n'
                      '  "commonName": "[Common name]",\n'
                      '  "scientificName": "[Scientific name]",\n'
                      '  "family": "[Plant family]",\n'
                      '  "description": "[Brief description of the plant]",\n'
                      '  "careInstructions": "[Basic care requirements]",\n'
                      '  "interestingFacts": "[2-3 interesting facts]",\n'
                      '  "nativeRegion": "[Where the plant originates from]",\n'
                      '  "sunlight": "[Light requirements]",\n'
                      '  "water": "[Watering needs]",\n'
                      '  "soil": "[Soil type preference]",\n'
                      '  "temperature": "[Temperature range]",\n'
                      '  "humidity": "[Humidity requirements]",\n'
                      '  "toxicity": "[Safe for pets/humans or toxic]",\n'
                      '  "growthRate": "[Fast/Medium/Slow]",\n'
                      '  "matureSize": "[Expected size when mature]"\n'
                      '}\n\n'
                      'If you cannot identify the plant with confidence, return JSON with "commonName": "Unknown Plant" and fill other fields with general observations.',
                },
                {
                  'inline_data': {
                    'mime_type': 'image/jpeg',
                    'data': base64Image,
                  },
                },
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        String plantIdentification = '';
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final candidate = data['candidates'][0];
          if (candidate['content'] != null &&
              candidate['content']['parts'] != null) {
            final parts = candidate['content']['parts'];
            if (parts.isNotEmpty && parts[0]['text'] != null) {
              plantIdentification = parts[0]['text'].toString();
            }
          }
        }

        if (plantIdentification.isEmpty) {
          throw Exception('No plant identification data received');
        }

        PlantData? parsedData = _parsePlantInfo(plantIdentification);

        setState(() {
          _plantData = parsedData;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to identify plant: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Failed to identify plant: $e');
    }
  }

  PlantData? _parsePlantInfo(String plantInfo) {
    if (plantInfo.isEmpty) return null;

    try {
      String cleanedInfo = plantInfo.trim();
      final jsonStart = cleanedInfo.indexOf('{');
      final jsonEnd = cleanedInfo.lastIndexOf('}') + 1;

      if (jsonStart != -1 && jsonEnd > jsonStart) {
        final jsonString = cleanedInfo.substring(jsonStart, jsonEnd);
        final parsed = jsonDecode(jsonString);
        return PlantData.fromJson(parsed);
      }
    } catch (e) {
      print('JSON parsing error: $e');
    }
    return null;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 8),
              Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Choose Image Source',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSourceOption(
                    context,
                    Icons.camera_alt,
                    'Camera',
                    () => _pickImage(ImageSource.camera),
                  ),
                  _buildSourceOption(
                    context,
                    Icons.photo_library,
                    'Gallery',
                    () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceOption(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.green[600]),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.eco, color: Colors.green[600]),
            SizedBox(width: 8),
            Text(
              'Plant Identifier',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome Card (shown when no image)
              if (_selectedImage == null) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[400]!, Colors.green[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.local_florist, size: 64, color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Discover Nature',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Upload a photo to identify any plant instantly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
              ],

              // Image Display with Plant Name
              if (_selectedImage != null) ...[
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Image
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        // Plant Name Section
                        if (_plantData != null) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_florist,
                                      color: Colors.green[600],
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _plantData!.commonName ??
                                            'Unknown Plant',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (_plantData!.scientificName != null) ...[
                                  SizedBox(height: 4),
                                  Text(
                                    _plantData!.scientificName!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                                if (_plantData!.family != null) ...[
                                  SizedBox(height: 4),
                                  Text(
                                    'Family: ${_plantData!.family}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],

              // Upload Button
              Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _showImageSourceDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.green.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, size: 24),
                      SizedBox(width: 12),
                      Text(
                        _selectedImage == null
                            ? 'Upload Plant Image'
                            : 'Change Image',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Loading Indicator
              if (_isLoading) ...[
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green[600]!,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Analyzing your plant...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Navigation Buttons (shown when plant is identified)
              if (_plantData != null && !_isLoading) ...[
                Container(
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
                      Text(
                        'Explore Plant Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 20),

                      _buildDetailButton(
                        icon: Icons.description,
                        title: 'Description',
                        color: Colors.blue,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DescriptionScreen(plantData: _plantData!),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.water_drop,
                        title: 'Care Instructions',
                        color: Colors.cyan,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CareInstructionsScreen(plantData: _plantData!),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.wb_sunny,
                        title: 'Plant Care Guide',
                        color: Colors.orange,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlantCareGuideScreen(plantData: _plantData!),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.lightbulb,
                        title: 'Interesting Facts',
                        color: Colors.amber,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InterestingFactsScreen(plantData: _plantData!),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.warning,
                        title: 'Toxicity Info',
                        color: Colors.red,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ToxicityInfoScreen(plantData: _plantData!),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.height,
                        title: 'Growth and Size',
                        color: Colors.green,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GrowthSizeScreen(plantData: _plantData!),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.public,
                        title: 'Native Region',
                        color: Colors.indigo,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NativeRegionScreen(plantData: _plantData!),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.thermostat,
                        title: 'Climate Requirements',
                        color: Colors.purple,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClimateRequirementsScreen(
                              plantData: _plantData!,
                            ),
                          ),
                        ),
                      ),

                      _buildDetailButton(
                        icon: Icons.tips_and_updates,
                        title: 'Pro Tips',
                        color: Colors.teal,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProTipsScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
