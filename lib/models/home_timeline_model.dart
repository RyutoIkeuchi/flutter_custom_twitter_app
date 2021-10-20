class HomeTimelineModel {
  String? createdAt;
  String? text;
  String? profileImageUrl;
  String? userName;
  String? userId;
  num? retweetCount;
  num? favoriteCount;
  List<dynamic>? entitiesMedia;
  String? retweetedStatusUserprofileImageUrlHttps;
  List<dynamic>? entitiesUserMentionsName;

  // HomeTimelineModel(
  //   String createdAt,
  //   String text,
  //   String profileImageUrl,
  //   String userName,
  //   String userId,
  //   num retweetCount,
  //   num favoriteCount,
  //   List<dynamic> entitiesMedia,
  //   String retweetedStatusUserprofileImageUrlHttps,
  //   List<dynamic> entitiesUserMentionsName,
  // ) {
  //   this.createdAt = createdAt;
  //   this.text = text;
  //   this.profileImageUrl = profileImageUrl;
  //   this.userName = userName;
  //   this.userId = userId;
  //   this.retweetCount = retweetCount;
  //   this.favoriteCount = favoriteCount;
  //   this.entitiesMedia = entitiesMedia;
  //   this.retweetedStatusUserprofileImageUrlHttps =
  //       retweetedStatusUserprofileImageUrlHttps;
  //   this.entitiesUserMentionsName = entitiesUserMentionsName;
  // }

  HomeTimelineModel({
    this.createdAt,
    this.text,
    this.profileImageUrl,
    this.userName,
    this.userId,
    this.retweetCount,
    this.favoriteCount,
    this.entitiesMedia,
    this.retweetedStatusUserprofileImageUrlHttps,
    this.entitiesUserMentionsName,
  });

  factory HomeTimelineModel.fromJson(Map<String, dynamic> json) =>
      HomeTimelineModel(
        createdAt: json['created_at'],
        text: json['text'],
        profileImageUrl: json['user']['profile_image_url_https'],
        userName: json['user']['name'],
        userId: json['user']['screen_name'],
        retweetCount: json['retweet_count'],
        favoriteCount: json['favorite_count'],
        entitiesMedia: json['entities']['media'],
        retweetedStatusUserprofileImageUrlHttps:
            json['retweeted_status'] != null
                ? json['retweeted_status']['user']['profile_image_url_https']
                : null,
        entitiesUserMentionsName: json['entities']['user_mentions'] != null
            ? json['entities']['user_mentions']
            : null,
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'text': text,
        'profileImageUrl': profileImageUrl,
        'userName': userName,
        'userId': userId,
        'retweetCount': retweetCount,
        'favoriteCount': favoriteCount,
        'entitiesMedia': entitiesMedia,
        'retweetedStatusUserprofileImageUrlHttps':
            retweetedStatusUserprofileImageUrlHttps,
        'entitiesUserMentionsName': entitiesUserMentionsName,
      };

  // HomeTimelineModel.fromJson(Map json)
  //     : createdAt = json['created_at'],
  //       text = json['text'],
  //       profileImageUrl = json['user']['profile_image_url_https'],
  //       userName = json['user']['name'],
  //       userId = json['user']['screen_name'],
  //       retweetCount = json['retweet_count'],
  //       favoriteCount = json['favorite_count'],
  //       entitiesMedia = json['entities']['media'],
  //       retweetedStatusUserprofileImageUrlHttps= json['retweeted_status'] != null ?  json['retweeted_status']['user']['profile_image_url_https'] : null,
  //       entitiesUserMentionsName= json['entities']['user_mentions'] != null ? json['entities']['user_mentions'] : null ;

  // Map toJson() {
  //   return {
  //     'createdAt': createdAt,
  //     'text': text,
  //     'profileImageUrl': profileImageUrl,
  //     'userName': userName,
  //     'userId': userId,
  //     'retweetCount': retweetCount,
  //     'favoriteCount': favoriteCount,
  //     'entitiesMedia': entitiesMedia,
  //     'retweetedStatusUserprofileImageUrlHttps': retweetedStatusUserprofileImageUrlHttps,
  //     'entitiesUserMentionsName': entitiesUserMentionsName,
  //   };
  // }

  @override
  String toString() {
    return "{createdAt: $createdAt, text: $text, profileImageUrl: $profileImageUrl, userName: $userName, userId:$userId,retweetCount: $retweetCount,favoriteCount: $favoriteCount,entitiesMedia: $entitiesMedia,retweetedStatusUserprofileImageUrlHttps: $retweetedStatusUserprofileImageUrlHttps, entitiesUserMentionsName: $entitiesUserMentionsName}";
  }
}

// class Store {
//   String? createdAt;
//   String? text;
//   String? profileImageUrl;
//   String? userName;
//   String? userId;
//   num? retweetCount;
//   num? favoriteCount;
//   List<dynamic>? entitiesMedia;
//   String? retweetedStatusUserprofileImageUrlHttps;
//   List<dynamic>? entitiesUserMentionsName;

//   Store({
//     this.createdAt,
//     this.text,
//     this.profileImageUrl,
//     this.userName,
//     this.userId,
//     this.retweetCount,
//     this.favoriteCount,
//     this.entitiesMedia,
//     this.retweetedStatusUserprofileImageUrlHttps,
//     this.entitiesUserMentionsName,
//   });

//   // factory Store.fromJson(Map<String, dynamic> json) {
//   //   return Store(
//   //    createdAt : json['created_at'].toString(),
//   //    text : json['text'].toString(),
//   //    profileImageUrl : json['user']['profile_image_url_https'].toString(),
//   //    userName : json['user']['name'].toString(),
//   //    userId : json['user']['screen_name'].toString(),
//   //       retweetCount : json['retweet_count'],
//   //       favoriteCount : json['favorite_count'],
//   //       entitiesMedia : json['entities']['media'],
//   //       retweetedStatusUserprofileImageUrlHttps: json['retweeted_status'] != null ?  json['retweeted_status']['user']['profile_image_url_https'].toString() : null,
//   //       entitiesUserMentionsName: json['entities']['user_mentions'] != null ? json['entities']['user_mentions'] : null,
//   //   );
//   // }

//   Store.fromJson(Map json) {
//     createdAt = json['created_at'];
//     text = json['text'];
//     profileImageUrl = json['user']['profile_image_url_https'];
//     userName = json['user']['name'];
//     userId = json['user']['screen_name'];
//     retweetCount = json['retweet_count'];
//     favoriteCount = json['favorite_count'];
//     entitiesMedia = json['entities']['media'];
//     retweetedStatusUserprofileImageUrlHttps = json['retweeted_status'] != null
//         ? json['retweeted_status']['user']['profile_image_url_https']
//         : null;
//     entitiesUserMentionsName = json['entities']['user_mentions'] != null
//         ? json['entities']['user_mentions']
//         : null;
//   }

//   Map toJson() {
//     final Map data = new Map();
//     data['createdAt'] = this.createdAt;
//     data['text'] = this.text;
//     data['profileImageUrl'] = this.profileImageUrl;
//     data['userName'] = this.userName;
//     data['userId'] = this.userId;
//     data['retweetCount'] = this.retweetCount;
//     data['favoriteCount'] = this.favoriteCount;
//     data['entitiesMedia'] = this.entitiesMedia;
//     data['retweetedStatusUserprofileImageUrlHttps'] =
//         this.retweetedStatusUserprofileImageUrlHttps;
//     data['entitiesUserMentionsName'] = this.entitiesUserMentionsName;
//     print(data);
//     return data;
//   }
// }
