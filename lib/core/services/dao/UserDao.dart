import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';
import 'package:mobilitem2miage/core/services/dao/BaseDao.dart';

class UserDao extends BaseDao<User> {

  UserDao() {
    super.firestore = FireStoreService('users');
  }

  @override
  Future add(User data) async {

    var result = await super.firestore.addDocument(data.toJson());
    return;
  }

  @override
  Future<List<User>> fetch() async {

    var result = await super.firestore.getDataCollection();
    super.objects = result.docs
        .map((doc) => User.fromMap(doc.data(), doc.id))
        .toList();
    return super.objects;
  }

  @override
  Future<User> getById(String id) async {

    var doc = await super.firestore.getDocumentById(id);
    return User.fromMap(doc.data(), doc.id);
  }

  @override
  Future remove(String id) async {
    await firestore.removeDocument(id) ;
  }

  @override
  Future update(User data, String id) async {

    var result  = await firestore.updateDocument(data.toJson(), id) ;
    return;
  }
}