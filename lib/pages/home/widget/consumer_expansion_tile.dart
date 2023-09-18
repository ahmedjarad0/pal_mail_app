import 'package:consultation_app/pages/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/mail.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/mails_provider.dart';
import 'content_expansion_tile.dart';
import 'custom_expansion_tile.dart';

class ConsumerExpansionTile extends StatelessWidget {
  const ConsumerExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, MailProvider>(
        builder: (context, catValue, mailsValue, child) {
      if (catValue.state == CategoryState.Loading) {
        return const CategoriesShimmer();
      }
      if (catValue.state == CategoryState.Error) {
        return const CategoriesShimmer();
      }

      final categories = catValue.category;

      if (categories != null && catValue.state == CategoryState.Complete) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                List<Mails> filteredMails = [];

                if (mailsValue.state == MailsState.Complete) {
                  final mails = mailsValue.allMails;
                  filteredMails = mails!.where((e) {
                    return e.sender?.category!.name == categories[index].name;
                  }).toList();

                  return CustomExpansionTile(
                      title: categories[index].name!,
                      count: filteredMails.length.toString(),
                      child: ListView.separated(
                        itemCount: filteredMails.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ContentExpansionTile(
                            color: filteredMails[index].status != null
                                ? int.parse(filteredMails[index].status!.color!)
                                : 0xffFFFF00,
                            title: filteredMails[index].sender!.name!,
                            date: filteredMails[index].createdAt!,
                            subject: filteredMails[index].subject!,
                            description: filteredMails[index].description,
                            tags: filteredMails[index]
                                .tags!
                                .map((e) => '#${e.name}   ')
                                .toList()
                                .join()
                                .toString(),
                            photoList: const SizedBox(),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                        ),
                      ));
                }
                return const SizedBox();
              }),
        );
      } else {
        return const CategoriesShimmer();
      }
    });
  }
}
