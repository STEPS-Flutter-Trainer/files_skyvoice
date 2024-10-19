import 'dart:convert';
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
  String? encodedContent; // Variable to store the encoded content
  String? decodedContent; // Variable to store the decoded content
  int? encodedFileIndex; // Track which file is encoded

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

  void _encodeFile(String filePath, int index) async {
    try {
      final file = File(filePath);

      // Use file.readAsBytes() to read the file as bytes
      final bytes = await file.readAsBytes();

      // Encode the bytes to Base64
      setState(() {
        encodedContent = base64Encode(bytes);
        encodedFileIndex = index; // Mark this file as encoded
     print(encodedContent);
      });

      // After encoding, navigate to a new page to display the encoded content
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EncodedFileViewer(encodedContent: encodedContent!),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error reading file: $e")),
      );
    }
  }


  void _decodeFile() {
    if (encodedContent != null) {
      // Decode the Base64 string back to the original content
      setState(() {
        decodedContent = utf8.decode(base64Decode(encodedContent!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("LogFiles", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0C7C3C),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 30, color: Colors.white),
            tooltip: 'Refresh List',
            onPressed: _loadFiles,
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          file.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: encodedFileIndex == index
                                    ? const Color(0xFFF7572D)
                                    : const Color(0xFF0C7C3C),
                              ),
                              onPressed: () => _encodeFile(file.path, index),
                              child: Text(
                                encodedFileIndex == index ? "Encoded" : "Encode",
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (encodedFileIndex == index)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  _decodeFile();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DecodedFileViewer(
                                        decodedContent: decodedContent ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Decode",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
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
        backgroundColor: const Color(0xFF0C7C3C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            fileContent,
            style: const TextStyle(fontSize: 16, fontFamily: "Roboto"),
          ),
        ),
      ),
    );
  }
}

class DecodedFileViewer extends StatelessWidget {
  final String decodedContent;

  const DecodedFileViewer({super.key, required this.decodedContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decoded Content"),
        backgroundColor: const Color(0xFF0C7C3C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            decodedContent,
            style: const TextStyle(fontSize: 16, fontFamily: "Roboto"),
          ),
        ),
      ),
    );
  }
}
class EncodedFileViewer extends StatelessWidget {
  final String encodedContent;

  const EncodedFileViewer({super.key, required this.encodedContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encoded File Content"),
        backgroundColor: const Color(0xFF0C7C3C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            encodedContent,
            style: const TextStyle(fontSize: 16, fontFamily: "Roboto"),
          ),
        ),
      ),
    );
  }
}
