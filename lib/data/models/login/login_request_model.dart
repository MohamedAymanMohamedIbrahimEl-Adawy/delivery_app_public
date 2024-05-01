class LoginRequestModel {
  Value? value;

  LoginRequestModel({this.value});

  LoginRequestModel.fromMap(Map<String, dynamic> json) {
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
  String toString() => 'LoginRequestModel(value: $value)';
}

class Value {
  String? pLANGNO;
  String? pDLVRYNO;
  String? pPSSWRD;

  Value({this.pLANGNO, this.pDLVRYNO, this.pPSSWRD});

  Value.fromMap(Map<String, dynamic> json) {
    pLANGNO = json['P_LANG_NO'];
    pDLVRYNO = json['P_DLVRY_NO'];
    pPSSWRD = json['P_PSSWRD'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_LANG_NO'] = pLANGNO;
    data['P_DLVRY_NO'] = pDLVRYNO;
    data['P_PSSWRD'] = pPSSWRD;

    return data;
  }

  @override
  String toString() =>
      'Value(pLANGNO: $pLANGNO, pDLVRYNO: $pDLVRYNO, pPSSWRD: $pPSSWRD)';
}
