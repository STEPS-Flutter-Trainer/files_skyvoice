import 'dart:io';
import 'package:flutter/cupertino.dart';
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
      debugShowCheckedModeBanner: false,
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
  int? uploadedFileIndex; // Track which file is uploaded

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

  void _uploadFile(String filePath, int index) {
    // Implement your file upload logic here
    // Show a SnackBar as a placeholder for the upload function
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Upload function not implemented for: $filePath")),
    );

    // Update the uploaded file index to change the button text
    setState(() {
      uploadedFileIndex = index; // Mark this file as uploaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the arrow is pressed
          },
        ),
        title: const Text("LogFiles", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF0C7C3C),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 30, color: Colors.white), // Set color for the refresh icon
            tooltip: 'Refresh List',
            onPressed: _loadFiles, // Refresh the file list when clicked
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: txtFiles.length,
        itemBuilder: (context, index) {
          final file = txtFiles[index];
          return SizedBox(
            height: 100,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 2,
              child: Center(
                child: ListTile(
                  title: Row( // Use Row to arrange file name and button horizontally
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between items
                    children: [
                      Expanded( // Allow the file name to take available space
                        child: Text(
                          file.name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 150, // Set a fixed width for the button
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: uploadedFileIndex == index
                                ? Color(0xFFF7572D) // Change to the specified orange color for "Re-upload"
                                : const Color(0xFF0C7C3C), // Green color for "Upload"
                          ),
                          onPressed: () => _uploadFile(file.path, index), // Pass the index
                          child: Text(
                            uploadedFileIndex == index ? "Sent to Holymicro" : "Send again", // Conditional text
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                ),
              ),
            ),
          );
        },
      ),


    );
  }
}

class TextFileViewer extends StatelessWidget {
  final String fileContent;

  const TextFileViewer({super.key, required this.fileContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Content"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(fileContent),
      ),
    );
  }
}
