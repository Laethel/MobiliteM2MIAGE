import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/models/client/Post.dart';
import 'package:mobilitem2miage/core/services/dao/PostDao.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceDetailsHomeModel.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceDetailsPostsModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobilitem2miage/ui/widgets/WTextField.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PlaceDetailsPostsView extends StatefulWidget {

  PlaceDetails place;

  PlaceDetailsPostsView({this.place});

  @override
  State<StatefulWidget> createState() {

    return PlaceDetailsPostsViewState();
  }
}

class PlaceDetailsPostsViewState extends State<PlaceDetailsPostsView> {

  @override
  Widget build(BuildContext context) {

    var postDao = Provider.of<PostDao>(context);
    var appState = Provider.of<AppState>(context);

    return BaseView<PlaceDetailsPostsModel>(
      onModelReady: (model) async {
        model.posts = await postDao.find("idEtablishment", widget.place.placeId);
        model.notifyListeners();
      },
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(
                      "Avis",
                      style: GoogleFonts.roboto(
                          fontSize: 22.0
                      ),
                    ),
                  ),
                  model.posts.isNotEmpty ? Text(model.posts.length.toString() + " message" + (model.posts.length == 1 ? "" : "(s)")) : SizedBox.shrink()
                ],
              ),
            ),

            model.posts.isNotEmpty ? Expanded(
              child: ListView.builder(
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
                                    model.getFormatedPostDate(post.date),
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.0,
                                      color: Color(0xFF333333)
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/postReply", arguments: post).then((value) {
                                        /// This is for reload posts card
                                        model.notifyListeners();
                                      });
                                    },
                                    child: Text(
                                      "Répondre",
                                      style: GoogleFonts.roboto(
                                        color: Color(0xFF333333)
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  appState.user.email == post.user.email ? InkWell(
                                    onTap: () async {
                                      bool delete = await model.alertDialog(context);
                                      if (delete) {
                                        await postDao.remove(post.id);
                                        model.posts = await postDao.find("idEtablishment", widget.place.placeId);
                                        model.notifyListeners();
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.trash,
                                      size: 14.0,
                                    ),
                                  ) : SizedBox.shrink()
                                ],
                              ),
                            ),

                            post.postResponses.length != 0 ? Padding(
                              padding: EdgeInsets.only(left: 60.0, top: 5.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/postReply", arguments: post).then((value) {
                                        /// This is for reload posts card
                                        model.notifyListeners();
                                      });
                                    },
                                    child: Text(
                                      post.postResponses.length == 1 ? "Afficher la réponse" : "Afficher les " + post.postResponses.length.toString() + " autres réponses",
                                      style: GoogleFonts.roboto(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF333333)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ) : SizedBox.shrink(),

                          ],
                        ),
                      )
                    );
                  }
              ),
              flex: 100,
            ) : Text("Soyez le premier à donner un avis"),
          ],
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
                  Uuid uuid = new Uuid();
                  await postDao.add(new Post(
                    id: uuid.v1(),
                    idEtablishment: widget.place.placeId,
                    value: model.newPost.value.text,
                    user: appState.user,
                    date: DateTime.now(),
                    postResponses: new List<Post>()
                  ));
                  model.posts = await postDao.find("idEtablishment", widget.place.placeId);
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