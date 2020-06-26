class Tool{
  String toolId, toolName, toolDes, image, createdTime, createdBy, updatedTime, updatedBy;
  bool status, isDelete;
  int quantity;

  Tool({
    this.toolId,this.toolDes,this.toolName,this.image,this.createdBy,this.createdTime,this.updatedBy,this.isDelete,this.quantity
    ,this.status,this.updatedTime
  });
}