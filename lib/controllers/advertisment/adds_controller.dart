import 'package:afisha_admin_panel/repo/repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:afisha_admin_panel/utils/States.dart';


import '../../network/models/adds_model.dart';

class AddsController extends GetxController {
  late Repo repo;
  String searchId = 'add_screen_search_id';
  String id = 'add_screen_id';
  TextEditingController searchController = TextEditingController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  bool typing = false;
  States state = States.initial;
  List<AddsModel> list = [];

  AddsController({required this.repo}){
    loadAdds();
  }

  loadAdds() async {
    updateUI(States.loading);
    await repo.getAdds().fold((left) {
      refreshController.refreshCompleted();
      updateUI(left);
    }, (right) {
      refreshController.refreshCompleted();
      if(right.isEmpty) {
        updateUI(States.empty);
      }else {
        list.clear();
        list.addAll(right);
        updateUI(States.loaded);
      }
    });
  }

  void onSearchPressed() {
    typing = !typing;
    if (!typing) {
      searchController.clear();
    }
    update([searchId]);
  }

  updateUI(States states) {
    state = states;
    update([id]);
  }

  onDeletePressed(int id) {

  }
}
