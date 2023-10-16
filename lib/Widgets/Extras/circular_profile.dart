import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mess_manager/Widgets/Extras/get_snackbar.dart';
import 'package:shimmer/shimmer.dart';

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
        try {
          await updateProfilePhoto(File(croppedFile.path));
          GetSnackbar().success('SET PHOTO', 'Your photo has been updated.');
        } catch (error) {
          GetSnackbar().error('SET PHOTO', error);

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

    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    User? authUser = FirebaseAuth.instance.currentUser!;
    final Stream<DocumentSnapshot> userStream = FirebaseFirestore.instance
        .collection('users').doc(authUser.uid).snapshots();
    return Stack(
      children: [
        StreamBuilder<DocumentSnapshot>(stream: userStream,
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if (snapshot.hasData) {
                final userData = snapshot.data!;
                return CachedNetworkImage(
                  width: widget.imageHeight,
                  height: widget.imageHeight,
                  imageUrl: userData['photoURL'],
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
                );
              }

              return Center(
                child: Shimmer.fromColors
                  (baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade100, child: Container(
                  height: widget.imageHeight,
                  width: widget.imageHeight,
                  decoration: BoxDecoration(
                      color:  Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle
                  ),
                )),
              );


            }),
        if (widget.updatePhoto == true)
          Positioned(
              right: 10,
              top: 5,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: darkTheme ? Colors.black54 : Colors.white54),
                child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () => _getPickedImage(context, authUser),
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 20,
                    )),
              )),
      ],
    );
  }
}
