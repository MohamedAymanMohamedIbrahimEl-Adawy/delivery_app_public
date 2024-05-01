// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrdersResponseModel {
  Data? data;
  Result? result;

  OrdersResponseModel({this.data, this.result});

  OrdersResponseModel.fromMap(Map<String, dynamic> json) {
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
  String toString() => 'OrdersResponseModel(data: $data, result: $result)';
}

class Data {
  List<DeliveryBills>? deliveryBills;

  Data({this.deliveryBills});

  Data.fromMap(Map<String, dynamic> json) {
    if (json['DeliveryBills'] != null) {
      deliveryBills = <DeliveryBills>[];
      json['DeliveryBills'].forEach((v) {
        deliveryBills!.add(DeliveryBills.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliveryBills != null) {
      data['DeliveryBills'] = deliveryBills!.map((v) => v.toMap()).toList();
    }
    return data;
  }

  @override
  String toString() => 'Data(deliveryBills: $deliveryBills)';
}

class DeliveryBills {
  String? bILLAMT;
  String? bILLDATE;
  String? bILLNO;
  String? bILLSRL;
  String? bILLTIME;
  String? bILLTYPE;
  String? cSTMRADDRSS;
  String? cSTMRAPRTMNTNO;
  String? cSTMRBUILDNO;
  String? cSTMRFLOORNO;
  String? cSTMRNM;
  String? dLVRYAMT;
  String? dLVRYSTATUSFLG;
  String? lATITUDE;
  String? lONGITUDE;
  String? mOBILENO;
  String? rGNNM;
  String? tAXAMT;

  DeliveryBills(
      {this.bILLAMT,
      this.bILLDATE,
      this.bILLNO,
      this.bILLSRL,
      this.bILLTIME,
      this.bILLTYPE,
      this.cSTMRADDRSS,
      this.cSTMRAPRTMNTNO,
      this.cSTMRBUILDNO,
      this.cSTMRFLOORNO,
      this.cSTMRNM,
      this.dLVRYAMT,
      this.dLVRYSTATUSFLG,
      this.lATITUDE,
      this.lONGITUDE,
      this.mOBILENO,
      this.rGNNM,
      this.tAXAMT});

  DeliveryBills.fromMap(Map<String, dynamic> json) {
    bILLAMT = json['BILL_AMT'];
    bILLDATE = json['BILL_DATE'];
    bILLNO = json['BILL_NO'];
    bILLSRL = json['BILL_SRL'];
    bILLTIME = json['BILL_TIME'];
    bILLTYPE = json['BILL_TYPE'];
    cSTMRADDRSS = json['CSTMR_ADDRSS'];
    cSTMRAPRTMNTNO = json['CSTMR_APRTMNT_NO'];
    cSTMRBUILDNO = json['CSTMR_BUILD_NO'];
    cSTMRFLOORNO = json['CSTMR_FLOOR_NO'];
    cSTMRNM = json['CSTMR_NM'];
    dLVRYAMT = json['DLVRY_AMT'];
    dLVRYSTATUSFLG = json['DLVRY_STATUS_FLG'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
    mOBILENO = json['MOBILE_NO'];
    rGNNM = json['RGN_NM'];
    tAXAMT = json['TAX_AMT'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BILL_AMT'] = bILLAMT;
    data['BILL_DATE'] = bILLDATE;
    data['BILL_NO'] = bILLNO;
    data['BILL_SRL'] = bILLSRL;
    data['BILL_TIME'] = bILLTIME;
    data['BILL_TYPE'] = bILLTYPE;
    data['CSTMR_ADDRSS'] = cSTMRADDRSS;
    data['CSTMR_APRTMNT_NO'] = cSTMRAPRTMNTNO;
    data['CSTMR_BUILD_NO'] = cSTMRBUILDNO;
    data['CSTMR_FLOOR_NO'] = cSTMRFLOORNO;
    data['CSTMR_NM'] = cSTMRNM;
    data['DLVRY_AMT'] = dLVRYAMT;
    data['DLVRY_STATUS_FLG'] = dLVRYSTATUSFLG;
    data['LATITUDE'] = lATITUDE;
    data['LONGITUDE'] = lONGITUDE;
    data['MOBILE_NO'] = mOBILENO;
    data['RGN_NM'] = rGNNM;
    data['TAX_AMT'] = tAXAMT;
    return data;
  }

  @override
  String toString() {
    return 'DeliveryBills(bILLAMT: $bILLAMT, bILLDATE: $bILLDATE, bILLNO: $bILLNO, bILLSRL: $bILLSRL, bILLTIME: $bILLTIME, bILLTYPE: $bILLTYPE, cSTMRADDRSS: $cSTMRADDRSS, cSTMRAPRTMNTNO: $cSTMRAPRTMNTNO, cSTMRBUILDNO: $cSTMRBUILDNO, cSTMRFLOORNO: $cSTMRFLOORNO, cSTMRNM: $cSTMRNM, dLVRYAMT: $dLVRYAMT, dLVRYSTATUSFLG: $dLVRYSTATUSFLG, lATITUDE: $lATITUDE, lONGITUDE: $lONGITUDE, mOBILENO: $mOBILENO, rGNNM: $rGNNM, tAXAMT: $tAXAMT)';
  }
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
