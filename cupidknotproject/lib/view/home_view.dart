import 'package:cupidknotproject/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';

import '../core/viewmodel/home_viewmodel.dart';
import 'contact/add_contact_view.dart';
import 'widgets/custom_text.dart';
import '../../constants.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<HomeViewModel>(
        init: Get.find<HomeViewModel>(),
        builder: (controller) => controller.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: 65.h, bottom: 14.h, right: 16.w, left: 16.w),
                child: Column(
                  children: [
                    Container(
                      height: 49.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(45.r),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          Get.to(SearchView(value));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    CustomText(
                      text: 'Contacts',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),


                    SizedBox(
                      height: 30.h,
                    ),
                    ListViewContacts(),
                    GFFloatingWidget(
                      child: GFIconButton(
                        shape:GFIconButtonShape.circle ,
                        size: GFSize.LARGE,
                        icon: Icon(Icons.add),
                        onPressed: (){
                          Get.to(AddContactView());
                        },
                      ),

                      verticalPosition: MediaQuery.of(context).size.height* 0.15,
                      horizontalPosition: MediaQuery.of(context).size.width* 0.75,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}



class ListViewContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 320.h,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Get.to(
                //   ProductDetailView(controller.products[index]),
                // );
              },
              child: Container(
                width: 164.w,
                child:GFListTile(
                    titleText:'${controller.contacts[index].name}',
                    subTitleText:'${controller.contacts[index].contact_number}',
                    icon: Icon(Icons.delete)
                ),

              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 15.w,
            );
          },
        ),
      ),
    );
  }
}
