// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: TxtFileListView(),
//     );
//   }
// }
//
// class TxtFileListView extends StatefulWidget {
//   @override
//   _TxtFileListViewState createState() => _TxtFileListViewState();
// }
//
// class _TxtFileListViewState extends State<TxtFileListView> {
//   List<FileSystemEntity> txtFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionAndLoadFiles();
//   }
//
//   Future<void> _checkPermissionAndLoadFiles() async {
//     if (await Permission.storage.request().isGranted) {
//       _loadTxtFiles();
//     } else {
//       // Handle permission denied scenario
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Permission denied to access storage")),
//       );
//     }
//   }
//
//   Future<void> _loadTxtFiles() async {
//     final directory = Directory('/storage/emulated/0/Download');
//     final List<FileSystemEntity> files = directory.listSync();
//
//     setState(() {
//       txtFiles = files.where((file) => file.path.endsWith('.txt')).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Text Files List"),
//       ),
//       body: ListView.builder(
//         itemCount: txtFiles.length,
//         itemBuilder: (context, index) {
//           final file = txtFiles[index];
//           return ListTile(
//             title: Text(file.path.split('/').last),
//             onTap: () async {
//               final content = await File(file.path).readAsString();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TextFileViewer(fileContent: content),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class TextFileViewer extends StatelessWidget {
//   final String fileContent;
//
//   TextFileViewer({required this.fileContent});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Content"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(fileContent),
//       ),
//     );
//   }
// }

//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: TxtFileListView(),
//     );
//   }
// }
//
// class TxtFileListView extends StatefulWidget {
//   @override
//   _TxtFileListViewState createState() => _TxtFileListViewState();
// }
//
// class _TxtFileListViewState extends State<TxtFileListView> {
//   List<String> txtFilePaths = [];
//
//   Future<void> _pickTxtFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['txt'],
//       allowMultiple: true,
//     );
//
//     if (result != null) {
//       setState(() {
//         txtFilePaths = result.paths.whereType<String>().toList();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Text Files List"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.folder_open),
//             onPressed: _pickTxtFiles,
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: txtFilePaths.length,
//         itemBuilder: (context, index) {
//           final filePath = txtFilePaths[index];
//           return ListTile(
//             title: Text(filePath.split('/').last),
//             onTap: () async {
//               final content = await File(filePath).readAsString();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TextFileViewer(fileContent: content),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class TextFileViewer extends StatelessWidget {
//   final String fileContent;
//
//   TextFileViewer({required this.fileContent});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Content"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(fileContent),
//       ),
//     );
//   }
// }

//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: TxtFileListView(),
//     );
//   }
// }
//
// class TxtFileListView extends StatefulWidget {
//   @override
//   _TxtFileListViewState createState() => _TxtFileListViewState();
// }
//
// class _TxtFileListViewState extends State<TxtFileListView> {
//   List<String> txtFilePaths = [];
//
//   Future<void> _pickTxtFiles() async {
//     // Open file picker specifically for .txt files
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['txt'],
//       allowMultiple: true,
//     );
//
//     // Check if the user selected files
//     if (result != null) {
//       setState(() {
//         txtFilePaths = result.paths.whereType<String>().toList();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Text Files List"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.folder_open),
//             onPressed: _pickTxtFiles,
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: txtFilePaths.length,
//         itemBuilder: (context, index) {
//           final filePath = txtFilePaths[index];
//           return ListTile(
//             title: Text(filePath.split('/').last),
//             onTap: () async {
//               final content = await File(filePath).readAsString();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TextFileViewer(fileContent: content),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class TextFileViewer extends StatelessWidget {
//   final String fileContent;
//
//   TextFileViewer({required this.fileContent});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Content"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(fileContent),
//       ),
//     );
//   }
// }
//Worked in Freddys phn
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: TxtFileListView(),
//     );
//   }
// }
//
// class TxtFileListView extends StatefulWidget {
//   @override
//   _TxtFileListViewState createState() => _TxtFileListViewState();
// }
//
// class _TxtFileListViewState extends State<TxtFileListView> {
//   List<FileSystemEntity> txtFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionsAndLoadFiles();
//   }
//
//   Future<void> _checkPermissionsAndLoadFiles() async {
//     // Check and request for MANAGE_EXTERNAL_STORAGE permission
//     if (await Permission.manageExternalStorage.request().isGranted) {
//       _loadTxtFiles();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Permission denied to access storage")),
//       );
//     }
//   }
//
//   Future<void> _loadTxtFiles() async {
//     final downloadDir = Directory('/storage/emulated/0/Download');
//
//     if (await downloadDir.exists()) {
//       final files = downloadDir.listSync();
//       setState(() {
//         txtFiles = files.where((file) => file.path.endsWith('.txt')).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Downloads directory not found")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Text Files List"),
//       ),
//       body: ListView.builder(
//         itemCount: txtFiles.length,
//         itemBuilder: (context, index) {
//           final file = txtFiles[index];
//           return ListTile(
//             title: Text(file.path.split('/').last),
//             onTap: () async {
//               final content = await File(file.path).readAsString();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TextFileViewer(fileContent: content),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class TextFileViewer extends StatelessWidget {
//   final String fileContent;
//
//   TextFileViewer({required this.fileContent});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Content"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(fileContent),
//       ),
//     );
//   }
// }
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
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: TxtFileListView(),
//     );
//   }
// }
//
// class TxtFileListView extends StatefulWidget {
//   @override
//   _TxtFileListViewState createState() => _TxtFileListViewState();
// }
//
// class _TxtFileListViewState extends State<TxtFileListView> {
//   List<FileSystemEntity> txtFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionsAndLoadFiles();
//   }
//
//   Future<void> _checkPermissionsAndLoadFiles() async {
//     // Check the Android version
//     if (Platform.isAndroid) {
//       if (await _requestStoragePermission()) {
//         _loadTxtFiles();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Permission denied to access storage")),
//         );
//       }
//     }
//   }
//
//   Future<bool> _requestStoragePermission() async {
//     if (Platform.isAndroid && (await _androidVersion()) >= 30) {
//       // Request MANAGE_EXTERNAL_STORAGE for Android 11+ (API 30+)
//       return await Permission.manageExternalStorage.request().isGranted;
//     } else {
//       // Request READ_EXTERNAL_STORAGE for Android 9 and below
//       return await Permission.storage.request().isGranted;
//     }
//   }
//
//   Future<int> _androidVersion() async {
//     return int.parse((await File('/proc/version').readAsString()).split(" ")[2]);
//   }
//
//   Future<void> _loadTxtFiles() async {
//     final downloadDir = Directory('/storage/emulated/0/Download');
//
//     if (await downloadDir.exists()) {
//       final files = downloadDir.listSync();
//       setState(() {
//         txtFiles = files.where((file) => file.path.endsWith('.txt')).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Downloads directory not found")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Text Files List"),
//       ),
//       body: ListView.builder(
//         itemCount: txtFiles.length,
//         itemBuilder: (context, index) {
//           final file = txtFiles[index];
//           return ListTile(
//             title: Text(file.path.split('/').last),
//             onTap: () async {
//               final content = await File(file.path).readAsString();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TextFileViewer(fileContent: content),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class TextFileViewer extends StatelessWidget {
//   final String fileContent;
//
//   TextFileViewer({required this.fileContent});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Content"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(fileContent),
//       ),
//     );
//   }
// }

