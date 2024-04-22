import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raks_pay_admin/src/ui/theme/app_colors.dart';
import '../../controllers/rates/rates_controller.dart';
import 'widgets/edit_dialog_widget.dart';

class RatesPage extends GetView<RatesController> {
  const RatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Rates",
          style: TextStyle(
            color: whiteColor,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.rates.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  controller.rates[index].type,
                  style: const TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  controller.rates[index].value.toString(),
                  style: const TextStyle(
                    color: whiteColor,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Get.dialog(
                      EditDialogWidget(
                        type: controller.rates[index].type,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
