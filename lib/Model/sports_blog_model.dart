class SportsBlogModel {
  String author;
  String description;
  String tittle;
  int like;

  SportsBlogModel({this.author, this.description, this.tittle, this.like});

  SportsBlogModel.fromJson(Map<String, dynamic> json) {
    author = json['Author'];
    description = json['Description'];
    tittle = json['Tittle'];
    like = json['like'];
  }
}
