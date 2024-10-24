import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NetworkImageRounded extends StatelessWidget {
  final String imagePath;
  final double size;

  const NetworkImageRounded(
      {super.key, required this.imagePath, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              imagePath,
            ),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.all(
          Radius.circular(size),
        ),
      ),
    );
  }
}

class RoundedImageFile extends StatelessWidget {
  final PlatformFile image;
  final double size;

  const RoundedImageFile({super.key, required this.image, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image.path!),
          fit: BoxFit.contain,
        ),
                borderRadius: BorderRadius.all(
          Radius.circular(size),
        ),
      ),
    );
  }
}
