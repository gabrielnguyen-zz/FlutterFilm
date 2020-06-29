class Scene{
  int sceneId;
  String sceneName;
  String sceneLoc,sceneDes;
  String sceneTimeStart;
  String scenetTimeStop;
  int sceneRec;
  String sceneActors;
  bool isDelete;

  Scene({this.sceneId,this.isDelete,this.sceneActors,this.sceneLoc,this.sceneName,this.sceneRec,this.sceneTimeStart,this.scenetTimeStop,this.sceneDes});
}