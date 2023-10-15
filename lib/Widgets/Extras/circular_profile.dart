import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CircularProfile extends StatefulWidget {
  final double imageHeight;
  final bool? roundBorder;
  final bool? updatePhoto;
  const CircularProfile(
      {super.key,
      required this.imageHeight,
      this.roundBorder,
      this.updatePhoto});

  @override
  State<CircularProfile> createState() => _CircularProfileState();
}

class _CircularProfileState extends State<CircularProfile> {
  XFile? _pickedFile;
  late File displayImage;

  Future<void> _getPickedImage(context, authUser) async {
    final darkTheme =
        Theme.of(context).brightness.name == 'dark' ? true : false;
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }

    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        compressQuality: 15,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'SET DISPlAY IMAGE',
              toolbarColor: darkTheme ? Colors.black : Colors.teal[600],
              statusBarColor: darkTheme ? Colors.black : Colors.teal[600],
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'SET DISPlAY IMAGE',
          ),
        ],
      );
      if (croppedFile != null) {
        debugPrint('cropped image => ${croppedFile.path}');
        try {
          await updateProfilePhoto(File(croppedFile.path));
          Get.snackbar('DISPLAY PHOTO', 'Your photo has been updated.',
              backgroundColor: Colors.teal.shade600.withOpacity(0.6),
              maxWidth: 300);
        } catch (error) {
          Get.snackbar('ERROR @ SET PHOTO', '$error',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color.fromRGBO(255, 69, 0, 0.4),
              maxWidth: 300);
        }
        finally{
          User? authUser = FirebaseAuth.instance.currentUser!;
          await authUser.reload();
          final currentUser = FirebaseAuth.instance.currentUser!;
          GetStorage().write('userPhotoURL', currentUser.photoURL);
        }
      }
    }
  }

  updateProfilePhoto(image) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final storageRef =
        FirebaseStorage.instance.ref('displayPhoto/${currentUser.uid}');
    final uploadTask = storageRef.putFile(image);

    await uploadTask.whenComplete(() async {
      final downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      if (downloadUrl.isNotEmpty) {
        currentUser.updatePhotoURL(downloadUrl);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set({
          'photoURL': downloadUrl,
        }, SetOptions(merge: true));
      }
    });

    // final downloadUrl = await storageRef.getDownloadURL();
  }


  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    User? authUser = FirebaseAuth.instance.currentUser!;
    return Stack(
      children: [
        CachedNetworkImage(
          width: widget.imageHeight,
          height: widget.imageHeight,
          imageUrl: GetStorage().read('userPhotoURL'),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: widget.roundBorder == true
                  ? Border.all(color: Colors.white, width: 2)
                  : null,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                // colorFilter: const ColorFilter.mode(
                //     Colors.red, BlendMode.colorBurn)
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, imageData) =>
              CircularProgressIndicator(
            value: imageData.progress,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.account_circle,
            size: widget.imageHeight,
          ),
        ),
        if (widget.updatePhoto == true)
          Positioned(
              right: 10,
              top: 5,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                height: 28,
                width: 28,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () => _getPickedImage(context, authUser),
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 20,
                      color: Colors.teal[600],
                    )),
              )),
      ],
    );
  }
}
