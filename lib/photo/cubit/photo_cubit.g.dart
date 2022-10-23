// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoState _$PhotoStateFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PhotoState',
      json,
      ($checkedConvert) {
        final val = PhotoState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$PhotoStatusEnumMap, v) ??
                  PhotoStatus.initial),
          fallbackPhoto: $checkedConvert('fallback_photo', (v) => v as String),
          networkPhoto: $checkedConvert(
              'network_photo',
              (v) =>
                  v == null ? null : Photo.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'fallbackPhoto': 'fallback_photo',
        'networkPhoto': 'network_photo'
      },
    );

Map<String, dynamic> _$PhotoStateToJson(PhotoState instance) =>
    <String, dynamic>{
      'status': _$PhotoStatusEnumMap[instance.status]!,
      'network_photo': instance.networkPhoto.toJson(),
      'fallback_photo': instance.fallbackPhoto,
    };

const _$PhotoStatusEnumMap = {
  PhotoStatus.initial: 'initial',
  PhotoStatus.failure: 'failure',
  PhotoStatus.success: 'success',
};
