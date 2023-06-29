class ModelUsers {
  String? name;
  String? id;
  bool? isDriver;

  ModelUsers({this.name, this.id, this.isDriver});

  ModelUsers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    isDriver = json['isDriver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['isDriver'] = this.isDriver;
    return data;
  }
}
