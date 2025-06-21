// Plant Data Model
class PlantData {
  final String? commonName;
  final String? scientificName;
  final String? family;
  final String? description;
  final String? careInstructions;
  final String? interestingFacts;
  final String? nativeRegion;
  final String? sunlight;
  final String? water;
  final String? soil;
  final String? temperature;
  final String? humidity;
  final String? toxicity;
  final String? growthRate;
  final String? matureSize;

  PlantData({
    this.commonName,
    this.scientificName,
    this.family,
    this.description,
    this.careInstructions,
    this.interestingFacts,
    this.nativeRegion,
    this.sunlight,
    this.water,
    this.soil,
    this.temperature,
    this.humidity,
    this.toxicity,
    this.growthRate,
    this.matureSize,
  });

  factory PlantData.fromJson(Map<String, dynamic> json) {
    return PlantData(
      commonName: json['commonName']?.toString(),
      scientificName: json['scientificName']?.toString(),
      family: json['family']?.toString(),
      description: json['description']?.toString(),
      careInstructions: json['careInstructions']?.toString(),
      interestingFacts: json['interestingFacts']?.toString(),
      nativeRegion: json['nativeRegion']?.toString(),
      sunlight: json['sunlight']?.toString(),
      water: json['water']?.toString(),
      soil: json['soil']?.toString(),
      temperature: json['temperature']?.toString(),
      humidity: json['humidity']?.toString(),
      toxicity: json['toxicity']?.toString(),
      growthRate: json['growthRate']?.toString(),
      matureSize: json['matureSize']?.toString(),
    );
  }
}
