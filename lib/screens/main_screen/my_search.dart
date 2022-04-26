import 'package:contact_app/screens/main_screen/widgets/list_contact/list_contact.dart';
import 'package:flutter/material.dart';

class MySearch extends SearchDelegate {
  final GlobalKey<ListContactState> _listContactState = GlobalKey<ListContactState>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
      return ListContact(key: _listContactState, searchText: query,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
  
}