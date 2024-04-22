import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raks_pay_admin/src/ui/reviews/widgets/edit_dialog.dart';

import '../../../controllers/reviews/reviews_controller.dart';
import '../../../data/models/reviews/review_model.dart';
import '../../theme/app_colors.dart';

class AddDialogWidget extends GetWidget<ReviewsController> {
  const AddDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Material(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: Get.height * 0.8,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Add Review",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Obx(
                                    () {
                                      return controller.selectedImage.value !=
                                              null
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage: FileImage(
                                                controller.selectedImage.value!,
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.grey[100],
                                            );
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.selectImage();
                                    },
                                    icon: Icon(
                                      Icons.image,
                                      color: Colors.grey[300],
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                hintText: 'Enter Main text',
                                controller: controller.mainTextController,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                hintText: 'Enter rest of the title',
                                controller: controller.titleTextController,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                hintText: 'Enter description text',
                                controller:
                                    controller.descriptionTextController,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                hintText: 'Enter customer name',
                                controller: controller.usernameTextController,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                hintText: 'Enter from country',
                                controller: controller.fromTextController,
                              ),
                              const SizedBox(height: 800),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            controller.addReview();
                          },
                          child: const Text("Add review"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
