import 'dart:async';

import 'package:afisha_admin_panel/network/models/user_category_model.dart';
import 'package:afisha_admin_panel/repo/repo.dart';
import 'package:afisha_admin_panel/utils/States.dart';
import 'package:afisha_admin_panel/utils/failure.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserCategoryController extends GetxController {
  bool typing = false;
  String searchId = 'users_search_id';
  String id = 'users_category_id';
  String addId = 'users_category_id';
  TextEditingController searchController = TextEditingController();
  TextEditingController addController = TextEditingController();
  RefreshController smartRefController =
      RefreshController(initialRefresh: false);
  late Repo repo;
  States state = States.initial;
  States addState = States.initial;
  List<UserCategoryModel> list = [];
  Timer? debounce;

  UserCategoryController({required this.repo}) {
    loadCategory();
    searchController.addListener(() async {
      if (searchController.text.isEmpty) return;
      if (debounce != null) {
        debounce?.cancel();
      }
      debounce = Timer(const Duration(seconds: 2), () {
        loadCategory();
      });
    });
  }

  loadCategory() async {
    updateUI(States.loading);
    list.clear();
    await repo.getUserCategories().fold((left) {
      smartRefController.refreshCompleted();
      updateUI(left);
    }, (right) {
      smartRefController.refreshCompleted();
      list.clear();
      if (right.isEmpty) {
        updateUI(States.empty);
        return;
      }
      if (typing && searchController.text.isNotEmpty) {
        String search = searchController.text.toString();
        for (var element in right) {
          if (element.name?.contains(search) ?? false) {
            list.add(element);
          }
        }
        updateUI(States.loaded);
      } else {
        list.addAll(right);
        updateUI(States.loaded);
      }
    });
  }

  void onEditItem(int id) {}

  updateUI(States states) async {
    state = states;
    update([id]);
  }

  void onSearchPressed() async {
    typing = !typing;
    if (!typing) {
      searchController.clear();
      loadCategory();
    }
    update([searchId]);
  }

  Future<States> onSavedPressed() async {
    if (addController.text.isNotEmpty) {
      return await repo.addUserCategory(addController.text.toString());
    }
    return States.empty;
  }

  Future<States> onDeletePressed(int id) async {
    updateAdd(States.loading);
    final res = await repo.deleteUserCategory(id);
    if (res == States.loaded) {
      loadCategory();
    }
    updateAdd(res);
    return res;
  }

  updateAdd(States states) {
    addState = states;
    update([addId]);
  }
}
