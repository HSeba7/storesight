import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:storesight/extensions/string_extension.dart';
import 'package:storesight/infrastructure/request.dart';

enum FileUploadType { profileImage, carType, company, makes, rental }

extension FileUploadTypeExtension on FileUploadType {
  String get name => describeEnum(this);

  String getParamValue() {
    return name.capitalize();
  }
}

class FileUploadRequest {
  List<File> files;
  String fileParam;
  FileUploadType uploadType;

  FileUploadRequest(
      {required this.files,
      required this.uploadType,
      this.fileParam = 'image'});
}

class FileUploadResponse extends Serialized {
  late List<String>? fileIds;

  FileUploadResponse(this.fileIds);

  FileUploadResponse.fromJson(final Map<String, dynamic> map) {
    fileIds = convertList(map['fileIds'], (e) => e.toString());
  }

  @override
  Map<String, dynamic> toJson() => {'fileIds': fileIds?.toString()};
}
