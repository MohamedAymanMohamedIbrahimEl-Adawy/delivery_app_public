class Constants {
  static const appName = 'AG Movies';
  static const baseUrl = 'http://mapp.yemensoft.net';

  // Shared preferences keys
  static String isFirstOpenKey = 'isFirstOpen';
  static String fcmTokenKey = 'fcmToken';
  static String userLoginToken = 'userLoginToken';
  static String languageCodeKey = 'languageKey';
  static String countryCodeKey = 'countryCode';
  static String isLoggedInKey = 'isLoggedIn';
  static String logginTokenKey = 'loginToken';
  static String userIdKey = 'userId';
  static String userNameKey = 'userName';
  static String passwordKey = 'password';
  static String langaugeNumberKey = 'langaugeNumber';

  // apiEndpoints
  static String orders =
      '$baseUrl/OnyxDeliveryService/Service.svc/GetDeliveryBillsItems';

  static String orderStatusTypes =
      '$baseUrl/OnyxDeliveryService/Service.svc/GetDeliveryStatusTypes';
  static String orderById(int id) => "$baseUrl/";

  static String loginApi =
      '$baseUrl/OnyxDeliveryService/Service.svc/CheckDeliveryLogin';
}
