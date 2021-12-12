class UserProfileModel {
  final String id;
  final String name;
  final String username;
  final String createdAt;
  final String description;
  final String profileImageUrl;
  final String location;
  final int followingCount;
  final int followersCount;
  final int tweetCount;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.createdAt,
    required this.description,
    required this.profileImageUrl,
    required this.location,
    required this.followingCount,
    required this.followersCount,
    required this.tweetCount,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      createdAt: json['created_at'],
      description: json['description'],
      profileImageUrl: json['profile_image_url'],
      location: json['location'],
      followingCount: json['public_metrics']['following_count'],
      followersCount: json['public_metrics']['followers_count'],
      tweetCount: json['public_metrics']['tweet_count'],
    );
  }

  @override
  String toString() {
    return "{id:$id,name: $name, username: $username, createdAt: $createdAt,description:$description,profileImageUrl:$profileImageUrl,location:$location,followingCount:$followingCount,followersCount:$followersCount,tweetCount:$tweetCount}";
  }
}
