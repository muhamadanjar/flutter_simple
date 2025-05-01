class Training {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final int duration; // in seconds
  final List<String> equipment;

  Training({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.duration,
    required this.equipment,
  });

  @override
  String toString() {
    return 'Training{id: $id, name: $name, description: $description, imageUrl: $imageUrl, videoUrl: $videoUrl, duration: $duration, equipment: $equipment}';
  }
}