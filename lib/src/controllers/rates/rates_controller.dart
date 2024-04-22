import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raks_pay_admin/src/data/models/rates/rates_model.dart';
import 'package:raks_pay_admin/src/data/models/reviews/review_model.dart';
import 'package:raks_pay_admin/src/data/models/transaction/transaction_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import '../../data/repository/repository.dart';

class RatesController extends GetxController {
  final Repository repository;
  RatesController({required this.repository});

  var store = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  var rates = <RatesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRates();
  }

  var newValueController = TextEditingController();

  getRates() async {
    await store.collection('general').doc("currency_info").get().then(
      (DocumentSnapshot doc) {
        var data = doc.data() as Map<String, dynamic>;
        rates.add(RatesModel(
          type: "kes_to_tl",
          value: doc['kes_to_tl'],
        ));
        rates.add(RatesModel(
          type: "tzs_to_tl",
          value: data['tzs_to_tl'],
        ));
        rates.add(RatesModel(
          type: "ugx_to_tl",
          value: data['ugx_to_tl'],
        ));
        rates.add(RatesModel(
          type: "tl_to_kes",
          value: data['tl_to_kes'],
        ));
        rates.add(RatesModel(
          type: "tl_to_tzs",
          value: data['tl_to_tzs'],
        ));
        rates.add(RatesModel(
          type: "tl_to_ugx",
          value: data['tl_to_ugx'],
        ));
      },
    );
    rates.refresh();
  }

  updateRate(RatesModel rate) async {
    var final_rates = {
      for (var item in rates)
        item.type: item.type == rate.type ? rate.value : item.value,
    };

    await store.collection('general').doc("currency_info").update(final_rates);

    Get.back();
    rates.clear();
    await getRates();
  }
}
