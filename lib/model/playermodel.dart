class PlayerModel {
  // Fields
  final String name; // Player's name
  final String email; // Player's email address
  final String userProfile; // Profile picture or URL
  final String number; // Jersey or player number
  final String position; // Playing position (e.g., Forward, Defender)
  final String fit; // Fitness status (e.g., Fit, Injured)
  final String teamId;

  // Constructor
  PlayerModel({
    required this.name,
    required this.email,
    required this.userProfile,
    required this.number,
    required this.position,
    required this.fit,
    required this.teamId
  });

  factory PlayerModel.fromFirestore(Map<String, dynamic> data) {
    return PlayerModel(
      name: data['name'] ?? 'Unknown',
      email: data['email'] ?? 'No Email',
      userProfile: data['userProfile'] ?? '',
      number: data['number'] ?? 'not assigned',
      position: data['position'] ?? 'Unknown',
      fit: data['fit'] ?? 'Unknown',
     
      teamId: data['teamId'] ?? '',
    );
  }
}
