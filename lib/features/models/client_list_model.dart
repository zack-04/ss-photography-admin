// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClientData {
  final String clientName;
  final String mobileNumber;
  final String imageFileName;
  final String clientId;

  ClientData({
    required this.clientName,
    required this.mobileNumber,
    required this.imageFileName,
    required this.clientId,
  });
  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      clientName: json['client_name'] ?? '',
      mobileNumber: json['mobile_no'] ?? '',
      imageFileName: json['image_file_name'] ?? '',
      clientId: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_name': clientName,
      'mobile_no': mobileNumber,
      'image_file_name': imageFileName,
      'id': clientId,
    };
  }
}

class ClientListResponse {
  final List<ClientData> data;
  final String status;
  final String remarks;

  ClientListResponse({
    required this.data,
    required this.status,
    required this.remarks,
  });

  factory ClientListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ClientData> userList =
        list.map((i) => ClientData.fromJson(i)).toList();

    return ClientListResponse(
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
