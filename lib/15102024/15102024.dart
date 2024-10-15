// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_text_viewer/flutter_text_viewer.dart';
// import 'package:path_provider/path_provider.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'TextViewer Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   // Function to get all .txt files in the specified directory
//   Future<List<FileSystemEntity>> _getTxtFiles() async {
//     Directory directory;
//     if (Platform.isAndroid) {
//       directory = Directory('/storage/emulated/0/Download');
//     } else {
//       directory = await getApplicationDocumentsDirectory();
//     }
//
//     // List all files and filter only .txt files
//     List<FileSystemEntity> files = directory.listSync().where((file) {
//       return file.path.endsWith('.txt');
//     }).toList();
//
//     return files;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Text Files Viewer")),
//       body: FutureBuilder<List<FileSystemEntity>>(
//         future: _getTxtFiles(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Error loading files.'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No .txt files found.'));
//           }
//
//           // List all .txt files found
//           List<FileSystemEntity> txtFiles = snapshot.data!;
//           return ListView.builder(
//             itemCount: txtFiles.length,
//             itemBuilder: (context, index) {
//               String filePath = txtFiles[index].path;
//               String fileName = filePath.split('/').last;
//
//               return ListTile(
//                 title: Text(fileName),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return TextViewerPage(
//                         textViewer: TextViewer.file(
//                           filePath,
//                           highLightColor: Colors.yellow,
//                           focusColor: Colors.orange,
//                           ignoreCase: true,
//                           onErrorCallback: (error) {
//                             if (kDebugMode) {
//                               print("Error: $error");
//                             }
//                           },
//                         ),
//                         showSearchAppBar: true,
//                       );
//                     },
//                   ));
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_text_viewer/flutter_text_viewer.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'TextViewer Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   // Function to pick .txt files using FilePicker
//   Future<void> _pickTxtFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['txt'], // Only allow .txt files
//     );
//
//     if (result != null && result.files.single.path != null) {
//       String filePath = result.files.single.path!;
//       Navigator.push(context, MaterialPageRoute(
//         builder: (context) {
//           return TextViewerPage(
//             textViewer: TextViewer.file(
//               filePath,
//               highLightColor: Colors.yellow,
//               focusColor: Colors.orange,
//               ignoreCase: true,
//               onErrorCallback: (error) {
//                 print("Error: $error");
//               },
//             ),
//             showSearchAppBar: true,
//           );
//         },
//       ));
//     } else {
//       print('File not selected');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Text Files Viewer")),
//       body: Center(
//         child: ElevatedButton(
//           child: const Text('Select .txt file'),
//           onPressed: _pickTxtFiles,
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF and TXT Picker Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _filePath;

  Future<void> _pickFile() async {
    // Allow user to pick .pdf and .txt files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt'], // Specify the allowed file types
    );

    if (result != null) {
      // Get the file path
      String filePath = result.files.single.path!;
      setState(() {
        _filePath = filePath;
      });
    } else {
      // User canceled the picker
      setState(() {
        _filePath = 'File not selected';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick PDF or TXT File')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Select .pdf or .txt File'),
            ),
            const SizedBox(height: 20),
            if (_filePath != null) Text('Selected File: $_filePath'),
          ],
        ),
      ),
    );
  }
}

//
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_text_viewer/flutter_text_viewer.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'TextViewer Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // Function to pick .txt files using FilePicker
//   Future<void> _pickTxtFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['txt'],  // Only allow .txt files
//     );
//
//     if (result != null && result.files.single.path != null) {
//       String filePath = result.files.single.path!; // Get the file path
//       Navigator.push(context, MaterialPageRoute(
//         builder: (context) {
//           return TextViewerPage(
//             textViewer: TextViewer.file(
//               filePath,
//               highLightColor: Colors.yellow,
//               focusColor: Colors.orange,
//               ignoreCase: true,
//               onErrorCallback: (error) {
//                 if (kDebugMode) {
//                   print("Error: $error");
//                 }
//               },
//             ),
//             showSearchAppBar: true,
//           );
//         },
//       ));
//     } else {
//       if (kDebugMode) {
//         print("No file selected or file doesn't exist.");
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No file selected')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pick Text Files")),
//       body: Center(
//         child: ElevatedButton(
//           child: const Text('Pick .txt file'),
//           onPressed: _pickTxtFiles,
//         ),
//       ),
//     );
//   }
// }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'File Listing Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<FileSystemEntity> _files = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _requestPermissionsAndGetFiles();
//   }
//
//   Future<void> _requestPermissionsAndGetFiles() async {
//     // Request manage external storage permission for Android 10+ devices
//     if (await Permission.manageExternalStorage.request().isGranted) {
//       _getFilesFromDownload();
//     } else {
//       // Show an error message if permission is denied
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Permission denied to access files')),
//       );
//     }
//   }
//
//   // Function to list .txt and .pdf files from Download folder
//   void _getFilesFromDownload() {
//     Directory downloadDirectory = Directory('/storage/emulated/0/Download');
//     List<FileSystemEntity> files = downloadDirectory.listSync().where((file) {
//       return file.path.endsWith('.txt') || file.path.endsWith('.pdf');
//     }).toList();
//
//     setState(() {
//       _files = files;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Files in Download Folder")),
//       body: _files.isNotEmpty
//           ? ListView.builder(
//         itemCount: _files.length,
//         itemBuilder: (context, index) {
//           String filePath = _files[index].path;
//           String fileName = filePath.split('/').last;
//           return ListTile(
//             title: Text(fileName),
//             onTap: () {
//               // Handle file opening here
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Selected: $fileName')),
//               );
//             },
//           );
//         },
//       )
//           : const Center(child: Text('No .txt or .pdf files found')),
//     );
//   }
// }
