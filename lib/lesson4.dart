import 'dart:io';

void main () {
  int x = 120;
  print('Nhập vào giá trị k');
  var k = int.parse(stdin.readLineSync()!);
  if(x % k == 0) {//conditions true
    print('$x chia hết cho $k');
    //do something
  } else {//conditions false
    print('$x không chia hết cho $k'); 
    //do other things
  }
}