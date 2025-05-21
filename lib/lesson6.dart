void main () {
  var numbers = [1, 2, 3, 4, 5, 6];
  var friends = ['Toan, Hung, Ly, Tai, Cong, Lien'];
  numbers.add(100);
  numbers.add(500);
  numbers.insert(2, 200);
  //thêm phần tử 200 vào vị trí số 2
  friends.add('Linh');


  //for loop
  //cập nhật các phần tử trong list
  print('==> Danh sách chỉ số và giá trị phần tử tại chỉ số đang xét: ');
  for (var index = 0; index < numbers.length; index++) {
    numbers[index] *= 2;
  } 
  for (var index =0; index< numbers.length; index++) {
    print('$index : ${numbers[index]}');
  }
}