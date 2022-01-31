import 'package:employee/app/controllers/home.controller.dart';
import 'package:employee/app/models/user.model.dart';
import 'package:employee/pages/add.dart';
import 'package:employee/pages/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());
  var _star = [];

  void initState() {
    super.initState();
    homeController.fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: Expanded(
            child: Obx(
          () => ListView(
            children: [
              ...homeController.users.map(
                (User user) => Container(
                  child: Contact(
                    id: user.id!,
                    name: '${user.firstName} ${user.lastName}',
                    phone: user.email.toString(),
                    avatar: user.avatar,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Get.to(AddContact());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  InkWell Contact({
    required String name,
    required String phone,
    String? avatar,
    required int id,
  }) {
    return InkWell(
      onTap: () {
        Get.to(Detail(
          id: id,
        ));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Colors.indigo,
                    image: DecorationImage(
                      image: NetworkImage(
                        avatar ??
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(phone),
                  ],
                ),
              ],
            ),
            Container(
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.star_border_outlined,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
