void main () {
  var girlFriends = <String>[];
  var numbers = [1, 2, 3, 4, 5, 6];
  //đây gọi là một list
  numbers.add(100);
  //thêm 100 vào list 'numbers'
  //numbers.add(2.36);
  //numbers.add('Toan'); ==> sẽ báo lỗi do list của kiểu nào thì chỉ chứa được kiểu đó
  var friends = ['Toan', 'Truong', 'Loi', 'Khoa', 'Dat'];
  friends.add('Tùng');
  print('Số lượng phần tử có trong numbers: ${numbers.length}');
  print('Phần tử đầu tiên ở trong list: numbers[0]: ${numbers[0]}');
  print('Phần tử cuối cùng ở trong list: numbers[length - 1]: ${numbers[numbers.length - 1]}');
  //'numbers.length': là số lượng phần từ còn lại (kích thước của cái list đó)
}