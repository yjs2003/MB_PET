import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/provider.dart';
import 'component/post_card.dart';
import 'component/write_button.dart';

class PostListScreen extends ConsumerWidget {
  final VoidCallback setWrite;
  final VoidCallback setDetail;

  const PostListScreen({
    required this.setDetail,
    required this.setWrite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    final boardsAsyncValue =ref.watch(boardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('asset/image/petIcon.png',width: 50.w,)
          ],
        ),
      ),
      body: boardsAsyncValue.when(
        data: (boards) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: boards.length,
              itemBuilder: (context, index) {
                final board = boards[index];
                return  board.thumbnail==null?
                PostCard(
                  title: board.title,
                  id: board.id,
                    content:board.content,
                  heartCount: board.likeCount,
                  commentCount: board.commentCount,
                  setDetail: setDetail,
                    isPet:board.isPetHelp,
                ):
                PostCard(
                  title: board.title,
                  id: board.id,
                    content:board.content,
                  heartCount: board.likeCount,
                  commentCount: board.commentCount,
                  setDetail: setDetail,
                  image:NetworkImage(board.thumbnail!),
                    isPet:board.isPetHelp,
                );
              },
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: WriteButton(setWrite: setWrite,)
    );
  }
}
