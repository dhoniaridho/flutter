import 'package:employee/app/controllers/home.controller.dart';
import 'package:employee/app/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditContact extends StatefulWidget {
  const EditContact({Key? key, required int this.id}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
  final int id;
}

class _EditContactState extends State<EditContact> {
  var _name = TextEditingController();
  var _phone = TextEditingController();
  var _email = TextEditingController();
  var _address = TextEditingController();
  var _website = TextEditingController();
  var _job = TextEditingController();


  HomeController _homeController = HomeController();

  void onSave() async {
    var data = Map.from({
      'name': _name.text,
      'phone': _phone.text,
      'email': _email.text,
      'address': _address.text,
      'website': _website.text,
      'job': _job.text,
    });
    try {
      await _homeController.createUser(data);
      Get.back();
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    _homeController.fetchUser(widget.id);
    _homeController.user.listen((user) {
      _name.text = user.firstName!;
      _email.text = user.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(_name.value.text),
        actions: [
          Container(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onSave,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Save'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    InputWidget(
                      label: 'Name',
                      controller: _name,
                    ),
                    InputWidget(
                      label: 'Office',
                      controller: _job,
                    ),
                    InputWidget(
                      label: 'Phone Number',
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                    ),
                    InputWidget(
                      label: 'Email',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    InputWidget(
                      label: 'Website',
                      controller: _website,
                      keyboardType: TextInputType.url,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget(
      {Key? key,
      TextEditingController? this.controller,
      required String this.label,
      TextInputType? this.keyboardType})
      : super(key: key);

  final controller;
  final label;
  final keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              label: Text(label),
              icon: Icon(
                Icons.person,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
