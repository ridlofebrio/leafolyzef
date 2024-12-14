import 'package:equatable/equatable.dart';

abstract class DetectionEvent extends Equatable {
  const DetectionEvent();

  @override
  List<Object?> get props => [];

  const factory DetectionEvent.update({
    required int id,
    required String title,
    required String imagePath,
    required List<int> diseaseIds,
  }) = UpdateDetection;
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
  final String title;
  final String imagePath;
  final List<int> diseaseIds;

  const UpdateDetection({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.diseaseIds,
  });

  @override
  List<Object> get props => [id, title, imagePath, diseaseIds];
}

class Delete extends DetectionEvent {
  final int id;

  const Delete(this.id);

  @override
  List<Object?> get props => [id];
}
