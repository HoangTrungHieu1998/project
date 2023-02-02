class User {
    String? password;
    String? username;

    User({this.password, this.username});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            password: json['password'], 
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['password'] = password;
        data['username'] = username;
        return data;
    }
}