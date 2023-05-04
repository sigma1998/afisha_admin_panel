import 'package:afisha_admin_panel/repo/repo.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../network/models/user_personel_model.dart';
import '../../utils/States.dart';

class UserDetailController extends GetxController {
  Repo repo;
  States state = States.initial;
  String id = 'detail_screen_id';
  RefreshController refreshController = RefreshController(initialRefresh: false);

  late UserPersonalModel model;

  UserDetailController({required this.repo}) {
    model = Get.arguments;
  }

  Future<States> onDeletePressed() async {
    return await repo.deleteUsers(model.id ?? 0);
  }

  void onSavePressed() async {
    if(state == States.loading) return;
    updateUi(States.loading);
    await repo.updateUsers(model).then((value) {
      updateUi(value);
    }, onError: (e) {
      updateUi(States.error);
    });
  }

  updateUi(States states) {
    state = states;
    update([id]);
  }

  void setInitial() {
    updateUi(States.initial);
  }
}
