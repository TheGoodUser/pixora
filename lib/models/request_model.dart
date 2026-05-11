/// [RequestModel] named after the requests table

class RequestModel {
  String? createdAt;
  String? outputUrl;
  int? id;
  String? imageUrl;

  RequestModel({this.createdAt, this.outputUrl, this.id, this.imageUrl});

  RequestModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    outputUrl = json['output_url'];
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['output_url'] = outputUrl;
    data['id'] = id;
    data['image_url'] = imageUrl;
    return data;
  }
}
