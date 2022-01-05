import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateStatusController extends GetxController {
  late TextEditingController statusC = TextEditingController();

  @override
  void onInit() {
    // statusC
    super.onInit();
  }

  @override
  void onClose() {
    statusC.dispose();
    super.onClose();
  }
}
