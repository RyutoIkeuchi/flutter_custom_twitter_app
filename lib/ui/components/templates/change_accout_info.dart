import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:flutter_custom_twitter_app/models/user_profile_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeAccountInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<UserProfileModel> value = watch(accountProfileProvider);
    return value.when(
      data: (value) {
        return Scaffold(
          appBar: AppBar(
            title: Text('変更',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
            leading: OverflowBox(
              maxWidth: 200,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      "キャンセル",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                      ),
                    ),
                  )),
            ),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.black26, width: 0.5))),
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 50),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.20,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 40,
                          )),
                      Positioned(
                        top: 150,
                        left: 20,
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(32),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(value.profileImageUrl),
                                  fit: BoxFit.cover)),
                          child: Center(
                              child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 26,
                          )),
                        ),
                      )
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black26))),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            '名前',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        )),
                    Expanded(
                        flex: 10,
                        child: Container(
                            child: Text(value.name,
                                style: TextStyle(fontSize: 12))))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black26))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            '自己紹介',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        )),
                    Expanded(
                        flex: 10,
                        child: Container(
                            child: Text(
                          value.description,
                          style: TextStyle(fontSize: 12),
                        )))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black26))),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            '場所',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        )),
                    Expanded(
                        flex: 10,
                        child: Container(
                            child: Text('位置情報を追加',
                                style: TextStyle(fontSize: 12))))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black26))),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            'Web',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        )),
                    Expanded(
                        flex: 10,
                        child: Container(
                            child: Text('Webサイトを追加',
                                style: TextStyle(fontSize: 12))))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black26))),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            '生年月日',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        )),
                    Expanded(
                        flex: 10,
                        child: Container(
                            child: Text('1999年12月28日',
                                style: TextStyle(fontSize: 12))))
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
