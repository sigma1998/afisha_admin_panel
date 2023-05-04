import 'package:afisha_admin_panel/network/models/adds_model.dart';
import 'package:afisha_admin_panel/network/models/product_categories.dart';
import 'package:afisha_admin_panel/network/models/user_category_model.dart';
import 'package:afisha_admin_panel/network/models/user_personel_model.dart';
import 'package:afisha_admin_panel/network/network_info.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import '../utils/States.dart';

class Repo {
  late Dio dio;
  NetworkInfo networkInfo;

  Repo({required this.dio, required this.networkInfo});

  Future<Either<States, List<UserCategoryModel>>> getUserCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.get('/api/mobile/admin/users-categories');
        if (res.data != null) {
          final data = res.data['data'];
          final list = data.map<UserCategoryModel>((e) {
            return UserCategoryModel.fromJson(e);
          }).toList();
          return Right(list);
        }
        if (res.statusCode == 401) {
          return const Left(States.unAuthorizedError);
        }
        return const Left(States.error);
      } catch (e) {
        return const Left(States.error);
      }
    } else {
      return const Left(States.networkError);
    }
  }

  Future<States> deleteUserCategory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.delete('/api/mobile/admin/users-categories/$id');
        if (res.data != null) {
          if (res.statusCode! >= 200 && res.statusCode! < 300) {
            return States.loaded;
          } else if (res.statusCode == 401) {
            return States.unAuthorizedError;
          } else {
            return States.error;
          }
        }
        if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<States> addUserCategory(String str) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio
            .post('/api/mobile/admin/users-categories', data: {'name': str});
        if (res.data != null) {
          if (res.statusCode! >= 200 && res.statusCode! < 300) {
            return States.loaded;
          } else if (res.statusCode == 401) {
            return States.unAuthorizedError;
          } else {
            return States.error;
          }
        }
        if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<Either<States, List<UserPersonalModel>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.get('/api/mobile/admin/users');
        if (res.data != null) {
          final data = res.data['users'];
          final list = data.map<UserPersonalModel>((e) {
            return UserPersonalModel.fromJson(e);
          }).toList();
          return Right(list);
        }
        if (res.statusCode == 401) {
          return const Left(States.unAuthorizedError);
        }
        return const Left(States.error);
      } catch (e) {
        return const Left(States.error);
      }
    } else {
      return const Left(States.networkError);
    }
  }

  Future<States> deleteUsers(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.delete('/api/mobile/admin/users/$id');
        if (res.data != null) {
          if (res.statusCode! >= 200 && res.statusCode! < 300) {
            return States.loaded;
          } else {
            return States.error;
          }
        }
        if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<States> updateUsers(UserPersonalModel model) async {
    if (await networkInfo.isConnected) {
      try {
        final data = {
          'status': model.status,
          'blocked': model.blocked == 'Unblocked' ? 0 : 1
        };
        final res =
            await dio.delete('/api/mobile/admin/users/${model.id}', data: data);
        if (res.data != null) {
          if (res.statusCode! >= 200 && res.statusCode! < 300) {
            return States.loaded;
          } else {
            return States.error;
          }
        }
        if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<Either<States, List<ProductCategoriesModel>>>
      getProductCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.get('/api/mobile/admin/categories');
        if (res.data != null) {
          final data = res.data['data'];
          final list = data.map<ProductCategoriesModel>((e) {
            return ProductCategoriesModel.fromJson(e);
          }).toList();
          return Right(list);
        }
        if (res.statusCode == 401) {
          return const Left(States.unAuthorizedError);
        }
        return const Left(States.error);
      } catch (e) {
        return const Left(States.error);
      }
    } else {
      return const Left(States.networkError);
    }
  }

  Future<States> deleteProductCategories(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.delete('/api/mobile/admin/categories/$id');
        if (res.data != null) {
          if (res.statusCode! >= 200 && res.statusCode! < 300) {
            return States.loaded;
          } else {
            return States.error;
          }
        }
        if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<States> addProductCategory(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio
            .post('/api/mobile/admin/categories', data: {'name': name});
        if (res.data != null) {
          if (res.statusCode! >= 200 && res.statusCode! < 300) {
            return States.loaded;
          } else {
            return States.error;
          }
        }
        if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<Either<States, List<AddsModel>>> getAdds() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.get('/api/mobile/admin/reklama');
        if (res.data != null) {
          final data = res.data['data'];
          final list = data.map<AddsModel>((e) {
            return AddsModel.fromJson(e);
          }).toList();
          return Right(list);
        }
        if (res.statusCode == 401) {
          return const Left(States.unAuthorizedError);
        }
        return const Left(States.error);
      } catch (e) {
        return const Left(States.error);
      }
    } else {
      return const Left(States.networkError);
    }
  }

  Future<States> createAdds(AddsModel model) async {
    if (await networkInfo.isConnected) {
      try {
        final images = model.newImages?.map((e) {
          return MultipartFile.fromFile(e.path);
        }).toList();
        final map = {'images[]': images, 'category_id': model.category};
        final res = await dio.post('/api/mobile/admin/reklama', data: map);
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          return States.loaded;
        } else if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<States> updateAdds(AddsModel model) async {
    if (await networkInfo.isConnected) {
      try {
        final images = [];

        model.newImages?.forEach((element) async {
          await MultipartFile.fromFile(element.path).then((value) {
            images.add(value);
          });
        });
        print(images);
        final map = {'images[]': images, 'category_id': model.category};
        final res =
            await dio.post('/api/mobile/admin/reklama/${model.id}', data: map);
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          return States.loaded;
        } else if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }

  Future<States> deleteAdds(AddsModel model) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.delete('/api/mobile/admin/reklama/${model.id}');
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          return States.loaded;
        } else if (res.statusCode == 401) {
          return States.unAuthorizedError;
        }
        return States.error;
      } catch (e) {
        return States.error;
      }
    } else {
      return States.networkError;
    }
  }
}
