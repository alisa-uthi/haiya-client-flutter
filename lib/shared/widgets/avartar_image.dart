import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:haiya_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class AvartarImage extends StatefulWidget {
  const AvartarImage({
    Key? key,
    required this.isViewOnly,
  }) : super(key: key);

  final bool isViewOnly;

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
      onTap: widget.isViewOnly ? () {} : () => selectImage(),
      child: CircleAvatar(
        backgroundColor: kBackgroundColor,
        // foregroundImage:
        //     _image != null ? FileImage(File(_image!.path)) : null,
        radius: 50,
        child: currentUser.image != null
            ? ClipOval(
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  imageUrl: currentUser.image!,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(right: kDefaultPadding / 1.5),
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
    );
  }
}
