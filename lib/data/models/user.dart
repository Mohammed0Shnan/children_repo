class User{
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;
  User({this.id,this.name,this.email,this.password,this.token});
 Map<String ,dynamic> toJson(){
    Map<String ,dynamic> map =Map();
    map['name']=this.name;
    map['email']=this.email;
    map['password']=this.password;
  return map;
  }
  
}