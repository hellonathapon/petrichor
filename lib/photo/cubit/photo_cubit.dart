import 'package:bloc/bloc.dart';
import 'package:petrichor/weather/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:petrichor/photo/photo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:photo_repository/photo_repository.dart' show PhotoRepository;

part 'photo_cubit.g.dart';
part 'photo_state.dart';

class PhotoCubit extends HydratedCubit<PhotoState> {
  PhotoCubit(this._photoRepository)
      : super(const PhotoState(fallbackPhoto: fallbackPhoto));

  final PhotoRepository _photoRepository;
  static const fallbackPhoto = 'assets/cozy-raining.jpg';

  Future<void> updatePhoto(WeatherCondition weatherCondition) async {
    try {
      final photo = Photo.fromRepository(
        await _photoRepository.getPhoto(weatherCondition.name),
      );

      // update the PhotoState
      emit(
        state.copyWith(
          status: PhotoStatus.success,
          networkPhoto: photo,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }

  @override
  PhotoState? fromJson(Map<String, dynamic> json) {
    PhotoState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PhotoState state) => state.toJson();
}
