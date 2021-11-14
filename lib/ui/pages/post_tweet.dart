import 'package:flutter/material.dart';

class PostTweet extends StatefulWidget {
  _PostTweet createState() => _PostTweet();
}

class _PostTweet extends State<PostTweet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       persistentFooterButtons: <Widget>[
        IconButton(
          icon: Icon(Icons.add_a_photo_outlined),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.photo_outlined),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.gif),
          onPressed: () => {},
        ),
      ],
        body: Container(
            padding: EdgeInsets.only(left: 20, right: 20,top: 40),
            child: Column(
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          'キャンセル',
                          style: TextStyle(color: Colors.black87),
                        ),
                        onPressed: () => {Navigator.of(context).pop()},
                      ),
                      TextButton(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text('ツイートする',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              )),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Icon(Icons.face) 
                          )
                        ),
                        Expanded(
                          flex: 10,
                          child:  TextField(
                            autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'いまどうしてる？',
                            border: InputBorder.none,
                          ),
                          maxLength: 130,
                          maxLines: 20,
                          minLines: 5,
                          enabled: true,
                        ),
                        )
                      ],
                    )
                  ),
              ],
            )));
  }
}
