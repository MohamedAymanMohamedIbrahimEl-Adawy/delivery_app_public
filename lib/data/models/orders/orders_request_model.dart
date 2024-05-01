class OrdersRequestModel {
  Value? value;

  OrdersRequestModel({this.value});

  OrdersRequestModel.fromMap(Map<String, dynamic> json) {
    value = json['Value'] != null ? Value.fromMap(json['Value']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['Value'] = value!.toMap();
    }
    return data;
  }

  @override
  String toString() => 'OrdersRequestModel(value: $value)';
}

class Value {
  String? pDLVRYNO;
  String? pLANGNO;
  String? pBILLSRL;
  String? pPRCSSDFLG;

  Value({this.pDLVRYNO, this.pLANGNO, this.pBILLSRL, this.pPRCSSDFLG});

  Value.fromMap(Map<String, dynamic> json) {
    pDLVRYNO = json['P_DLVRY_NO'];
    pLANGNO = json['P_LANG_NO'];
    pBILLSRL = json['P_BILL_SRL'];
    pPRCSSDFLG = json['P_PRCSSD_FLG'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_DLVRY_NO'] = pDLVRYNO;
    data['P_LANG_NO'] = pLANGNO;
    data['P_BILL_SRL'] = pBILLSRL;
    data['P_PRCSSD_FLG'] = pPRCSSDFLG;
    return data;
  }

  @override
  String toString() {
    return 'Value(pDLVRYNO: $pDLVRYNO, pLANGNO: $pLANGNO, pBILLSRL: $pBILLSRL, pPRCSSDFLG: $pPRCSSDFLG)';
  }
}
