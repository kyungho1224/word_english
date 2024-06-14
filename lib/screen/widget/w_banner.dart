import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  final double height;
  final String? imagePath;

  BannerWidget({Key? key, this.imagePath, required this.height})
      : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      color: Colors.blue,
      child: widget.imagePath != null && widget.imagePath!.isNotEmpty
          ? Image.network(
              widget.imagePath!,
              fit: BoxFit.cover,
            )
          : const Center(child: Text("Banner Image")),
    );
  }
}
