// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorage {
//   static SharedPreferences? _prefs;

//   // initial SharedPreferences

//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // store data to local storage

//   static Future<void> storeData({String? key, dynamic value}) async {
//     // if (value.runtimeType == String) {
//     //   await _prefs!.setString(key!, value);
//     // } else if (value.runtimeType == int) {
//     //   await _prefs!.setInt(key!, value);
//     // } else if (value.runtimeType == bool) {
//     //   await _prefs!.setBool(key!, value);
//     // } else if (value.runtimeType == double) {
//     //   await _prefs!.setDouble(key!, value);
//     // } else {
//     //   _prefs!.setStringList(key!, value);
//     // }
//     //======> new ****

//     if (_prefs == null) {
//       throw Exception("LocalStorage not initialized. Call `init()` first.");
//     }
//      if (value is String) {
//       await _prefs?.setString(key!, value);
//     } else if (value is int) {
//       await _prefs?.setInt(key!, value);
//     } else if (value is bool) {
//       await _prefs?.setBool(key!, value);
//     } else if (value is double) {
//       await _prefs?.setDouble(key!, value);
//     } else if (value is List<String>) {
//       await _prefs?.setStringList(key!, value);
//     } else {
//       throw Exception("Unsupported data type: ${value.runtimeType}");
//     }

//   }


//  /// Retrieve data from local storage
//   // static T? getData<T>({required String key}) {
//   //   if (_prefs == null) {
//   //     throw Exception("LocalStorage not initialized. Call `init()` first.");
//   //   }

//   //   return _prefs!.get(key) as T?;
//   // }

//   // function for get data from local storage

//   static Future<int> getIntValue({String? key}) async {
//     return  ( await _prefs?.getInt(key!) ?? 0);
//   }

//   static Future<String> getStringValue({
//     String? key,
//   }) async {
//     return  ( await _prefs?.getString(key!) ?? "");
//   }

//   static Future<bool> getBooleanValue({String? key}) async {
//     return  ( await _prefs?.getBool(key!) ?? false);
//   }

//   static Future<double> getDoubleValue({String? key}) async {
//     return  ( await _prefs?.getDouble(key!) ?? 0.0);
//   }

//   static Future<List<String>> getListStringValue({required String key}) async {
//     return (await _prefs?.getStringList(key) ?? []);
//   }

//   static Future<void> storeListStringValue({
//     required String key,
//     required List<String> value,
//   }) async {
//    await _prefs?.setStringList(key, value);
//   }
// }


import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  // initial SharedPreferences

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  // store data to local storage

  static Future<void> storeData({String? key, dynamic value}) async {
    if (value.runtimeType == String) {
      await _prefs!.setString(key!, value);
    } else if (value.runtimeType == int) {
      await _prefs!.setInt(key!, value);
    } else if (value.runtimeType == bool) {
      await _prefs!.setBool(key!, value);
    } else if (value.runtimeType == double) {
      await _prefs!.setDouble(key!, value);
    } else {
      _prefs!.setStringList(key!, value);
    }
  }

  // function for get data from local storage

  static Future<int> getIntValue({String? key}) async {
    return (_prefs!.getInt(key!) ?? 0);
  }

  static Future<String> getStringValue({String? key}) async {
    return (_prefs!.getString(key!) ?? "");
  }

  static Future<bool> getBooleanValue({String? key}) async {
    return (_prefs!.getBool(key!) ?? false);
  }

  static Future<double> getDoubleValue({String? key}) async {
    return (_prefs!.getDouble(key!) ?? 0.0);
  }
}
