
import 'package:contact_app/screens/detail_screen/detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/contact.dart';
import '../image_text/image_text.dart';


class ContactCard extends StatefulWidget {
  Contact contact;
  ContactCard({Key? key, required this.contact}) : super(key: key);
  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  late Contact contact;

  void refresh(Contact newContact){
    setState(() {
      contact = newContact;
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(contact: contact, notifyChangeData: refresh,))
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top:6, bottom: 6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 25,
            ),
            Text(
              contact.firstName[0],
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            ImageText(firstLetter: contact.firstName[0], url: contact.imageUrl),
            const SizedBox(
              width: 15,
            ),
             Text(
              '${contact.firstName} ${contact.lastName}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
