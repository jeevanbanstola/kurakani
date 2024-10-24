class ChatUser {
  final String uId;
  final String name;
  final String email;
  final String profileImageUrl;
  late DateTime lastActive;

  ChatUser({ required this.uId,required this.name, required this.email,required this.profileImageUrl, required this.lastActive});

  factory ChatUser.fromJSON(Map<String, dynamic> json){
    return ChatUser(uId: json["uId"], name: json["name"], email: json["email"], profileImageUrl: json["image"], lastActive: json["last_active"].toDate());

  }
  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "email": email,
      "image": profileImageUrl,
      "last_active": lastActive
    };
  }
  String lastDayActive(){
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }
   bool wasRescentlyActive(){
    return DateTime.now().difference(lastActive) .inHours < 2;
   } 
}