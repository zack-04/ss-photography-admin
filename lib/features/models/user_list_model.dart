class UserData {
  final String id;
  final String name;
  final String mobile;
  final String role;
  final String status;

  UserData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.role,
    required this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      role: json['role'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'role': role,
      'status': status,
    };
  }
}

class UserListResponse {
  final List<UserData> data;
  final String status;
  final String remarks;

  UserListResponse({
    required this.data,
    required this.status,
    required this.remarks,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<UserData> userList = list.map((i) => UserData.fromJson(i)).toList();

    return UserListResponse(
      data: userList,
      status: json['status'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((user) => user.toJson()).toList(),
      'status': status,
      'remarks': remarks,
    };
  }
}
