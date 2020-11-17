import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';
import 'package:mobilitem2miage/core/services/dao/BaseDao.dart';

class UserDao extends BaseDao<User> {

  UserDao() {
    super.collectionName = 'users';
    super.firestore = FireStoreService(super.collectionName);
  }

  @override
  Future<void> add(User data) async {

    var result = await super.firestore.addDocument(data.toJson());
    return;
  }

  @override
  Future<List<User>> fetch() async {

    var result = await super.firestore.getDataCollection();
    super.objects = result.docs
        .map((doc) => User.fromJson(doc.data()))
        .toList();
    return super.objects;
  }

  @override
  Future<User> getById(String id) async {

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(super.collectionName)
        .where("email", isEqualTo: id)
        .limit(1)
        .get();

    if (result == null || result.docs.isEmpty) {
      return null;
    } else {
      return User.fromJson(result.docs[0].data());
    }
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