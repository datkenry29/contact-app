import 'package:contact_app/core/utils/image_base64.dart';
import 'package:flutter/material.dart';

class ImageText extends StatefulWidget {
  ImageText({Key? key, required this.firstLetter,required this.url}) : super(key: key);

  String firstLetter;
  String url;

  @override
  State<ImageText> createState() => _ImageTextState();
}

class _ImageTextState extends State<ImageText> {
  String url = '';
  late String firstText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstText = widget.firstLetter;
    if(widget.url != "") {
      url = widget.url;
      firstText = "";
    }
  }

  @override
  void didUpdateWidget(covariant ImageText oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.url != oldWidget.url) {
      if(widget.url != "") {
        setState(() {
          url = widget.url;
          firstText = "";
        });
      } else {
        setState(() {
          url = '';
          firstText = widget.firstLetter;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: url == ""
                  ? Image.asset('assets/images/blue0517.jpg', fit: BoxFit.fill,)
                  : ImageBase64.imageFromBase64String(url),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              firstText,
              style: const TextStyle(
                fontSize: 27,
                color: Colors.white70,
              ),
            ),
          ),
        )
      ],
    );
  }
}


