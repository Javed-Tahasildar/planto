import 'package:flutter/material.dart';
import 'package:planto/plant_identifier_home.dart';

// Main App
class PlantIdentifierApp extends StatelessWidget {
  const PlantIdentifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Identifier',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.green[800],
        ),
      ),
      home: PlantIdentifierHome(),
    );
  }
}
