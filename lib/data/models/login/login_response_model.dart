// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponseModel {
  Data? data;
  Result? result;

  LoginResponseModel({this.data, this.result});

  LoginResponseModel.fromMap(Map<String, dynamic> json) {
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    result = json['Result'] != null ? Result.fromJson(json['Result']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    if (result != null) {
      data['Result'] = result!.toJson();
    }
    return data;
  }

  @override
  String toString() => 'LoginResponseModel(data: $data, result: $result)';
}

class Data {
  String? deliveryName;

  Data({this.deliveryName});

  Data.fromJson(Map<String, dynamic> json) {
    deliveryName = json['DeliveryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DeliveryName'] = deliveryName;
    return data;
  }

  @override
  String toString() => 'Data(deliveryName: $deliveryName)';
}

class Result {
  String? errMsg;
  int? errNo;

  Result({this.errMsg, this.errNo});

  Result.fromJson(Map<String, dynamic> json) {
    errMsg = json['ErrMsg'];
    errNo = json['ErrNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ErrMsg'] = errMsg;
    data['ErrNo'] = errNo;
    return data;
  }

  @override
  String toString() => 'Result(errMsg: $errMsg, errNo: $errNo)';
}
