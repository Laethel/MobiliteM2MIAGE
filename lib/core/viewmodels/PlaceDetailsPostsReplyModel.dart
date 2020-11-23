import 'package:flutter/cupertino.dart';
import 'package:mobilitem2miage/core/models/client/Post.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class PlaceDetailsPostsReplyModel extends BaseModel {

  List<Post> posts = new List<Post>();
  TextEditingController newPost = new TextEditingController();
}