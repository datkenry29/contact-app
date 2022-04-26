import 'package:contact_app/data/models/contact.dart';
import 'package:contact_app/screens/edit_screen/edit_screen.dart';
import 'package:flutter/material.dart';

import '../../core/utils/image_base64.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.contact, required this.notifyChangeData}) : super(key: key);
  final Contact contact;
  final Function notifyChangeData;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Contact contact;

  void refresh(Contact newContact) {
    setState(() {
      contact = newContact;
      widget.notifyChangeData(contact);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {


              },
              icon: const Icon(
                  Icons.star_border
              )
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditScreen(contact: contact, notifyChangeData: refresh,))
                );
              },
              icon: const Icon(
                  Icons.edit
              )
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                  Icons.more_vert
              )
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  left: 10,
                  bottom: 10,
                  child: Text(
                    '${contact.firstName} ${contact.lastName}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 3,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.local_phone,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.phone,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4,),
                        Text(
                          contact.typePhone,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: const SizedBox()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


