// controllers/txt_file_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/txt_file_model.dart';

class TxtFileController {
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid && Platform.version.contains('Android 11') || Platform.version.contains('API 30')) {
      return await Permission.manageExternalStorage.request().isGranted;
    } else {
      return await Permission.storage.request().isGranted;
    }
  }

  Future<List<TxtFileModel>> loadTxtFiles() async {
    final downloadDir = Directory('/storage/emulated/0/Download');

    if (await downloadDir.exists()) {
      final files = downloadDir.listSync();
      return files
          .where((file) => file.path.endsWith('.txt'))
          .map((file) => TxtFileModel(name: file.path.split('/').last, path: file.path))
          .toList();
    } else {
      throw Exception("Downloads directory not found");
    }
  }
}
