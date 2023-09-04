import 'package:consultation_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  static String id = '/search_view';

  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(24)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(24)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(24)),
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Search',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,                          focusColor: Colors.transparent,
                        onPressed: () {},
                        icon: CircleAvatar(
                            radius: 11,
                            backgroundColor: Colors.grey.shade400,
                            child: Icon(
                              Icons.close,
                              color: Colors.grey.shade100,
                              size: 18,
                            ))),
                  ),
                ),
              ),
              IconButton(style: IconButton.styleFrom(elevation: 0,shadowColor: Colors.transparent,),
                  onPressed: () {},
                  icon: const Icon(size: 22,
                    Icons.cancel_schedule_send,
                    color: kLightPrimaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
