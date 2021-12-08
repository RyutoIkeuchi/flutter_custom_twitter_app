class TrendWordModel {
  final String name;
  final String query;
  final String tweetVolume;

  TrendWordModel({
    required this.name,
    required this.query,
    required this.tweetVolume,
  });

  factory TrendWordModel.fromJson(Map<String, dynamic> json) {
    return TrendWordModel(
      name: json['name'],
      query: json['query'],
      tweetVolume: json['tweet_volume'] != null
          ? '${json['tweet_volume'].toString()}件'
          : 'トレンド',
    );
  }

  @override
  String toString() {
    return "{name: $name, query: $query, tweetVolume: $tweetVolume}";
  }
}
