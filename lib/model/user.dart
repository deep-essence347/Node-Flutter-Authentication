class UserModel{
  final String id;
  final String username;
  final String profile;

  UserModel({this.id,this.username,this.profile});

  UserModel.fromJson(Map<String,dynamic> user):
      id = user['_id'],
      username = user['username'],
      profile = user['profile'];
}