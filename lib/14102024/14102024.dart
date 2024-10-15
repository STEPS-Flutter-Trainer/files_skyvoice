import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileListView extends StatefulWidget {
  const FileListView({super.key});

  @override
  _FileListViewState createState() => _FileListViewState();
}

class _FileListViewState extends State<FileListView> {
  List<String> filePaths = [];
  bool noFilesFound = false;

  @override
  void initState() {
    super.initState();
    _getFiles();
  }

  Future<void> _getFiles() async {
    try {
      final directory = await getExternalStorageDirectory();
      final downloadsDirectory = '/storage/emulated/0/Download';

      if (downloadsDirectory != null) {
        final fileList = Directory(downloadsDirectory).listSync();

        setState(() {
          filePaths = fileList
              .where((file) => file.path.endsWith('.txt'))
              .map((file) => file.path)
              .toList();
          noFilesFound = filePaths.isEmpty;
        });

        if (noFilesFound) {
          print('No .txt files found in Downloads.');
        } else {
          print('Found ${filePaths.length} .txt files.');
        }
      } else {
        // Handle the case where the Downloads directory is not available
        print('Downloads directory not found.');
        noFilesFound = true;
      }
    } catch (e) {
      // Handle errors, e.g., print a stack trace
      print('Error getting files: $e');
      noFilesFound = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: noFilesFound
          ? Center(
        child: Text('No .txt files found in Downloads.'),
      )
          : ListView.builder(
        itemCount: filePaths.length,
        itemBuilder: (context, index) {
          final filePath = filePaths[index];
          return ListTile(
            title: Text(filePath.split('/').last),
            onTap: () {
              // Handle file selection or opening
              print('File tapped: $filePath');
            },
          );
        },
      ),
    );
  }
}