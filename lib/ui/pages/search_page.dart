import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:flutter_custom_twitter_app/ViewModel/searchword_provider.dart';
import 'package:flutter_custom_twitter_app/models/user_profile_model.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search/search_trend_page.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search/search_tweet_page.dart';

import 'package:flutter_custom_twitter_app/ui/components/atoms/search_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FocusNode _focus = new FocusNode();
  bool _isFocus = false;

  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocus = _focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, watch, child) {
          String word = watch(searchwordProvider).state;
          return Container(
            width: 260,
            height: 40,
            child: TextField(
              controller: TextEditingController(text: word),
              maxLines: 1,
              focusNode: _focus,
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                if (text != '') {
                  context.read(searchwordProvider).state = text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchTweet()),
                  );
                }
              },
              style: TextStyle(
                height: 0.9,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search, size: 20),
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: '?????????????????????'),
            ),
          );
        }),
        leading: !_isFocus
            ? Consumer(
                builder: (context, watch, child) {
                  AsyncValue<UserProfileModel> value =
                      watch(accountProfileProvider);
                  return value.when(
                    data: (value) {
                      return TextButton(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(value.profileImageUrl,
                              width: 36, height: 36, fit: BoxFit.fill),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                      );
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (err, stack) => Text('Error: $err'),
                  );
                },
              )
            : null,
        actions: _isFocus
            ? [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 20),
                  height: 40,
                  child: TextButton(
                    child: Text('???????????????'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        _isFocus = false;
                      });
                    },
                  ),
                )
              ]
            : null,
      ),
      body: _isFocus ? searchScreen() : SearchTrendWordScreen(),
    );
  }
}
