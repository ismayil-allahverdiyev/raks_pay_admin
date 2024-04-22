import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/reviews/reviews_controller.dart';
import '../../../data/models/reviews/review_model.dart';
import '../../theme/app_colors.dart';

class EditDialogWidget extends GetWidget<ReviewsController> {
  const EditDialogWidget({
    super.key,
    required this.review,
  });

  final ReviewModel review;

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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Edit Review",
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
                          return controller.selectedImage.value != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(
                                    controller.selectedImage.value!,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(review.image),
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
                    hintText: 'Edit Main text',
                    controller: controller.mainTextController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'Edit rest of the title',
                    controller: controller.titleTextController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'Edit description text',
                    controller: controller.descriptionTextController,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      controller.updateReview(review.id, review);
                    },
                    child: const Text("Update"),
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: whiteColor,
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: whiteColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: whiteColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
