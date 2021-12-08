class FollowingAndFollowerModel {
  final String id;
  final String name;
  final String username;
  final String createdAt;
  final String description;
  final String profileImageUrl;

  FollowingAndFollowerModel({
    required this.id,
    required this.name,
    required this.username,
    required this.createdAt,
    required this.description,
    required this.profileImageUrl,
  });

  factory FollowingAndFollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowingAndFollowerModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      createdAt: json['created_at'],
      description: json['description'],
      profileImageUrl: json['profile_image_url'],
    );
  }

  @override
  String toString() {
    return "{id:$id,name: $name, username: $username, createdAt: $createdAt,description:$description,profileImageUrl:$profileImageUrl}";
  }
}
