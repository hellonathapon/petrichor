part of 'photo_cubit.dart';

enum PhotoStatus { initial, failure, success }

@JsonSerializable()
class PhotoState extends Equatable {
  // Instantiate an empty instance for initial status.
  const PhotoState({
    this.status = PhotoStatus.initial,
    required this.fallbackPhoto,
    Photo? networkPhoto,
  }) : networkPhoto = networkPhoto ?? Photo.empty;

  factory PhotoState.fromJson(Map<String, dynamic> json) =>
      _$PhotoStateFromJson(json);

  final PhotoStatus status;
  final Photo networkPhoto;
  final String fallbackPhoto;

  PhotoState copyWith({
    PhotoStatus? status,
    Photo? networkPhoto,
    String? fallbackPhoto,
  }) {
    return PhotoState(
      status: status ?? this.status,
      networkPhoto: networkPhoto ?? this.networkPhoto,
      fallbackPhoto: fallbackPhoto ?? this.fallbackPhoto,
    );
  }

  Map<String, dynamic> toJson() => _$PhotoStateToJson(this);

  @override
  List<Object> get props => [status, networkPhoto, fallbackPhoto];
}
