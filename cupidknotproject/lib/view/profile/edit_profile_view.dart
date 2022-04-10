import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/viewmodel/auth_viewmodel.dart';
import '../../core/viewmodel/selectImage_viewmodel.dart';
import '../../core/viewmodel/profile_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/custom_button.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // String _loginMethod =
    //     FirebaseAuth.instance.currentUser!.providerData[0].providerId;

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
                      Get.find<AuthViewModel>().signOut();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Edit Profile',
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
          GetBuilder<SelectImageViewModel>(
            init: SelectImageViewModel(),
            builder: (controller) => Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.h),
                      child:
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 60.h,
                                        backgroundImage: AssetImage(
                                            'assets/images/profile_pic.png'),

                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.toggleFavoriteStatus();
                                          // Get.dialog(
                                          //   AlertDialog(
                                          //     title: CustomText(
                                          //       text: 'Choose option',
                                          //       fontSize: 20,
                                          //       color: Colors.blue,
                                          //     ),
                                          //     content: Column(
                                          //       mainAxisSize: MainAxisSize.min,
                                          //       children: [
                                          //         Divider(
                                          //           height: 1,
                                          //         ),
                                          //         ListTile(
                                          //           onTap: () async {
                                          //             try {
                                          //               await controller
                                          //                   .cameraImage();
                                          //               // await controller.uploadImageToFirebase();
                                          //               Get.back();
                                          //             } catch (error) {
                                          //               Get.back();
                                          //             }
                                          //           },
                                          //           title: CustomText(
                                          //             text: 'Camera',
                                          //           ),
                                          //           leading: Icon(
                                          //             Icons.camera,
                                          //             color: Colors.blue,
                                          //           ),
                                          //         ),
                                          //         Divider(
                                          //           height: 1,
                                          //         ),
                                          //         ListTile(
                                          //           onTap: () async {
                                          //             try {
                                          //               await controller
                                          //                   .galleryImage();
                                          //               // await controller.uploadImageToFirebase();
                                          //               Get.back();
                                          //             } catch (error) {
                                          //               Get.back();
                                          //             }
                                          //           },
                                          //           title: CustomText(
                                          //             text: 'Gallery',
                                          //           ),
                                          //           leading: Icon(
                                          //             Icons.account_box,
                                          //             color: Colors.blue,
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 38.h,
                                  // ),
                                  // CustomTextFormField(
                                  //   enable: controller.edit,
                                  //   title: 'User Name',
                                  //
                                  //   hintText: Get.find<ProfileViewModel>()
                                  //       .currentUser!
                                  //       .name,
                                  //   initialValue: Get.find<ProfileViewModel>()
                                  //       .currentUser!
                                  //       .name,
                                  //   validatorFn: (value) {
                                  //     if (value!.isEmpty || value.length < 4)
                                  //       return 'Please enter valid user name.';
                                  //   },
                                  //   onSavedFn: (value) {
                                  //     Get.find<ProfileViewModel>().name = value;
                                  //   },
                                  // ),


                                  SizedBox(
                                    height: 38.h,
                                  ),
                                  CustomTextFormField(
                                    enable: controller.edit,
                                    title: 'Full Name',
                                    hintText: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .full_name,
                                    initialValue: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .full_name,
                                    validatorFn: (value) {
                                      if (value!.isEmpty || value.length < 4)
                                        return 'Please enter valid name.';
                                    },
                                    onSavedFn: (value) {
                                      Get.find<ProfileViewModel>().full_name = value;
                                    },
                                  ),

                                  SizedBox(
                                    height: 38.h,
                                  ),
                                  CustomTextFormField(
                                    enable: controller.edit,
                                    title: 'Mobile No',
                                    keyboardType: TextInputType.phone,
                                    hintText: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .mobile_no,
                                    initialValue: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .mobile_no,
                                    validatorFn: (value) {
                                      if (value!.isEmpty || value.length < 4)
                                        return 'Please enter valid mobile number.';
                                    },
                                    onSavedFn: (value) {
                                      Get.find<ProfileViewModel>().mobile_no = value;
                                    },
                                  ),

                                  SizedBox(
                                    height: 38.h,
                                  ),
                                  CustomTextFormField(
                                    enable:controller.edit,
                                    title: 'Gender',
                                    hintText: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .gender,
                                    initialValue: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .gender,
                                    validatorFn: (value) {
                                      if (value!.isEmpty || value.length < 4)
                                        return 'Please enter valid gender.';
                                    },
                                    onSavedFn: (value) {
                                      Get.find<ProfileViewModel>().gender = value;
                                    },
                                  ),

                                  SizedBox(
                                    height: 38.h,
                                  ),
                                  CustomTextFormField(
                                    enable: controller.edit,
                                    title: 'Date of Birth',

                                    hintText: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .dob,
                                    initialValue: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .dob,
                                    validatorFn: (value) {
                                      if (value!.isEmpty || value.length < 4)
                                        return 'Please enter valid name.';
                                    },
                                    onSavedFn: (value) {
                                      Get.find<ProfileViewModel>().dob = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 38.h,
                                  ),
                                  Column(
                                    children: [
                                      CustomTextFormField(
                                        enable: controller.edit,
                                        title: 'Email',
                                        hintText: Get.find<ProfileViewModel>()
                                            .currentUser!
                                            .email,
                                        initialValue:
                                        Get.find<ProfileViewModel>()
                                            .currentUser!
                                            .email,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        validatorFn: (value) {
                                          if (value!.isEmpty)
                                            return 'Please enter valid email address.';
                                        },
                                        onSavedFn: (value) {
                                          Get.find<ProfileViewModel>().email =
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
                                              // try {
                                              //   // await controller
                                              //   //     .uploadImageToFirebase();
                                              //   // Get.find<ProfileViewModel>()
                                              //   //     .picUrl = controller.picUrl;
                                              // } catch (e) {
                                              //   // Get.find<ProfileViewModel>()
                                              //   //         .picUrl =
                                              //   //     Get.find<ProfileViewModel>()
                                              //   //         .currentUser!.pic;
                                              // }
                                              _formKey.currentState!.save();
                                              await Get.find<ProfileViewModel>()
                                                  .updateCurrentUser();
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
