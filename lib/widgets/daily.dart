import 'package:beer/widgets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:beer/interfaces/Post.dart';

class Daily extends StatefulWidget {
  Daily({Key key}) : super(key: key);
  @override
  DailyState createState() => DailyState();
}

class DailyState extends State<Daily> with SingleTickerProviderStateMixin {
  List<Widget> cards = [];
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    getAllCurrentPosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAllCurrentPosts() async {
    try {
      var response = await Post.get();
      setState(() {
        posts = response;
      });
      _generateFeedCards();
    } catch (e) {
      print(e);
    }
  }

//could be generated off followers and random users in the area.
//only local posts / follower posts
  _generateFeedCards() {
    List<Widget> newCards = [];
    for (var i = 0; i < posts.length; i++) {
      var newCard = Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          color: appColor,
          elevation: 5.0,
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(posts[i].profileImageUrl),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      posts[i].username,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Image(
                fit: BoxFit.fitHeight,
                image: NetworkImage('https://picsum.photos/400/200'),
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () => {print('dddd')},
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () => {print('dddd')},
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () => {print('dddd')},
                  )
                ],
              )
            ],
          ),
          borderOnForeground: true,
        ),
      );

      newCards.add(newCard);
    }
    setState(() {
      cards = newCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(shrinkWrap: true, children: cards),
    );
  }
}
