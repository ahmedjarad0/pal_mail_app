import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/newInbox/category_view.dart';
import 'package:consultation_app/pages/newInbox/tag_view.dart';
import 'package:consultation_app/pages/widgets/custom_show_model_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_textfield_new_index.dart';

class NewInbox extends StatefulWidget {
  static String id = '/new_inbox_view';

  const NewInbox({super.key});

  @override
  State<NewInbox> createState() => _NewInboxState();
}

class _NewInboxState extends State<NewInbox> {
  late TextEditingController _dateCtr;

  @override
  void initState() {
    // TODO: implement initState
    _dateCtr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dateCtr.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
        child: SingleChildScrollView(
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
                    CustomShowModelBottom(
                      builder: (context, scroll) {
                        return const CategoryView();
                      },
                      childModel: Row(
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
                              Text('Other',
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
                    )
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
                child: const Column(
                  children: [
                    CustomTextFieldNewIndex(
                      hintText: 'Title of mail',
                    ),
                    Divider(
                      thickness: 1,
                      indent: 20,
                    ),
                    CustomTextFieldNewIndex(
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
              CustomShowModelBottom(
                builder: (p0, p1) {
                  return const TagView();
                },
                childModel: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
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
              CustomShowModelBottom(
                builder: (p0, p1) {
                  return SizedBox();
                },
                childModel: Container(
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
                        SizedBox(width: 10.w,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                          decoration: BoxDecoration(
                              color: const Color(0xffFA3A57),
                              borderRadius: BorderRadius.circular(30.r)),
                          child: Text(
                            'Inbox',
                            style: GoogleFonts.poppins(fontSize: 12,color: Colors.white),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.grey,
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
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
}
