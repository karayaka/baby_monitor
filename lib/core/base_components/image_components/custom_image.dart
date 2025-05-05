import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomImage extends StatelessWidget {
  String? uri;
  CustomImage({super.key, this.uri});

  @override
  Widget build(BuildContext context) {
    if (uri == null || uri == "") {
      return Icon(
        Icons.people,
        color: Colors.white,
      );
    } else {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: uri ?? "",
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }
  }
}
