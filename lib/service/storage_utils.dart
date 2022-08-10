import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageUtils {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPicByUrl(
      String id, String photoUrl, String directory) async {
    String uploadedPhotoUrl = '';
    Reference reference = _storage.ref(directory).child(id);
    Uint8List? bytes = await _loadNetworkImage(photoUrl);
    if (bytes == null) return '';
    await reference
        .putData(
            bytes,
            SettableMetadata(contentType: 'image/jpeg', customMetadata: {
              'id': id,
            }))
        .whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        uploadedPhotoUrl = value;
      });
    });
    return uploadedPhotoUrl;
  }

  Future<Uint8List?> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<String> uploadPicByFile(
      String id, PickedFile pickedFile, String directory) async {
    String uploadedPhotoUrl = '';
    Reference reference = _storage.ref(directory).child(id);
    if (kIsWeb) {
      await reference
          .putData(
              await pickedFile.readAsBytes(),
              SettableMetadata(contentType: 'image/jpeg', customMetadata: {
                'id': id,
              }))
          .whenComplete(() async {
        await reference.getDownloadURL().then((value) {
          uploadedPhotoUrl = value;
        });
      });
    } else {
      await reference
          .putFile(
              File(pickedFile.path),
              SettableMetadata(contentType: 'image/jpeg', customMetadata: {
                'id': id,
              }))
          .whenComplete(() async {
        await reference.getDownloadURL().then((value) {
          uploadedPhotoUrl = value;
        });
      });
    }
    return uploadedPhotoUrl;
  }
}