//works in both 9 & 12
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: TxtFileListView(),
//     );
//   }
// }
//
// class TxtFileListView extends StatefulWidget {
//   @override
//   _TxtFileListViewState createState() => _TxtFileListViewState();
// }
//
// class _TxtFileListViewState extends State<TxtFileListView> {
//   List<FileSystemEntity> txtFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionsAndLoadFiles();
//   }
//
//   Future<void> _checkPermissionsAndLoadFiles() async {
//     if (Platform.isAndroid) {
//       if (await _requestStoragePermission()) {
//         _loadTxtFiles();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Permission denied to access storage")),
//         );
//       }
//     }
//   }
//
//   Future<bool> _requestStoragePermission() async {
//     // For Android 11+ (API level 30 and above), request MANAGE_EXTERNAL_STORAGE
//     if (Platform.isAndroid && Platform.version.contains('Android 11') || Platform.version.contains('API 30')) {
//       return await Permission.manageExternalStorage.request().isGranted;
//     } else {
//       // For Android 9 and below, request READ_EXTERNAL_STORAGE
//       return await Permission.storage.request().isGranted;
//     }
//   }
//
//   Future<void> _loadTxtFiles() async {
//     final downloadDir = Directory('/storage/emulated/0/Download');
//
//     if (await downloadDir.exists()) {
//       final files = downloadDir.listSync();
//       setState(() {
//         txtFiles = files.where((file) => file.path.endsWith('.txt')).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Downloads directory not found")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Text Files List"),
//       ),
//       body: ListView.builder(
//         itemCount: txtFiles.length,
//         itemBuilder: (context, index) {
//           final file = txtFiles[index];
//           return ListTile(
//             title: Text(file.path.split('/').last),
//             onTap: () async {
//               final content = await File(file.path).readAsString();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TextFileViewer(fileContent: content),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class TextFileViewer extends StatelessWidget {
//   final String fileContent;
//
//   TextFileViewer({required this.fileContent});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Content"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(fileContent),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  List<FileSystemEntity> txtFiles = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndLoadFiles();
  }

  Future<void> _checkPermissionsAndLoadFiles() async {
    if (Platform.isAndroid) {
      if (await _requestStoragePermission()) {
        _loadTxtFiles();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permission denied to access storage")),
        );
      }
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid && Platform.version.contains('Android 11') || Platform.version.contains('API 30')) {
      return await Permission.manageExternalStorage.request().isGranted;
    } else {
      return await Permission.storage.request().isGranted;
    }
  }

  Future<void> _loadTxtFiles() async {
    final downloadDir = Directory('/storage/emulated/0/Download');

    if (await downloadDir.exists()) {
      final files = downloadDir.listSync();
      setState(() {
        txtFiles = files.where((file) => file.path.endsWith('.txt')).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloads directory not found")),
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
            title: Text(file.path.split('/').last),
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
        onPressed: _loadTxtFiles,
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
