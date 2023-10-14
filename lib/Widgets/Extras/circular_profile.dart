import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularProfile extends StatelessWidget {
  final String imageURL;
  final double imageHeight;
  final bool? roundBorder;
  const CircularProfile({super.key, required this.imageURL, required this.imageHeight, this.roundBorder});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: imageHeight,
      height: imageHeight,
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: roundBorder == true ? Border.all(color: Colors.white,width: 2) : null,
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
      errorWidget: (context, url, error) =>
       Icon(Icons.account_circle, size: imageHeight,),
    );
  }
}
