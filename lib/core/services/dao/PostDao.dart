import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilitem2miage/core/models/client/Post.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';
import 'package:mobilitem2miage/core/services/dao/BaseDao.dart';

class PostDao extends BaseDao<Post> {

  PostDao() {
    super.collectionName = 'posts';
    super.firestore = FireStoreService(super.collectionName);
  }

  @override
  Future<void> add(Post data) async {

    print(data.toJson());
    return await super.firestore.addDocument(data.toJson());
  }

  @override
  Future<List<Post>> find(String condition, dynamic value) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(super.collectionName)
        .where(condition, isEqualTo: value)
        .get();

    return result.docs.map((doc) => Post.fromJson(doc.data())).toList();
  }

  @override
  Future<List<Post>> fetch() async {

    var result = await super.firestore.getDataCollection();
    return result.docs
        .map((doc) => Post.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<Post> getById(String id) async {

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(super.collectionName)
        .where("email", isEqualTo: id)
        .limit(1)
        .get();

    if (result == null || result.docs.isEmpty) {
      return null;
    } else {
      return Post.fromJson(result.docs[0].data());
    }
  }

  @override
  Future remove(String id) async {

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(super.collectionName)
        .where("id", isEqualTo: id)
        .limit(1)
        .get()
        .then((document) {
      document.docs.forEach((doc)=> {
        firestore.removeDocument(doc.reference.id)
      });
      return;
    });

    return;
    await firestore.removeDocument(id) ;
  }

  @override
  Future update(Post data, Map<String, dynamic> changes) async {

    final QuerySnapshot result = await FirebaseFirestore.instance
      .collection(super.collectionName)
      .where("idEtablishment", isEqualTo: data.idEtablishment)
      .limit(1)
      .get()
      .then((document) {
        document.docs.forEach((doc)=> {
          doc.reference.update(changes)
        });
        return;
      });

    return;
  }
}