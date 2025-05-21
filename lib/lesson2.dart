void main (){
  var a = 100;
  var b = 250;
  print('$a + $b = ${a + b}');
  //Gõ cú pháp Shift + Alt + phím mũi tên xuống để nhân bản một dòng xuống
  print('$a - $b = ${a - b}');
  print('$a * $b = ${a * b}');
  print('$a / $b = ${a / b}');
  print('$a ~/ $b = ${a ~/ b}'); //muốn lấy phần nguyên của phép chia thì dùng dấu "~" phía trước dấu chia
  print('$a % $b = ${a % b}'); // chia lấy phần dư thì dùng dấu "%"

  //đây là 1 chú thích trên 1 dòng
  /*
  đây là chú thích trên nhiều 
  dòng*/
  // "Crtl + //" cú pháp chú thích một dòng
  // nếu muốn bỏ thì ngược lại

  bool isCorrect  = true; //false
  int m;
  int? x; //default: null
  print(x?.isEven);
}