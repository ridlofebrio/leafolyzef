import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/detection/detection_event.dart';
import 'package:leafolyze/blocs/detection/detection_state.dart';
import 'package:leafolyze/repositories/detection_repository.dart';

class DetectionBloc extends Bloc<DetectionEvent, DetectionState> {
  final DetectionRepository _repository;

  DetectionBloc(this._repository) : super(DetectionInitial()) {
    on<SaveDetection>(_onSaveDetection);
    on<UpdateDetection>(_onUpdateDetection);
  }

  Future<void> _onSaveDetection(
    SaveDetection event,
    Emitter<DetectionState> emit,
  ) async {
    emit(DetectionLoading());
    try {
      final detection = await _repository.createDetection(
        title: event.title,
        imagePath: event.imagePath,
        diseaseIds: event.diseaseIds,
      );
      emit(DetectionSuccess(detection));
    } catch (e) {
      emit(DetectionError(e.toString()));
    }
  }

  Future<void> _onUpdateDetection(
    UpdateDetection event,
    Emitter<DetectionState> emit,
  ) async {
    emit(DetectionLoading());
    try {
      final detection = await _repository.updateDetection(
        id: event.id,
        title: event.title,
        imagePath: event.imagePath,
        diseaseIds: event.diseaseIds,
      );
      emit(DetectionSuccess(detection));
    } catch (e) {
      emit(DetectionError(e.toString()));
    }
  }
}
