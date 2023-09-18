import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/helper/mixin_helper.dart';
import 'package:consultation_app/pages/widgets/custom_action_chip.dart';
import 'package:consultation_app/pages/widgets/custom_shimmer.dart';
import 'package:consultation_app/pages/widgets/custom_textfield_new_index.dart';
import 'package:consultation_app/provider/tag_provider.dart';
import 'package:consultation_app/services/tag_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TagView extends StatefulWidget {
  const TagView({super.key});

  @override
  State<TagView> createState() => _TagViewState();
}

class _TagViewState extends State<TagView> with Helper {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TagProvider>(context, listen: false).getAllTags();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 65,
        leading: TextButton(
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
        title: Text(
          'Tags',
          style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
            child: Consumer<TagProvider>(
              builder: (context, tagProvider, child) {
                if (tagProvider.statues == TagStatues.Loading) {
                  return const TagsShimmer();
                }
                if (tagProvider.statues == TagStatues.Error) {
                  return const TagsShimmer();
                }
                final tags = tagProvider.tag;
                if (tags != null &&
                    tagProvider.statues == TagStatues.Complete) {
                  return Wrap(
                    spacing: 8,
                    children: [
                      for (int i = 0; i < tags.length; i++) ...[
                        CustomActionChip(
                          titleTag: tags[i].name!,
                        )
                      ]
                    ],
                  );
                } else {
                  return const TagsShimmer();
                }
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r)),
              child: CustomTextFieldNewIndex(
                  hintText: 'Add New Tag…',
                  suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        _createTag();
                        setState(() {
                          Provider.of<TagProvider>(context, listen: false)
                              .getAllTags;
                        });
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        size: 18,
                      )),
                  controller: _textEditingController)),
        ],
      ),
    );
  }

  void _createTag() {
    if (_checkData()) {
      _create();
    }
  }

  bool _checkData() {
    if (_textEditingController.text.isNotEmpty) {
      return true;
    }
    snackBar(context, message: 'Enter required Data', success: false);
    return false;
  }

  void _create() async {
    ApiHelper apiHelper =
        await TagApiController().createTags(name: _textEditingController.text);
    if (apiHelper.success) {
      _textEditingController.clear();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<TagProvider>(context, listen: false).getAllTags();
      });
    }

    snackBar(context, message: apiHelper.message, success: apiHelper.success);
  }
}
