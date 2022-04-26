import 'package:contact_app/data/database/contact_repo.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/contact.dart';
import '../contact_card/contact_card.dart';


class ListContact extends StatefulWidget {
  ListContact({Key? key, required this.searchText}) : super(key: key);
  final String searchText;
  @override
  State<ListContact> createState() => ListContactState();
}

class ListContactState extends State<ListContact> {
  late Future<List<Contact>> listContact;
  late String searchText = widget.searchText;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listContact = ContactRepo.getListContact();
  }

  void refreshListContact() {
    setState(() {
      listContact = ContactRepo.getListContact();
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: listContact,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          List<Contact> tempList = snapshot.data!.where((contact) => (contact.firstName + " " + contact.lastName).contains(searchText.toLowerCase())).toList();
          return ListView.builder(
            itemCount: tempList.length,
            itemBuilder: (context, index) {
              return  ContactCard(contact: tempList[index]);
            }
          );
        } else if(snapshot.hasError){
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}