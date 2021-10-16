
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

  HomeTimelineModel(
    String createdAt,
    String text,
    String profileImageUrl,
    String userName,
    String userId,
    num retweetCount,
    num favoriteCount,
    List<dynamic> entitiesMedia,
    String retweetedStatusUserprofileImageUrlHttps,
    List<dynamic> entitiesUserMentionsName,
  ) {
    this.createdAt = createdAt;
    this.text = text;
    this.profileImageUrl = profileImageUrl;
    this.userName = userName;
    this.userId = userId;
    this.retweetCount = retweetCount;
    this.favoriteCount = favoriteCount;
    this.entitiesMedia = entitiesMedia;
    this.retweetedStatusUserprofileImageUrlHttps = retweetedStatusUserprofileImageUrlHttps;
    this.entitiesUserMentionsName = entitiesUserMentionsName;
  }

  HomeTimelineModel.fromJson(Map json)
      : createdAt = json['created_at'],
        text = json['text'],
        profileImageUrl = json['user']['profile_image_url_https'],
        userName = json['user']['name'],
        userId = json['user']['screen_name'],
        retweetCount = json['retweet_count'],
        favoriteCount = json['favorite_count'],
        entitiesMedia = json['entities']['media'],
        retweetedStatusUserprofileImageUrlHttps= json['retweeted_status'] != null ?  json['retweeted_status']['user']['profile_image_url_https'] : null,
        entitiesUserMentionsName= json['entities']['user_mentions'] != null ? json['entities']['user_mentions'] : null ;

  Map toJson() {
    return {
      'createdAt': createdAt,
      'text': text,
      'profileImageUrl': profileImageUrl,
      'userName': userName,
      'userId': userId,
      'retweetCount': retweetCount,
      'favoriteCount': favoriteCount,
      'entitiesMedia': entitiesMedia,
      'retweetedStatusUserprofileImageUrlHttps': retweetedStatusUserprofileImageUrlHttps,
      'entitiesUserMentionsName': entitiesUserMentionsName,
    };
  }

  @override
  String toString() {
    return "createdAt: $createdAt, text: $text, profileImageUrl: $profileImageUrl, userName: $userName, userId:$userId,retweetCount: $retweetCount,favoriteCount: $favoriteCount,entitiesMedia: $entitiesMedia,retweetedStatusUserprofileImageUrlHttps: $retweetedStatusUserprofileImageUrlHttps, entitiesUserMentionsName: $entitiesUserMentionsName";
  }
}
