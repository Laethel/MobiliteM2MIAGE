import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilitem2miage/core/models/client/PointOfInterest.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';
import 'package:mobilitem2miage/core/services/dao/BaseDao.dart';

class PointOfInterestDao extends BaseDao<PointOfInterest> {

  PointOfInterestDao() {
    super.collectionName = 'pointsOfInterest';
    super.firestore = FireStoreService(super.collectionName);
  }

  @override
  Future<void> add(PointOfInterest data) async {

    var result = await super.firestore.addDocument(data.toJson());
    return;
  }

  @override
  Future<List<PointOfInterest>> fetch() async {

    var result = await super.firestore.getDataCollection();
    super.objects = result.docs
        .map((doc) => PointOfInterest.fromMap(doc.data()))
        .toList();
    return super.objects;
  }

  @override
  Future<PointOfInterest> getById(String id) async {

    final QuerySnapshot result = await FirebaseFirestore.instance
      .collection(super.collectionName)
      .where("id", isEqualTo: id)
      .limit(1)
      .get();

    if (result == null || result.docs.isEmpty) {
      return null;
    } else {
      return PointOfInterest.fromMap(result.docs[0].data());
    }
  }

  @override
  Future remove(String id) async {
    await firestore.removeDocument(id) ;
  }

  @override
  Future update(PointOfInterest data, String id) async {

    var result  = await firestore.updateDocument(data.toJson(), id) ;
    return;
  }
}