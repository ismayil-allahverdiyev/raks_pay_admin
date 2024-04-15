import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raks_pay_admin/src/data/models/reviews/review_model.dart';
import 'package:raks_pay_admin/src/data/models/transaction/transaction_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/repository/repository.dart';

class ReviewsController extends GetxController {
  final Repository repository;
  ReviewsController({required this.repository});

  var store = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  var reviews = <ReviewModel>[].obs;

  var selectedImage = Rxn<File>();
  var mainTextController = TextEditingController();
  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getReviews();
  }

  getReviews() async {
    await store.collection('reviews').get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            reviews.add(
              ReviewModel.fromJson(
                {
                  'id': doc.id,
                  ...doc.data() as Map<String, dynamic>,
                },
              ),
            );
          }
        }
      },
    );
    reviews.sort((a, b) => a.date.compareTo(b.date));
    reviews = reviews.reversed.toList().obs;
    reviews.refresh();
  }

  selectImage() async {
    selectedImage.value = await repository.selectImage();
  }

  updateReview(String id, String imageUrl) async {
    var image;
    if (selectedImage.value != null)
      image =
          await storageRef.child('reviews/$id').putFile(selectedImage.value!);

    var data = {
      'main': mainTextController.text,
      'title': titleTextController.text,
      'description': descriptionTextController.text,
      'image': selectedImage.value != null
          ? await image.ref.getDownloadURL()
          : imageUrl,
    };

    await store.collection('reviews').doc(id).update(data);

    reviews.clear();

    await getReviews();
  }
}
