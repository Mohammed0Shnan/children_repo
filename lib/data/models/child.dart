class Child {
  final int id;
  final String name;
  final double points;
  final String gender;
  final String dob;

  Child({this.id,this.name,this.points,this.gender,this.dob});

  Child.fromJson(Map<String, dynamic> json):
  this.id = json['id'],
  this.name = json['name'],
  this.points = json['points']*1.0,
  this.gender = json['gender'],
  this.dob = json['DOB']
  ;

}