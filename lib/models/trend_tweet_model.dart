class TrendTweetModel {
  String? name;
  String? query;
  String? tweetVolume;

  TrendTweetModel({
    this.name,
    this.query,
    this.tweetVolume,
  });

  factory TrendTweetModel.fromJson(Map<String, dynamic> json) =>
      TrendTweetModel(
        name: json['name'],
        query: json['query'],
        tweetVolume: json['tweet_volume'] != null
            ? '${json['tweet_volume'].toString()}件'
            : 'トレンド',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'query': query,
        'tweetVolume': tweetVolume,
      };

  @override
  String toString() {
    return "{naem: $name, query: $query, tweetVolume: $tweetVolume}";
  }
}
