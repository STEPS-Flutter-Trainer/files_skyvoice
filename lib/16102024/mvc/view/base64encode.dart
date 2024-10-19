import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: FileDownloadScreen(),
  ));
}

class FileDownloadScreen extends StatefulWidget {
  @override
  _FileDownloadScreenState createState() => _FileDownloadScreenState();
}

class _FileDownloadScreenState extends State<FileDownloadScreen> {
  String jsonData = jsonEncode({
    "files": [
      {
        "file_name": "GG001108_15October2024_15h2m17s.txt",
        "serial_number": "GG001108",
        "date": "15October2024",
        "time": "15h2m17s"
      },
      {
        "file_name": "GG001108_15October2024_15h2m20s.txt",
        "serial_number": "GG001108",
        "date": "15October2024",
        "time": "15h2m20s"
      },
      {
        "file_name": "GG001108_15October2024_15h2m40s.txt",
        "serial_number": "GG001108",
        "date": "15October2024",
        "time": "15h2m40s"
      },
      {
        "file_name": "GG001108_15October2024_15h5m17s.txt",
        "serial_number": "GG001108",
        "date": "15October2024",
        "time": "15h5m17s"
      },
      {
        "file_name": "GG001108_15October2024_16h2m17s.txt",
        "serial_number": "GG001108",
        "date": "15October2024",
        "time": "16h2m17s"
      }
    ],
    "Type": "save_files"
  });

  String encodeJsonToBase64() {
    // Encode the JSON string to Base64
    return base64Encode(utf8.encode(jsonData));
  }

  Future<void> saveBase64ToFile() async {
    String base64EncodedJson = encodeJsonToBase64();
    final directory = await getExternalStorageDirectory(); // Use getExternalStorageDirectory for external storage
    final filePath = '${directory?.path}/encoded_json.txt';

    // Write the Base64 string to a file
    File file = File(filePath);
    await file.writeAsString(base64EncodedJson);

    // Show a snackbar with the saved file path
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('File saved to $filePath')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Download Base64 Encoded JSON')),
      body: Center(
        child: ElevatedButton(
          onPressed: saveBase64ToFile,
          child: Text('Download Base64 Encoded JSON'),
        ),
      ),
    );
  }
}
