class Users {
  late int id  ,
           orders_id;
  late String password , 
              email  ;

  Users({
    required this.email , 
    required this.id ,
    required this.password ,
    this.orders_id= 0 
  }) ;
}