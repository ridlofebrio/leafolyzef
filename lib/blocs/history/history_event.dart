import 'package:equatable/equatable.dart';

abstract class GambarMLEvent extends Equatable {
  const GambarMLEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch all GambarML
class FetchAllGambarML extends GambarMLEvent {}

// Event to fetch GambarML by userId
class FetchGambarByUserId extends GambarMLEvent {
  final int userId;

  const FetchGambarByUserId(this.userId);

  @override
  List<Object?> get props => [userId];
}
