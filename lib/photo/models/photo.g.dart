// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Photo',
      json,
      ($checkedConvert) {
        final val = Photo(
          id: $checkedConvert('id', (v) => v as String),
          firstName: $checkedConvert('first_name', (v) => v as String),
          lastName: $checkedConvert('last_name', (v) => v as String),
          networkFullUrl:
              $checkedConvert('network_full_url', (v) => v as String),
          networkRawUrl: $checkedConvert('network_raw_url', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'firstName': 'first_name',
        'lastName': 'last_name',
        'networkFullUrl': 'network_full_url',
        'networkRawUrl': 'network_raw_url'
      },
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'network_full_url': instance.networkFullUrl,
      'network_raw_url': instance.networkRawUrl,
    };
