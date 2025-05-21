import 'dart:io';
import 'dart:convert';

void main (){
  print('Họ và tên bạn là gì?');
  var fullName = stdin.readLineSync(encoding: utf8)!; 
  //kHÔNG Null thì cho dấu chấm than ở cuối, encoding: utf8 là phần tử để check đúng tiếng việt
  print('Bạn bao nhiêu tuổi?');
  var age = int.parse(stdin.readLineSync()!);
  print('Điểm gpa của bạn là bao nhiêu?');
  var gpa = double.parse(stdin.readLineSync()!);
  //Hiện kết quả input nhập vào từ bàn phím:
  print('==> Thông tin người dùng <==');
  print('Xin chào "$fullName"!');
  print('Năm nay bạn $age tuổi');
  print('Điểm gpa hiện tại của bạn là: ${gpa.toStringAsFixed(2)}');
  //${gpa.toStringAsFixed(2)}: là điểm số được làm tròn đến 2 chữ số thập phân, xử lý nhiều phần từ để trong dấu ngoặc nhọn
}