import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raks_pay_admin/src/controllers/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.transactions.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                controller.transactions[index].email,
              ),
              subtitle: Text(
                controller.transactions[index].toCountry,
              ),
            ),
          );
        },
      ),
    );
  }
}
