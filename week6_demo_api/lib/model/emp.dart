class Emp{

  final String id;
  final String first_name;
  final String last_name;
  final String email_address;
  final String imgUrl;
  Emp(
      this.id,
      this.first_name,
      this.last_name,
      this.email_address,
      this.imgUrl,
      );
  factory Emp.fromMap(Map<String,dynamic>json){
    return Emp(json['id'],json['first_name'],json['last_name'],json['email_address'],json['imgUrl']);
  }
  factory Emp.fromJson(Map<String,dynamic>json){
    return Emp(json['id'],json['first_name'],json['last_name'],json['email_address'],json['imgUrl']);
  }
}