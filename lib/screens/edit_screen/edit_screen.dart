import 'dart:typed_data';

import 'package:contact_app/data/database/contact_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/image_base64.dart';
import '../../data/models/contact.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.contact, required this.notifyChangeData}) : super(key: key);

  List<String> typePhones = ["Mobile", "Home", "Company"];
  List<String> typeEmails = ["Personal", "Company"];
  final Function notifyChangeData;

  Contact contact;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  late Contact contact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contact = widget.contact;
    firstNameController.text = contact.firstName;
    lastNameController.text = contact.lastName;
    phoneController.text = contact.phone;
    emailController.text = contact.email;
  }

  @override
  void didUpdateWidget(covariant EditScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> onPressButtonCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      final Uint8List imageByte = await image.readAsBytes();
      final String imgString = ImageBase64.base64String(imageByte);
      setState(() {
        contact.imageUrl = imgString;
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
        title: const Text("Edit contact"),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              ContactRepo.updateContact(contact);
              widget.notifyChangeData(contact);
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
                child:  contact.imageUrl == ""
                    ? const Icon(
                  Icons.person,
                  size: 250,
                  color: Colors.white,
                )
                    : ImageBase64.imageFromBase64String(contact.imageUrl),
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
                    setState(() {
                      contact.firstName = value;
                    });
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
                    setState(() {
                      contact.lastName = value;
                    });
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
                    setState(() {
                      contact.phone = value;
                    });
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
                value: contact.typePhone,
                items: widget.typePhones.map((String type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    contact.typePhone = newValue!;
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
                    setState(() {
                      contact.email = value;
                    });
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
                value: contact.typeEmail,
                items: widget.typeEmails.map((String type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    contact.typeEmail = newValue!;
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
