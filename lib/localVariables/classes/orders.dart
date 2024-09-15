class orders {
  late int id ;
  late String productName , photoUrl;
  late double price , total;

  late List <Map> orderList =[{
    "productName ": this.productName ,
    "id" : this.id ,
    "price" : this.price ,
    "photoUrl" : this.photoUrl ,
    
 } ] ;
double  totalSum()  {
  this.total= 0 ;
  for (int i =0 ; i< this.orderList.length ; i++)
  {
    this.total+= this.orderList[i]["price"] ; 
  }
return total;
 }
 orders({
  required this.id,
  required this.orderList,
  required this.photoUrl,
  required this.price,
  required this.productName,
 }) ;
}