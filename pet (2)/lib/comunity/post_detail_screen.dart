import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet/comunity/api/delete_boards_type.dart';
import 'package:pet/comunity/api/post_boards_type_like.dart';
import '../common/component/url.dart';
import '../common/provider.dart';
import '../common/utils.dart';
import 'component/comment_box.dart';

class PostDetailScreen extends ConsumerWidget {
  final VoidCallback setWrite;
  final VoidCallback seDetail;

  const PostDetailScreen(
      {required this.setWrite, required this.seDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var boardsAsyncValue = ref.watch(detailProvider(detailId));
    bool like = false;
    return boardsAsyncValue.when(
        data: (board) {
          like = board.isLiked;
          return Scaffold(
            appBar: AppBar(
              title: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: seDetail,
                      icon: Icon(Icons.arrow_back_ios_new),
                    ),
                    nickname == board.writer
                        ? Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  seDetail();
                                  setWrite();
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  int state = await DeleteBoardsType(detailId);
                                  if (state == 200 || state == 201) seDetail();
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                board.writer,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                formatDateTime(board.createdAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              board.title,
                              style: TextStyle(fontSize: 24.sp),
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              board.content,
                              style: TextStyle(fontSize: 16.sp),
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Consumer(builder: (context, ref, _) {
                            return IconButton(
                              onPressed: () async {
                                like = !like;
                                int state = await PostBoardsLike(detailId);
                                if (state == 400)
                                  Fluttertoast.showToast(
                                      msg: "자신의 글에는 좋아요를 누를 수 없습니다.");
                                ref.refresh(detailProvider(detailId));
                              },
                              icon: Icon(
                                like ? Icons.favorite : Icons.favorite_outline,
                                color: like ? Colors.red : Colors.black,
                              ),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 10),
                      //이미지 처리
                      board.images.length > 0
                          ? CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 1,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlay: false,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: board.images.map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        image: DecorationImage(
                                          image: NetworkImage(image),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            )
                          : Container(),
                      SizedBox(height: 10.h),
                      CommentBox(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          print('Error in UI: $error');
          return Center(child: Text('Failed to load data'));
        });
  }
}
