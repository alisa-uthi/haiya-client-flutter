import 'dart:io';
import 'package:haiya_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class AvartarImage extends StatefulWidget {
  const AvartarImage({
    Key? key,
  }) : super(key: key);

  @override
  _AvartarImageState createState() => _AvartarImageState();
}

class _AvartarImageState extends State<AvartarImage> {
  File? _image;
  final picker = ImagePicker();
  UserService _userService = new UserService();

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future selectImage() async {
    final pickedPhoto = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedPhoto!.path.isNotEmpty) {
        _image = File(pickedPhoto.path);
      } else {
        print('No image selected.');
      }
    });

    saveImage();
  }

  Future saveImage() async {
    // Check for valid file
    if (_image == null) return;

    _userService.updateProfileImage(_image!.path);
  }

  Future loadImage() async {
    // setState(() {
    //   _userImg = prefs.getString("userImage");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectImage(),
      child: Center(
        child: CircleAvatar(
          backgroundColor: kBackgroundColor,
          foregroundImage:
              _image != null ? FileImage(File(_image!.path)) : null,
          radius: 50,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding / 1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.black,
              ),
            ),
            child: Icon(
              Icons.camera_alt,
              color: Colors.black,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
