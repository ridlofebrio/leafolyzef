import 'package:equatable/equatable.dart';

abstract class DetectionEvent extends Equatable {
  const DetectionEvent();

  @override
  List<Object?> get props => [];
}

class SaveDetection extends DetectionEvent {
  final String title;
  final String imagePath;
  final List<int>? diseaseIds;

  const SaveDetection({
    required this.title,
    required this.imagePath,
    this.diseaseIds,
  });

  @override
  List<Object?> get props => [title, imagePath, diseaseIds];
}

class UpdateDetection extends DetectionEvent {
  final int id;
  final String? title;
  final String? imagePath;
  final List<int>? diseaseIds;

  const UpdateDetection({
    required this.id,
    this.title,
    this.imagePath,
    this.diseaseIds,
  });

  @override
  List<Object?> get props => [id, title, imagePath, diseaseIds];
}
