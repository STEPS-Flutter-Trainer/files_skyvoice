// main.dart

import 'dart:io';

import 'package:flutter/material.dart';

import '../controllers/txt_file_controller.dart';
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
      setState(() {
        txtFiles = files;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
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
          return ListTile(
            title: Text(file.name),
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
