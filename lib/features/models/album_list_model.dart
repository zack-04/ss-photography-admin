class AlbumListResponse {
  final List<Album> data;
  final String status;
  final String remarks;

  AlbumListResponse({
    required this.data,
    required this.status,
    required this.remarks,
  });

  factory AlbumListResponse.fromJson(Map<String, dynamic> json) {
    return AlbumListResponse(
      data: List<Album>.from(json['data'].map((x) => Album.fromJson(x))),
      status: json['status'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'status': status,
      'remarks': remarks,
    };
  }
}

class Album {
  final String albumName;
  final String albumId;

  Album({
    required this.albumName,
    required this.albumId,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumName: json['album_name'],
      albumId: json['album_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'album_name': albumName,
      'album_id': albumId,
    };
  }
}
