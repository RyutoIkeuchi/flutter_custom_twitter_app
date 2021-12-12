class HomeTimelineModel {
  final bool retweetedStatus;
  final String createdAt;
  final String text;
  final String? profileImageUrl;
  final String userName;
  final String userId;
  final int retweetCount;
  final int favoriteCount;
  final List<dynamic>? entitiesMedia;
  final String? retweetingUser;

  HomeTimelineModel({
    required this.retweetedStatus,
    required this.createdAt,
    required this.text,
    this.profileImageUrl,
    required this.userName,
    required this.userId,
    required this.retweetCount,
    required this.favoriteCount,
    this.entitiesMedia,
    this.retweetingUser,
  });

  factory HomeTimelineModel.fromJson(Map<String, dynamic> json) {
    return json['retweeted_status'] != null
        ? HomeTimelineModel(
            retweetedStatus: true,
            createdAt: json['retweeted_status']['created_at'],
            text: json['retweeted_status']['text'],
            profileImageUrl: json['retweeted_status']['user']
                ['profile_image_url_https'],
            userName: json['retweeted_status']['user']['name'],
            userId: json['retweeted_status']['user']['screen_name'],
            retweetCount: json['retweeted_status']['retweet_count'],
            favoriteCount: json['retweeted_status']['favorite_count'],
            entitiesMedia: json['retweeted_status']['entities']['media'],
            retweetingUser: json['user']['name'],
          )
        : HomeTimelineModel(
            retweetedStatus: false,
            createdAt: json['created_at'],
            text: json['text'],
            profileImageUrl: json['user']['profile_image_url_https'],
            userName: json['user']['name'],
            userId: json['user']['screen_name'],
            retweetCount: json['retweet_count'],
            favoriteCount: json['favorite_count'],
            entitiesMedia:json['entities']['media'],
          );
  }

  @override
  String toString() {
    return "{retweetedStatus:$retweetedStatus,createdAt: $createdAt, text: $text, profileImageUrl: $profileImageUrl, userName: $userName, userId:$userId,retweetCount: $retweetCount,favoriteCount: $favoriteCount,entitiesMedia: $entitiesMedia,retweetingUser: $retweetingUser,}";
  }
}
