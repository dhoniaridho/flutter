import 'package:employee/app/controllers/home.controller.dart';
import 'package:employee/app/models/user.model.dart';
import 'package:employee/pages/edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required int this.id}) : super(key: key);

  final id;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  HomeController homeController = Get.put(HomeController());

  void initState() {
    super.initState();
    homeController.fetchUser(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              child: Icon(Icons.edit),
              onTap: () {
                Get.to(EditContact(id: widget.id));
              },
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.star_outline),
          ],
        ),
        body: Obx(
          () => Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  backgroundBlendMode: BlendMode.darken,
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.9),
                      BlendMode.darken,
                    ),
                    image: NetworkImage(
                      homeController.user.value.avatar ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 150,
                      color: Colors.white,
                    ),
                    Text(
                      '${homeController.user.value.firstName} ${homeController.user.value.lastName}',
                      style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ContactItem(
                      value: homeController.user.value.email ?? '',
                      title: 'Email',
                      icon: Icons.email,
                    ),
                    ContactItem(
                      value: '080808',
                      title: 'Phone',
                      icon: Icons.phone,
                    ),
                    ContactItem(
                      value: homeController.user.value.email ?? '',
                      title: 'Email',
                      icon: Icons.email,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key? key,
    required String this.value,
    required String this.title,
    required IconData this.icon,
  }) : super(key: key);

  final value;
  final title;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value),
                  Text(title),
                ],
              ),
            ],
          ),
          Icon(Icons.message)
        ],
      ),
    );
  }
}
