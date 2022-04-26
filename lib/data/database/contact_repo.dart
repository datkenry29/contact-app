import 'dart:ffi';

import 'package:contact_app/data/database/database_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

class ContactRepo {

  static Future<List<Contact>> insertContact(List<Contact> contacts) async {
    final Database db = await DatabaseHandler.initializeDB();
    for (var contact in contacts) {
      await db.insert('contact', contact.toMap());
    }
    return await getListContact();
  }

  static Future<List<Contact>> getListContact() async {
    final Database db = await DatabaseHandler.initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('contact');
    return queryResult.map((e) => Contact.fromMap(e)).toList();
  }

  static Future<void> updateContact(Contact contact) async {
    final db = await DatabaseHandler.initializeDB();
    await db.update(
      'contact',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id]
    );
  }

  static Future<void> deleteContact(int id) async {
    final db = await DatabaseHandler.initializeDB();
    await db.delete(
      'contact',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<Contact>> initContact() async {
    Contact firstContact = Contact(imageUrl: "assets/images/qh.jpg", firstName: "Vu", lastName: "Tran", phone: "0935574137", typePhone: "Mobile", email: "a@gmail.com", typeEmail: "Personal");
    Contact secondContact = Contact(imageUrl: "assets/images/qh.jpg", firstName: "B", lastName: "Pham", phone: "0935574137", typePhone: "Company", email: "a@gmail.com", typeEmail: "Company");
    List<Contact> listContact = [firstContact, secondContact];
    await insertContact(listContact);
    return await getListContact();
  }
}