import 'package:flutter/material.dart';

/// Grey circle like the design. Shows the user's photo when the server has one.
class ProfileAvatar extends StatelessWidget {
  final String? image;
  final double size;

  const ProfileAvatar({super.key, this.image, required this.size});

  @override
  Widget build(BuildContext context) {
    // The server returns ".../storage" with no file name when there is no photo.
    final hasImage = image != null && !image!.endsWith('/storage');
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: const Color(0xFFD9D9D9),
      backgroundImage: hasImage ? NetworkImage(image!) : null,
    );
  }
}
