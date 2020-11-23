import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/models/client/Post.dart';
import 'package:mobilitem2miage/core/services/dao/PostDao.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'file:///C:/Users/andre/AndroidStudioProjects/mobilitem2miage/lib/core/viewmodels/PlaceDetailsPostsReplyModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/ui/widgets/WTextField.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PlaceDetailsPostReplyView extends StatefulWidget {

  Post post;

  PlaceDetailsPostReplyView({this.post});

  @override
  State<StatefulWidget> createState() {

    return PlaceDetailsPostReplyViewState();
  }
}

class PlaceDetailsPostReplyViewState extends State<PlaceDetailsPostReplyView> {

  @override
  Widget build(BuildContext context) {

    var postDao = Provider.of<PostDao>(context);
    var appState = Provider.of<AppState>(context);
    
    return BaseView<PlaceDetailsPostsReplyModel>(
      onModelReady: (model) {
        model.posts.add(widget.post);
        if (widget.post.postResponses != null) {
          model.posts.addAll(widget.post.postResponses);
        }
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Réponses"),
          backgroundColor: Color(0xFF809cc5),
        ),
        body: ListView.builder(
          /// Count posts responses + initial post
          itemCount: model.posts.length,
          itemBuilder: (BuildContext context, int index) {
            Post post = model.posts[index];
            return Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage("res/assets/img/macron.jpg")
                                  )
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, "/userProfil", arguments: post.user);
                            },
                          ),
                          SizedBox(width: 5.0),

                          /// Flexible is necessary to wrap the text overflow
                          Flexible(
                            child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        post.user.firstName + " " + post.user.lastName,
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        post.value,
                                        overflow: TextOverflow.clip,
                                        maxLines: 10,
                                      )
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                            ),
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 60.0),
                        child: Row(
                          children: [
                            Text(
                              post.date.day.toString() + "/" + post.date.month.toString() + "/" + post.date.year.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 12.0
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            );
          }
        ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: WTextField(
                  value: "Votre avis...",
                  controller: model.newPost,
                ),
                flex: 3,
              ),
              Expanded(
                child: IconButton(
                  onPressed: () async {

                    Post newPost = new Post(
                      idEtablishment: widget.post.idEtablishment,
                      date: DateTime.now(),
                      user: appState.user,
                      value: model.newPost.value.text,
                    );

                    postDao.remove(widget.post.id);
                    widget.post.postResponses.add(newPost);
                    postDao.add(widget.post);
                    model.posts.add(newPost);

                    model.newPost.clear();
                    model.notifyListeners();
                  },
                  icon: Icon(Icons.send),
                ),
              )
            ],
          )
      )
    );
  }
}