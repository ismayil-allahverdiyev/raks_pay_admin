import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raks_pay_admin/src/controllers/rates/rates_controller.dart';
import 'package:raks_pay_admin/src/data/models/rates/rates_model.dart';
import 'package:raks_pay_admin/src/ui/reviews/widgets/edit_dialog.dart';

import '../../../controllers/reviews/reviews_controller.dart';
import '../../../data/models/reviews/review_model.dart';
import '../../theme/app_colors.dart';

class EditDialogWidget extends GetWidget<RatesController> {
  final String type;
  const EditDialogWidget({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Material(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Edit $type",
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Enter new value',
                    controller: controller.newValueController,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      controller.updateRate(
                        RatesModel(
                          type: type,
                          value:
                              double.parse(controller.newValueController.text),
                        ),
                      );
                    },
                    child: const Text("Edit rate"),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
