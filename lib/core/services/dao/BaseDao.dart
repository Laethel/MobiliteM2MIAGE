import 'package:flutter/cupertino.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';

class BaseDao<T> extends ChangeNotifier {

  String collectionName;
  FireStoreService firestore;

  Future<List<T>> fetch() async {}

  Future<T> getById(String id) async {}

  Future<List<T>> find(String condition, dynamic value) async {}

  Future remove(String id) async {}

  Future update(T data, Map<String, dynamic> changes) async {}

  Future add(T data) async {}

}