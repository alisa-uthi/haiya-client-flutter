import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:haiya_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
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

  Future selectImage() async {
    final pickedPhoto = await picker.pickImage(source: ImageSource.camera);

    if (pickedPhoto != null) {
      setState(() {
        if (pickedPhoto.path.isNotEmpty) {
          _image = File(pickedPhoto.path);
        } else {
          CustomSnackBar.buildSnackbar(
            context,
            'No image selected.',
          );
        }
      });

      saveImage();
    }
  }

  Future saveImage() async {
    // Check for valid file
    if (_image == null) {
      CustomSnackBar.buildSnackbar(
        context,
        'Invalid file. Please select another image.',
      );
    }

    // Upload image to the server
    bool isUploaded = await _userService.updateProfileImage(_image!);
    if (!isUploaded) {
      CustomSnackBar.buildSnackbar(
        context,
        'Image size is too large.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isViewOnly ? () {} : () => selectImage(),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50,
        child: _image != null
            ? _buildSelectedImage()
            : currentUser.image != ''
                ? _buildNetworkImage()
                : _buildNoProfileImage(),
      ),
    );
  }

  Widget _buildNetworkImage() {
    return ClipOval(
      child: CachedNetworkImage(
        width: 70,
        height: 70,
        imageUrl: currentUser.image,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget _buildSelectedImage() {
    return ClipOval(
      child: Image.file(
        _image!,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildNoProfileImage() {
    return Container(
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
    );
  }
}
