import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';
import 'package:mobilitem2miage/ui/Locator.dart';

class BaseDao<T> extends ChangeNotifier {

  FireStoreService firestore;
  List<T> objects;
  T object;

  Future<List<T>> fetch() async {}

  Future<T> getById(String id) async {}

  Future remove(String id) async {}

  Future update(T data, String id) async {}

  Future add(T data) async {}

}