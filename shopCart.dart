class Meta{
  double price;
  String name;
  Meta(this.name,this.price);
}

class Item extends Meta{
  Item(name,price):super(name,price);
  Item operator+(Item item) => Item(name + item.name,price + item.price);
}

class ShoppingCart extends Meta with PrinteHelper{
  // String name;
  DateTime date;
  String code;
  List<Item> bookings;


  // price(){}
  double get price => bookings.reduce((value,element)=> value+ element).price;
  // ShoppingCart(this.name,this.code):date = DateTime.now();
  // ShoppingCart(name,this.code):date=DateTime.now(),super(name,0);

  int get count => this.bookings.length;



  // 默认初始化方法，转化到withCode里
  ShoppingCart({name}):this.withCode(name:name,code:null);


  // withCode 初始化方法，使用语法糖初始化列表进行赋值，并调用父类初始化方法
  ShoppingCart.withCode({name,this.code}):date=DateTime.now(),super(name,0);

  getInfo()=> '''
    购物车消息：
    -----------------------------
      用户名： $name
      优惠码： ${code??"没有"}
      总价： $price
      Date： $date
  ''';
}

abstract class PrinteHelper{
  printInfo()=> print(getInfo());
  getInfo();
}

void main(){
  // ShoppingCart sc = ShoppingCart.withCode(name: '张三',code: '123456');
  // sc.bookings = [Item('苹果',10.0),Item('鸭梨',20.0)];
  // print(sc.getInfo());

  // ShoppingCart sc2 = ShoppingCart(name: '李四');
  // sc2.bookings = [Item('香蕉',15.0),Item('西瓜',40.0)];
  // print(sc2.getInfo());

  ShoppingCart.withCode(name: '张三',code: '123456')
    ..bookings = [Item('苹果',10.0),Item('鸭梨',20.0)]
    ..printInfo();

  ShoppingCart(name: '李四')
    ..bookings = [Item('香蕉',10.0),Item('葡萄',20.0)]
    ..printInfo();
}
