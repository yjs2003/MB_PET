import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/provider.dart';
import 'package:pet/comunity/api/comment/post_comments.dart';

import '../../common/component/url.dart';
import '../../common/utils.dart';
import '../api/comment/delete_comments.dart';
import '../api/comment/put_comments.dart';

class CommentBox extends ConsumerWidget {
  const CommentBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController commenting = TextEditingController();
    String? isEdit;

    final commentAsyncValue = ref.watch(commentProvider(detailId));

    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey, // 회색 테두리 색상
          width: 2.0, // 테두리 두께
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 30.0.r,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black26
                              : const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        //모서리를 둥글게 테두리,
                        width: 260.w,
                        height: 40.h,
                        child: Row(
                          children: [
                            Flexible(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              child: TextFormField(
                                controller: commenting,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )),
                            IconButton(
                              //메세지보내기;
                              onPressed: () async {
                                if (isEdit != null) {
                                  await PutComments(
                                      detailId, isEdit!, commenting.text);
                                  ref.refresh(commentProvider(detailId));
                                  isEdit = null;
                                } else {
                                  int state = await PostComments(
                                      detailId, commenting.text);
                                  ref.refresh(commentProvider(detailId));
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                size: 24.r,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: commentAsyncValue.when(
              data: (comments) {
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // 댓글 작성자의 프로필 이미지
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                              ),
                              SizedBox(width: 10),
                              // ID와 댓글 날짜
                              Expanded(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                        Text(
                                          comment.writer,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                            SizedBox(width: 10.w),
                                            comment.writer=="suins"|| comment.writer=="zzzzzz"?
                                            Icon(Icons.verified,color: Colors.blue,size: 15.r,):Container()
                                        ]),
                                        Text(
                                          formatDateTime(comment.createdAt),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (nickname == comments[index].writer)
                                      Row(
                                        children: [
                                          Transform.translate(
                                              offset: Offset(20, 0),
                                              // x 축 방향으로 -8 만큼 이동하여 두 버튼 간격 줄이기
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    isEdit = comments[index].id;
                                                    commenting.text =
                                                        comments[index].content;
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 14.r,
                                                  ))),
                                          IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () async {
                                                await DeleteComments(detailId,
                                                    comments[index].id);
                                                ref.refresh(
                                                    commentProvider(detailId));
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 14.r,
                                              ))
                                        ],
                                      )
                                  ]))
                            ],
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                comment.content,
                                style: TextStyle(fontSize: 14),
                              ))
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
