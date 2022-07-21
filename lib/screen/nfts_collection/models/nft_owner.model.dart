class NFTOwnerModel {
  final String username;
  final String address;
  final String profile_img_url;
  NFTOwnerModel.jsonToObject(Map<String, dynamic> json)
      : address = json["address"] ?? "--",
        profile_img_url = json["profile_img_url"] ??
            "https://lh3.googleusercontent.com/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE=s120",
        // username = checkForUser(json["user"]);
        username = json["user"]["username"] ?? "--";

  static checkForUser(dynamic json) {
    try {
      return json["username"];
    } on NoSuchMethodError {
      return "--";
    } on TypeError {
      return "--";
    } catch (e) {
      return "--";
    } finally {
      return "--";
    }
  }
}
