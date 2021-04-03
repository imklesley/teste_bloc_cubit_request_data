class Post {
  late int userId;
  late int id;
  late String title;
  late String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  Post.fromJson(Map json) {
    this.userId = json['userId'];
    this.id = json['id'];
    this.title = json['title'];
    this.body = json['body'];
  }
}
