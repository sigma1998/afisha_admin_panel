import 'dart:async';

import 'package:afisha_admin_panel/network/models/user_personel_model.dart';
import 'package:afisha_admin_panel/repo/repo.dart';
import 'package:afisha_admin_panel/utils/States.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersController extends GetxController {
  late Repo repo;
  bool typing = false;
  String searchId = 'user_search_id';
  String id = 'user_screen_id';
  TextEditingController searchController = TextEditingController();
  RefreshController smartRefController =
      RefreshController(initialRefresh: false);
  States state = States.initial;
  List<UserPersonalModel> list = [];
  Timer? debounce;

  UsersController({required this.repo}) {
    searchController.addListener(() {
      if (debounce != null) {
        debounce?.cancel();
      }
      debounce = Timer(const Duration(seconds: 2), () {
        loadUsers();
      });
    });
    loadUsers();
  }

  loadUsers() async {
    updateUI(States.loading);
    list.clear();
    await repo.getUsers().fold((left) {
      smartRefController.refreshCompleted();
      updateUI(left);
    }, (right) {
      if (right.isEmpty) {
        updateUI(States.empty);
      } else {
        if (typing && searchController.text.isNotEmpty) {
          final search = searchController.text.toString();
          for (var element in right) {
            if (element.fullname?.contains(search) ?? false) {
              list.add(element);
            }
          }
        } else {
          list.addAll(right);
        }
        smartRefController.refreshCompleted();
        updateUI(States.loaded);
      }
    });
  }

  void onSearchPressed() {
    typing = !typing;
    if(!typing) {
      searchController.clear();
      loadUsers();
    }
    update([searchId]);
  }

  updateUI(States states) {
    state = states;
    update([id]);
  }
}
