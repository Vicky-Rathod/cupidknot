import 'package:cupidknotproject/model/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import '../core/viewmodel/contact_viewmodel.dart';
import '../core/viewmodel/home_viewmodel.dart';
import 'widgets/custom_text.dart';
import '../constants.dart';

class SearchView extends StatefulWidget {
  final String? searchValue;

  SearchView(this.searchValue);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String? _searchValue;

  @override
  void initState() {
    _searchValue = widget.searchValue!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ContactModel> _contact = _searchValue == ''
        ? []
        : Get.find<HomeViewModel>()
            .contacts
            .where(
                (product) => product.name.toLowerCase().contains(_searchValue!))
            .toList();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130.h,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Search',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
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
                initialValue: _searchValue,
                onFieldSubmitted: (value) {
                  setState(() {
                    _searchValue = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
              child: GetBuilder<HomeViewModel>(
                init: Get.find<HomeViewModel>(),
                builder: (controller) => ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: _contact.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 164.w,
                      child:GFListTile(
                          titleText:'${controller.contacts[index].name}',
                          subTitleText:'${controller.contacts[index].contact_number}',
                          icon: Icon(Icons.delete)
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
