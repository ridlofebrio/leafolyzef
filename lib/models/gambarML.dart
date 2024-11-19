import 'package:equatable/equatable.dart';

class GambarML extends Equatable {
  final String gambarUrl;
  final int userId;
  final String description;

  const GambarML({
    required this.gambarUrl,
    required this.userId,
    required this.description,
  });

  factory GambarML.fromJson(Map<String, dynamic> json) {
    return GambarML(
      gambarUrl: json['gambarUrl'] ?? '', // Default value if null
      userId: json['user_id'] ?? 0, // Default value if null
      description: json['description'] ?? 'No description', // Default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gambarUrl': gambarUrl,
      'user_id': userId,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
        gambarUrl,
        userId,
        description,
      ];
}
