import 'package:jobcdp/model/base_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with BaseRequest {
  late String user_name;
  late String user_email;
  late String user_photo;
  late String user_id;

  UserModel(this.user_email,this.user_id,this.user_name,this.user_photo);

  UserModel.map(dynamic obj) {
    user_name = obj["user_name"];
    user_email = obj["user_email"];
    user_photo = obj["user_photo"];
    user_id = obj["user_id"];
  }

  Map<String, String> toMap() {
    return {
      "user_name": user_name,
      "user_email": user_email,
      "user_photo": user_photo,
      "user_id": user_id
    };
  }

  void saveUserDetails() {
    SharedPreferences.getInstance().then((value) {
      value.setStringList("user", [user_name,user_email,user_photo,user_id]);
    });
  }

  Future<void> clearData() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("user", []);
    user_name = "";
    user_email = "";
    user_photo = "";
    user_id = "";
  }

  Future<void> getSavedUserDetails() async {
    var prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("user");
    if(data == null || data.isEmpty){
      user_name = "";
      user_email = "";
      user_photo = "";
      user_id = "";
    }else{
      user_name = data[0];
      user_email = data[1];
      user_photo = data[2];
      user_id = data[3];
    }
  }
}
