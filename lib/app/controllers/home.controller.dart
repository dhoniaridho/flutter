import 'package:employee/app/models/user.model.dart';
import 'package:employee/app/services/home.service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeService _homeService = Get.put(HomeService());

  RxList<User> users = RxList<User>();
  Rx<User> user = Rx<User>(User());
  
  fetchAllUsers() async {
    var users = await _homeService.getAll();
    this.users.value = users;
  }
  fetchUser(int id) async {
    var user = await _homeService.getDetail(id);
    this.user.value = user;
  }
  createUser(value) {
    _homeService.create(value);
  }
}