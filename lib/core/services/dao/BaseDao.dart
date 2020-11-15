import 'package:flutter/cupertino.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';

class BaseDao<T> extends ChangeNotifier {

  String collectionName;
  FireStoreService firestore;
  List<T> objects;
  T object;

  Future<List<T>> fetch() async {}

  Future<T> getById(String id) async {}

  /// TODO : Implémenter cette méthode
  Future<T> getByQuery(String id) async {}

  Future remove(String id) async {}

  Future update(T data, String id) async {}

  Future add(T data) async {}

}