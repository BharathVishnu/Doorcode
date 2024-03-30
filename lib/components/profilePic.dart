import 'dart:io'; // Add this import statement

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureInput extends StatefulWidget {
  final double size;
  final String imageUrl;

  const ProfilePictureInput({
    Key? key,
    required this.size,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ProfilePictureInputState createState() => _ProfilePictureInputState();
}

class _ProfilePictureInputState extends State<ProfilePictureInput> {
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl;
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectImage,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          image: _imageUrl.isNotEmpty
              ? DecorationImage(
                  image: FileImage(
                    File(_imageUrl),
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _imageUrl.isEmpty
            ? Icon(
                Icons.person,
                size: widget.size * 0.6,
                color: Colors.grey[600],
              )
            : null,
      ),
    );
  }
}
