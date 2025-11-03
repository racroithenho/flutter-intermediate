import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/photo_grid.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _photos = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPhotos();
  }

  Future<void> _loadSavedPhotos() async {
    final dir = await getApplicationDocumentsDirectory();
    final galleryDir = Directory('${dir.path}/photos');
    if (await galleryDir.exists()) {
      final files = galleryDir.listSync();
      setState(() {
        _photos = files.map((e) => File(e.path)).toList();
      });
    }
  }

  Future<void> _takePhoto() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final picked = await _picker.pickImage(source: ImageSource.camera);
      if (picked != null) {
        final dir = await getApplicationDocumentsDirectory();
        final galleryDir = Directory('${dir.path}/photos');
        if (!(await galleryDir.exists())) {
          await galleryDir.create();
        }
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final savedFile = await File(picked.path)
            .copy('${galleryDir.path}/$fileName.jpg');

        setState(() {
          _photos.add(savedFile);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission denied")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📸 Photo Gallery"),
        centerTitle: true,
      ),
      body: _photos.isEmpty
          ? const Center(child: Text("No photos yet. Take one!"))
          : PhotoGrid(photos: _photos),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
