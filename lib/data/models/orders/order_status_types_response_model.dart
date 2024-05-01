import 'package:flutter/material.dart';

class OrderStatusTypesResponse {
  Data? data;
  Result? result;

  OrderStatusTypesResponse({this.data, this.result});

  OrderStatusTypesResponse.fromMap(Map<String, dynamic> json) {
    data = json['Data'] != null ? Data.fromMap(json['Data']) : null;
    result = json['Result'] != null ? Result.fromMap(json['Result']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toMap();
    }
    if (result != null) {
      data['Result'] = result!.toMap();
    }
    return data;
  }

  @override
  String toString() => 'OrderStatusTypesResponse(data: $data, result: $result)';
}

class Data {
  List<DeliveryStatusTypes>? deliveryStatusTypes;

  Data({this.deliveryStatusTypes});

  Data.fromMap(Map<String, dynamic> json) {
    if (json['DeliveryStatusTypes'] != null) {
      deliveryStatusTypes = <DeliveryStatusTypes>[];
      json['DeliveryStatusTypes'].forEach((v) {
        deliveryStatusTypes!.add(DeliveryStatusTypes.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliveryStatusTypes != null) {
      data['DeliveryStatusTypes'] =
          deliveryStatusTypes!.map((v) => v.toMap()).toList();
    }
    return data;
  }

  @override
  String toString() => 'Data(deliveryStatusTypes: $deliveryStatusTypes)';
}

class DeliveryStatusTypes {
  String? tYPNM;
  String? tYPNO;
  Color? color;

  DeliveryStatusTypes({
    this.tYPNM,
    this.tYPNO,
    this.color,
  });

  DeliveryStatusTypes.fromMap(Map<String, dynamic> json) {
    tYPNM = json['TYP_NM'];
    tYPNO = json['TYP_NO'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TYP_NM'] = tYPNM;
    data['TYP_NO'] = tYPNO;
    return data;
  }

  @override
  String toString() => 'DeliveryStatusTypes(tYPNM: $tYPNM, tYPNO: $tYPNO)';
}

class Result {
  String? errMsg;
  int? errNo;

  Result({this.errMsg, this.errNo});

  Result.fromMap(Map<String, dynamic> json) {
    errMsg = json['ErrMsg'];
    errNo = json['ErrNo'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ErrMsg'] = errMsg;
    data['ErrNo'] = errNo;
    return data;
  }

  @override
  String toString() => 'Result(errMsg: $errMsg, errNo: $errNo)';
}
