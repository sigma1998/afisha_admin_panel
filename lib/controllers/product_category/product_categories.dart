import 'dart:async';

import 'package:afisha_admin_panel/network/models/product_categories.dart';
import 'package:afisha_admin_panel/utils/States.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../repo/repo.dart';

class ProductCategoriesController extends GetxController {
  Repo repo;
  final String searchId = 'p_c_search_id123';
  final String id = 'p_c_id123';
  final String addId = 'p_c_id123';
  TextEditingController searchController = TextEditingController();
  TextEditingController addController = TextEditingController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool typing = false;
  States state = States.initial;
  States addState = States.initial;
  List<ProductCategoriesModel> list = [];
  Timer? debounce;

  ProductCategoriesController({required this.repo}) {
    searchController.addListener(() {
      if (debounce != null) {
        debounce?.cancel();
      }
      debounce = Timer(const Duration(seconds: 2), () {
        loadCategories();
      });
    });
    loadCategories();
  }

  loadCategories() async {
    list.clear();
    updateUI(States.loading);
    await repo.getProductCategories().fold((left) {
      print('LEFT $left');
      if (refreshController.isRefresh) {
        refreshController.refreshCompleted();
      }
      updateUI(left);
    }, (right) {
      print('RIGHT ${right.length}');
      if (refreshController.isRefresh) {
        refreshController.refreshCompleted();
      }
      if (right.isEmpty) {
        updateUI(States.empty);
      } else {
        if (typing && searchController.text.isNotEmpty) {
          final search = searchController.text.toString();
          for (var element in right) {
            if (element.name?.contains(search) ?? false) {
              list.add(element);
            }
          }
          print("LIST 1 $list");
        } else {
          list.addAll(right);
          print("LIST 2 $list");
        }
        updateUI(States.loaded);
      }
    });
  }

  void onSearchPressed() {
    typing = !typing;
    if (!typing) {
      searchController.clear();
      loadCategories();
    }
    update([searchId]);
  }

  updateUI(States states) {
    state = states;
    update([id]);
  }

  Future<States> onDeletePressed(int id) async {
    updateAdd(States.loading);
    final res = await repo.deleteProductCategories(id);
    loadCategories();
    updateAdd(res);
    return States.loaded;
  }

  Future<States> onSavedPressed() async {
    updateAdd(States.loading);
    final res = await repo.addProductCategory(addController.text.toString());
    if (res == States.loaded) {
      addController.clear();
      addController.clear();
    }
    updateAdd(res);
    return res;
  }

  updateAdd(States states) {
    addState = states;
    update([addId]);
  }
}
