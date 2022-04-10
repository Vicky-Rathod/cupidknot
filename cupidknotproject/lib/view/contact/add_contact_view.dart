import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/viewmodel/contact_viewmodel.dart';
import '../../core/viewmodel/selectImage_viewmodel.dart';
import '../../core/viewmodel/profile_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/custom_button.dart';

class AddContactView extends StatefulWidget {
  @override
  _AddContactViewState createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {


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
                    text: 'Add Contact',
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
        GetBuilder<ContactViewModel>(

          init: ContactViewModel(),
        builder: (controller) =>
  Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                      EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [

                                SizedBox(
                                  height: 38.h,
                                ),
                                CustomTextFormField(
                                  title: 'Name',
                                  hintText: "Add Contact Name",

                                  validatorFn: (value) {
                                    if (value!.isEmpty || value.length < 4)
                                      return 'Please enter valid name.';
                                  },
                                  onSavedFn: (value) {
                                    Get.find<ContactViewModel>().name = value;
                                  }, enable: true,
                                ),
                                SizedBox(
                                  height: 38.h,
                                ),
                                Column(
                                  children: [
                                    CustomTextFormField(
                                      enable: true,
                                      title: 'Email',
                                      hintText: "Add Contact Email",
                                      keyboardType:
                                      TextInputType.emailAddress,
                                      validatorFn: (value) {
                                        if (value!.isEmpty)
                                          return 'Please enter valid email address.';
                                      },
                                      onSavedFn: (value) {
                                        Get.find<ContactViewModel>().email =
                                            value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 38.h,
                                    ),
                                    CustomTextFormField(
                                      enable: true,
                                      title: 'Mobile No',
                                      hintText: "Add Mobile",
                                      keyboardType:
                                      TextInputType.emailAddress,
                                      validatorFn: (value) {
                                        if (value!.isEmpty)
                                          return 'Please enter valid mobile number.';
                                      },
                                      onSavedFn: (value) {
                                        Get.find<ContactViewModel>().mobile_no =
                                            value;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                _isLoading
                                    ? CircularProgressIndicator()
                                    : CustomButton(
                                  'SUBMIT',
                                      () async {
                                    if (_formKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      _formKey.currentState!.save();
                                      await controller.addContactToFirestore();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),


        ],
      ),
    );
  }
}
