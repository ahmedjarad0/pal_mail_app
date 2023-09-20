import 'dart:io';

import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/home/home_view.dart';
import 'package:consultation_app/pages/newInbox/category_view.dart';
import 'package:consultation_app/pages/newInbox/status_view.dart';
import 'package:consultation_app/pages/newInbox/tag_view.dart';
import 'package:consultation_app/services/mail_api_controller.dart';
import 'package:consultation_app/services/search_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/helper/mixin_helper.dart';
import '../widgets/custom_textfield_new_index.dart';

class NewInbox extends StatefulWidget {
  static String id = '/new_inbox_view';

  const NewInbox({super.key, this.categoryNamed});

  final String? categoryNamed;

  @override
  State<NewInbox> createState() => _NewInboxState();
}

class _NewInboxState extends State<NewInbox> with Helper{
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dateCtr;
  late TextEditingController _archiveNumberCtr;
  late TextEditingController _mailCtr;
  late TextEditingController _senderCtr;
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  bool expansionChanged = false;
  int? categoryId;
  int? statusId;
  String name = 'Inbox';
  String color = '0xffFA3A57';
  String categoryName = 'Other';

  void test() async {
    await SearchApiController().getSearch();
  }

  @override
  void initState() {
    // TODO: implement initState
    _dateCtr = TextEditingController();
    _archiveNumberCtr = TextEditingController();
    _mailCtr = TextEditingController();
    _senderCtr = TextEditingController();
    _imagePicker = ImagePicker();
    test();
    super.initState();
  }

  @override
  void dispose() {
    _dateCtr.dispose();
    _archiveNumberCtr.dispose();
    _mailCtr.dispose();
    _senderCtr.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void route() {
    ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute != null && modalRoute.settings.arguments != null) {
      if (modalRoute.settings.arguments is Map<String, dynamic>) {
        Map<String, dynamic> map =
        modalRoute.settings.arguments as Map<String, dynamic>;
        if (map.containsKey('name') && map.containsKey('color')) {
          name = map['name'];
          color = map['color'];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    route();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kLightPrimaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _performDone();
            },
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                  fontSize: 18.sp, color: kLightPrimaryColor),
            ),
          ),
        ],
        title: Text(
          'New Inbox',
          style: GoogleFonts.poppins(fontSize: 18.sp, color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white),
                  child: Column(
                    children: [
                      CustomTextFieldNewIndex(
                          validator: (p0) {

                          },
                          controller: _senderCtr,
                          hintText: 'Sender',
                          suffixIcon: IconButton(
                            icon: const Icon((Icons.info_outline)),
                            onPressed: () {},
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.person_outline),
                            onPressed: () {},
                          )),
                      const Divider(thickness: 1, indent: 20, endIndent: 20),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _showCategoryBottomSheet(context);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              'Category',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(widget.categoryNamed ?? 'other',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp, color: Colors.grey)),
                                const IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: Colors.grey,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white),
                  child: Column(
                    children: [
                      CustomTextFieldNewIndex(
                        controller: _mailCtr,
                        hintText: 'Title of mail',
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 20,
                      ),
                      const CustomTextFieldNewIndex(
                        hintText: 'Description',
                      )
                    ],
                  ),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Column(
                      children: [
                        CustomTextFieldNewIndex(
                            validator: (v) {
                              if (v != null && v.isEmpty) {
                                return 'Enter required Data';
                              }
                              return null;
                            },
                            hintText: 'MM-dd-yyyy',
                            labelText: 'Date',
                            prefixIcon: const Icon(
                              Icons.date_range_outlined,
                              color: Colors.red,
                            ),
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: kLightPrimaryColor),
                            onTap: () {
                              _pickData();
                            },
                            controller: _dateCtr),
                        const Divider(
                          thickness: 1,
                          indent: 20,
                        ),
                        CustomTextFieldNewIndex(
                          controller: _archiveNumberCtr,
                          validator: (v) {
                            if (v != null && v.isEmpty) {
                              return 'Enter required Data';
                            }
                            return null;
                          },
                          labelText: 'Archive Number',
                          hintText: 'like 2022/6019',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black87),
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.archive_outlined,
                                color: Color(0xff6F7CA7),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                GestureDetector(
                  onTap: () {
                    _showTagsBottomSheet(context);
                  },
                  child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.tag,
                            size: 16,
                          ),
                          Text(
                            '  Tags',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                  onTap: () {
                    _showStatusBottomSheet(context);
                  },
                  child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.black45,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                color: Color(int.parse(color)),
                                borderRadius: BorderRadius.circular(30.r)),
                            child: Text(
                              name,
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Decision',
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, color: kLightPrimaryColor),
                      ),
                      CustomTextFieldNewIndex(
                        hintText: 'Add Decision…',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          height: 1,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Image',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: kLightPrimaryColor,
                        ),
                      ),
                      _pickedImage == null
                          ? ElevatedButton(
                        onPressed: () {
                          _pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minimumSize: const Size(40, 15),
                            padding: EdgeInsets.zero),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      )
                          : Image.file(File(_pickedImage!.path)),
                    ],
                  ),
                ),
                Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: const Text('Activity'),
                    onExpansionChanged: (value) {
                      setState(() {
                        expansionChanged = value;
                      });
                    },
                    children: [
                      Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xffEEEEF6),
                              borderRadius: BorderRadius.circular(20)),
                          child: CustomTextFieldNewIndex(
                            hintText: 'Add new Activity …',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.black87),
                            prefixIcon: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: SvgPicture.asset(
                                  manImage,
                                  height: 15,
                                  width: 15,
                                )),
                            suffixIcon: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.paperPlane,
                                  size: 16,
                                )),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showTagsBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.92,
                maxChildSize: 0.92,
                builder: (_, controller) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: const TagView());
                },
              ),
            ),
          ),
        );
      },
    ).then((value) => value);
  }

  Future<dynamic> _showCategoryBottomSheet(BuildContext context,) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.92,
                maxChildSize: 0.92,
                builder: (_, controller) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: const CategoryView());
                },
              ),
            ),
          ),
        );
      },
    ).then((value) => value);
  }

  Future<dynamic> _showStatusBottomSheet(BuildContext context,) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.92,
                maxChildSize: 0.92,
                builder: (_, controller) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: const StatusView());
                },
              ),
            ),
          ),
        );
      },
    ).then((value) => value);
  }

  void _pickData() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (dateTime != null) {
      String format = DateFormat('EEEE, MMM d ,y ').format(dateTime);
      _dateCtr.text = format;
    }
  }

  void _pickImage() async {
    XFile? imageFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _pickedImage = imageFile;
      });
    }
  }

  void _done() {
    if (_checkData()) {}
  }

  bool _checkData() {
    if (_senderCtr.text.isNotEmpty &&
        _dateCtr.text.isNotEmpty &&
        _archiveNumberCtr.text.isNotEmpty &&
        _mailCtr.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void _performDone() async {
    if (_formKey.currentState!.validate()) {
      ApiHelper apiHelper = await MailApiController().createMail(
          subject: _mailCtr.text,
          archiveNumber: _archiveNumberCtr.text,
          archiveDate: _archiveNumberCtr.text,);
      if(apiHelper.success){
        Navigator.pushNamed(context, HomeView.id);
      }
      snackBar(context, message: apiHelper.message, success: apiHelper.success);
    }
  }
}
