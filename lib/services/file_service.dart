import 'dart:io';
import 'package:storesight/infrastructure/http_service.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/models/file_upload.dart';

class FileService {
  final HttpService _httpService = HttpService();
  Future<void> uploadImage({File? image}) async {
    if (image == null) throw Exception("image not selected");
    try {
      var response = await _httpService.uploadFile(
        "/api/update-profile-image/",
        FileUploadRequest(
          files: [image],
          uploadType: FileUploadType.profileImage,
        ),
      );

      printLn(response);
    } catch (e) {
      printLn(e.toString());
    }
  }

  Future<void> uploadImages({List<File>? images}) async {
    if (images == null || images.isEmpty) throw Exception("image not selected");
    try {
      var response = await _httpService.uploadFile(
        "/api/update-profile-image/",
        FileUploadRequest(
          files: images,
          uploadType: FileUploadType.profileImage,
          fileParam: "images",
        ),
      );

      printLn(response);
    } catch (e) {
      printLn(e.toString());
    }
  }
}
