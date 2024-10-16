// main.dart

import 'dart:io';

import 'package:files_skyvoice/16102024/mvc/controllers/txt_file_controller_sqlflite.dart';
import 'package:flutter/material.dart';
import '../models/txt_file_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVC Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TxtFileListView(),
    );
  }
}

class TxtFileListView extends StatefulWidget {
  @override
  _TxtFileListViewState createState() => _TxtFileListViewState();
}

class _TxtFileListViewState extends State<TxtFileListView> {
  final TxtFileController _controller = TxtFileController();
  List<TxtFileModel> txtFiles = [];
  Map<String, bool> savedFiles = {};

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndLoadFiles();
  }

  Future<void> _checkPermissionsAndLoadFiles() async {
    if (Platform.isAndroid) {
      if (await _controller.requestStoragePermission()) {
        await _loadFiles();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permission denied to access storage")),
        );
      }
    }
  }

  Future<void> _loadFiles() async {
    try {
      final files = await _controller.loadTxtFiles();
      final Map<String, bool> tempSavedFiles = {};
      for (var file in files) {
        tempSavedFiles[file.path] = await _controller.isFileSaved(file.path);
      }
      setState(() {
        txtFiles = files;
        savedFiles = tempSavedFiles;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _saveFile(String path) async {
    await _controller.saveFilePath(path);
    setState(() {
      savedFiles[path] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Files List"),
      ),
      body: ListView.builder(
        itemCount: txtFiles.length,
        itemBuilder: (context, index) {
          final file = txtFiles[index];
          final isSaved = savedFiles[file.path] ?? false;
          return ListTile(
            title: Text(
              file.name,
              style: TextStyle(color: isSaved ? Colors.yellow : Colors.black),
            ),
            trailing: isSaved
                ? null
                : IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveFile(file.path),
              tooltip: 'Save File',
            ),
            onTap: () async {
              final content = await File(file.path).readAsString();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TextFileViewer(fileContent: content),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadFiles,
        child: Icon(Icons.refresh),
        tooltip: 'Refresh List',
      ),
    );
  }
}

class TextFileViewer extends StatelessWidget {
  final String fileContent;

  TextFileViewer({required this.fileContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Content"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(fileContent),
      ),
    );
  }
}
