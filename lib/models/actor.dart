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
  String createdBy,createdTime,updatedBy,updatedTime,actorId,accountId;
  Actor({
    this.actorName,this.actorDes,this.image,this.phone,this.email,this.createdBy,this.createdTime,this.updatedBy,this.updatedTime,
    this.inProgress,this.done,this.waiting,this.character,this.actFrom,this.actTo,this.sceneId,this.actorId,this.accountId
  } );
}