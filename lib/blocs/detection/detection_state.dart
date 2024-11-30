import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/tomato_leaf_detection.dart';

abstract class DetectionState extends Equatable {
  const DetectionState();

  @override
  List<Object?> get props => [];
}

class DetectionInitial extends DetectionState {}

class DetectionLoading extends DetectionState {}

class DetectionSuccess extends DetectionState {
  final TomatoLeafDetection detection;

  const DetectionSuccess(this.detection);

  @override
  List<Object?> get props => [detection];
}

class DetectionError extends DetectionState {
  final String message;

  const DetectionError(this.message);

  @override
  List<Object?> get props => [message];
}
