class Story {
  int? id;
  String? judul;
  String? gambar;
  String? author;

  Story(
      {this.id,
      this.judul,
      this.gambar,
      this.author});

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    gambar = json['gambar'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['gambar'] = gambar;
    data['author'] = author;
    return data;
  }
}

class StoryDetail {
  String? author;
  String? gambar;
  int? id;
  String? judul;
  String? kategori;
  String? ringkas;
  String? text;
  String? tokoh;

  StoryDetail(
      {this.author,
        this.gambar,
        this.id,
        this.judul,
        this.kategori,
        this.ringkas,
        this.text,
        this.tokoh});

  StoryDetail.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    gambar = json['gambar'];
    id = json['id'];
    judul = json['judul'];
    kategori = json['kategori'];
    ringkas = json['ringkas'];
    text = json['text'];
    tokoh = json['tokoh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['gambar'] = gambar;
    data['id'] = id;
    data['judul'] = judul;
    data['kategori'] = kategori;
    data['ringkas'] = ringkas;
    data['text'] = text;
    data['tokoh'] = tokoh;
    return data;
  }
}

