import 'dart:io';
import 'package:flutter/material.dart';

class PhotoGrid extends StatelessWidget {
  final List<File> photos;

  const PhotoGrid({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showPhoto(context, photos[index]),
          child: Hero(
            tag: photos[index].path,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                photos[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPhoto(BuildContext context, File photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Hero(
              tag: photo.path,
              child: Image.file(photo),
            ),
          ),
        ),
      ),
    );
  }
}
