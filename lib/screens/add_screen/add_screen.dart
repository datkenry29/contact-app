import 'dart:typed_data';

import 'package:contact_app/core/utils/image_base64.dart';
import 'package:contact_app/data/database/contact_repo.dart';
import 'package:contact_app/data/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key? key, required this.notifyChangeData}) : super(key: key);

  List<String> typePhones = ["Mobile", "Home", "Company"];
  List<String> typeEmails = ["Personal", "Company"];

  final Function notifyChangeData;
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  late String typePhone;
  late String typeEmail;
  late String imageUrl;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typePhone = widget.typePhones[0];
    typeEmail = widget.typeEmails[0];
    imageUrl = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  void addContact(){
    ContactRepo.insertContact([Contact(imageUrl: imageUrl, firstName: firstNameController.text, lastName: lastNameController.text, phone: phoneController.text, typePhone: typePhone, email: emailController.text, typeEmail: typeEmail)]);
  }

  Future<void> onPressButtonCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      final Uint8List imageByte = await image.readAsBytes();
      final String imgString = ImageBase64.base64String(imageByte);
      setState(() {
        imageUrl = imgString;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
        title: const Text("Create new contact"),
        actions: [
          FlatButton(
              textColor: Colors.white,
              onPressed: () {
                addContact();
                widget.notifyChangeData();
                Navigator.pop(context);
              },
              child: const Text("SAVE"),
              shape: const CircleBorder(side: BorderSide(color: Colors.transparent))
          ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250,
                color: Colors.blue,
                child:  imageUrl == ""
                    ? const Icon(
                        Icons.person,
                        size: 250,
                        color: Colors.white,
                      )
                    : ImageBase64.imageFromBase64String(imageUrl),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: onPressButtonCamera,
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ),
            ],
          ),
          Row(
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Saving to",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    "Device",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16,),
              SizedBox(
                width: 280,
                child: TextField(
                  onChanged: (value) {
                  },
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 64,),
              SizedBox(
                width: 280,
                child: TextField(
                  onChanged: (value) {
                  },
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Last name',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.local_phone,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16,),
              SizedBox(
                width: 280,
                child: TextField(
                  onChanged: (value) {
                  },
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 64,),
              DropdownButton(
                value: typePhone,
                items: widget.typePhones.map((String type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    typePhone = newValue!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16,),
              SizedBox(
                width: 280,
                child: TextField(
                  onChanged: (value) {
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 64,),
              DropdownButton(
                value: typeEmail,
                items: widget.typeEmails.map((String type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    typeEmail = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
