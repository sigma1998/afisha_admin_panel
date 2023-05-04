import 'dart:io';

import 'package:afisha_admin_panel/network/models/adds_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../repo/repo.dart';
import '../../utils/States.dart';

class AddsDetailController extends GetxController {
  late AddsModel data;
  Repo repo;
  States state = States.initial;
  String newImageID = 'new_image_id';
  String saveID = 'new_image_id';

  AddsDetailController({required this.repo}) {
    data = Get.arguments;
  }

  onDeletePressed() {}

  void onAddPressed() async {
    List<XFile> file = await ImagePicker().pickMultiImage();
    if (file.isEmpty) return;
    data.newImages ??= [];
    for (var element in file) {
      data.newImages?.add(File(element.path));
    }
    update([newImageID]);
  }

  void updateUI(States states) {
    update([newImageID]);
  }

  Future<States> onSavePressed() async {
    updateUI(States.loading);
    if (data.id == null) {
      final res =  await repo.createAdds(data);
      updateUI(res);
      return res;
    } else {
      final res = await repo.updateAdds(data);
      updateUI(res);
      return res;
    }
  }

}
