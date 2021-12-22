class BlogModel {
  String author;
  String description;
  String tittle;
  String catogory;
  int like;
   String id;

  BlogModel({this.author, this.description, this.tittle, this.catogory, this.like, this.id});

  BlogModel.fromJson(Map<String, dynamic> json) {
    author = json['Author'];
    description = json['Description'];
    tittle = json['Tittle'];
    catogory = json['catogory'];
    like = json['like'];
    id= json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    this.author = data['Author'];
    this.description = data['Description'];
    this.tittle = data['Tittle'];
    this.catogory = data['catogory'];
    this.like = data['like'];
    return data;
  }
}
