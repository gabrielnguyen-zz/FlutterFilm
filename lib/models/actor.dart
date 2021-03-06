class Actor{
  String actorName;
  String actorDes;
  String image;
  String phone;
  String email;
  int waiting;
  int inProgress;
  int done;
  String character;
  String actFrom;
  String actTo;
  int sceneId;
  bool isDelete;
  String createdBy,createdTime,updatedBy,updatedTime,actorId,accountId,password;
  Actor({
    this.actorName,this.isDelete,this.actorDes,this.image,this.phone,this.email,this.createdBy,this.createdTime,this.updatedBy,this.updatedTime,
    this.inProgress,this.done,this.waiting,this.character,this.actFrom,this.actTo,this.sceneId,this.actorId,this.accountId,this.password
  } );
  Actor.fromJSON(Map<String,dynamic> json):
    actorName =json['actorName'],
    actorDes = json['actorDes'],
    image = json['image'],
    phone = json['phone'],
    email = json['email'];


  Map<String,dynamic> toJson() => {
    'actorName' : actorName,
    'actorDes'  : actorDes,
    'image' : image,
    'phone' : phone,
    'email' : email
  };
}