import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/url.dart';
import 'package:pet/shopping/component/item_card.dart';
import '../common/provider.dart';

class SelectItemScreen extends ConsumerWidget {
  final VoidCallback function;

  const SelectItemScreen({
    required this.function,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoryProvider(categorys));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 35.r),
              onPressed: function,
            ),
            Image.asset('asset/image/petIcon.png',width: 50.w,)
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: categoriesAsyncValue.when(
          data: (categories) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                childAspectRatio: 0.55,
              ),
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                return ItemCard(
                  name: category.name,
                  image_url: category.image_url,
                  url: category.url,
                  price: category.price,
                  index: index,
                  category: category.category,
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            print('Error in UI: $error'); // 에러 메시지 출력
            return Center(child: Text('Failed to load data'));
          },
        ),
      ),
    );
  }
}