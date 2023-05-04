import 'package:afisha_admin_panel/controllers/adds_detail/adds_detail_controller.dart';
import 'package:afisha_admin_panel/controllers/advertisment/adds_controller.dart';
import 'package:afisha_admin_panel/ui/widgets/progres_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/routes/app_routes.dart';
import '../../../utils/States.dart';
import '../../../utils/size_config.dart';
import '../../../values/colors.dart';

class AddsDetailScreen extends StatelessWidget {
  AddsDetailScreen({super.key});

  final controller = Get.find<AddsDetailController>();
  final addsController = Get.find<AddsController>();

  _check() {
    if (controller.state == States.unAuthorizedError) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getRow('id:', controller.data.id.toString()),
            getRow('category:', controller.data.category ?? '--------'),
            getList(),
            SizedBox(
              height: 150,
              child: Row(
                children: [getHorList()],
              ),
            ),
            getText(),
            SizedBox(
              height: 150,
              child: Row(
                children: [getExistingPictures()],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            getSaveBtn()
          ],
        ),
      ),
    );
  }

  getAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: AppColors.white,
      leadingWidth: 55,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      )),
      leading: SizedBox(
        width: SizeConfig.calculateHorizontal(30),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Advertisement',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.black),
          ),
        ],
      ),
      actions: const [
        //getPopUp(),
        SizedBox(
          width: 16,
        )
      ],
    );
  }

  getPopUp() {
    return PopupMenuButton(
        color: AppColors.black,
        onSelected: (val) async {},
        itemBuilder: (_) {
          return [
            PopupMenuItem(
              onTap: () async {
                await controller.onDeletePressed().then((value) {
                  if (value == States.loaded) {
                    addsController.loadAdds();
                    Get.back();
                  }
                });
              },
              value: 0,
              child: const Text(
                'Delete',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ];
        });
  }

  getRow(String str, String des) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            str,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          Expanded(
            child: Text(
              des,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              controller.onAddPressed();
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: AppColors.black)),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///list for new images
  getHorList() {
    return GetBuilder(
        init: controller,
        id: controller.newImageID,
        builder: (context) {
          return Expanded(
            child: controller.data.newImages?.isEmpty ?? true
                ? const Center(
                    child: Text(
                      'no new picture',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.data.newImages?.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(color: AppColors.black),
                              image: DecorationImage(
                                  image: FileImage(
                                      controller.data.newImages![index]),
                                  fit: BoxFit.fill)),
                        ),
                      );
                    }),
          );
        });
  }

  getText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          'Existing pictures : ',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

  getExistingPictures() {
    return Expanded(
      child: controller.data.images?.isEmpty ?? false
          ? const Center(
              child: Text(
                'no picture',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.data.images?.length ?? 0,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: AppColors.black),
                        image: DecorationImage(
                            image: NetworkImage(controller.data.images![index]),
                            fit: BoxFit.fill)),
                  ),
                );
              }),
    );
  }

  getSaveBtn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder(
          init: controller,
          id: controller.saveID,
          builder: (context) {
            _check();
            return InkWell(
              onTap: () async {
                final res = await controller.onSavePressed();
                if (res == States.loaded) {
                  Get.back();
                  addsController.loadAdds();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: controller.state == States.loading
                    ? const CustomProgressIndicator()
                    : const Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400),
                      ),
              ),
            );
          }),
    );
  }
}
