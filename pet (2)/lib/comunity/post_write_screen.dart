import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/common/component/url.dart';
import 'package:pet/comunity/api/get_boards_type.dart';
import 'package:pet/comunity/api/post_boards.dart';
import 'package:pet/comunity/api/put_boards_type.dart';
import '../common/permission.dart';
import 'component/post_textbox.dart';
import 'package:http/http.dart' as http;

class PostWriteScreen extends StatefulWidget {
  final VoidCallback setScreen;

  const PostWriteScreen({required this.setScreen, super.key});

  @override
  State<PostWriteScreen> createState() => _PostWriteScreenState();
}

class _PostWriteScreenState extends State<PostWriteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController contents = TextEditingController();
  bool help = false;
  Set<MultipartFile> dummyFille = {};
  Set<Image> backimg = {};
  String? detailids;
  List<dynamic> imageUrl = [];

  @override
  Widget build(BuildContext context) {
    if (detailId != "")
      return FutureBuilder(
          future: GetBoardsType(detailId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              title.text = data!.title;
              contents.text = data.content;
              help = data.isPetHelp;
              backimg = data.images
                  .map((imageUrl) => Image(image: NetworkImage(imageUrl)))
                  .toList()
                  .toSet();
              detailids = detailId;
              imageUrl = data.images.toList();
              detailId = "";
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: widget.setScreen,
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          elevation: 2,
                        ),
                        onPressed: () async {
                          await convertImagesToMultipartFiles(data.images);
                          int test = await PutBoardsType(
                              detailids!,
                              dummyFille.toList(),
                              title.text,
                              contents.text,
                              help);
                          if (test == 201 || test == 200) {
                            widget.setScreen();
                          }
                        },
                        child: Text("완료"),
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                    child: SafeArea(
                        top: true,
                        child: Stack(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    PostTextbox(
                                      controller: title,
                                      hintText: "Title",
                                      height: 80,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 10.h),
                                        PostTextbox(
                                          controller: contents,
                                          hintText: "Contents",
                                          height: 470.h,
                                        ),
                                        SizedBox(height: 30.h),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              (backimg.isNotEmpty ? 370 : 280),
                                    ),
                                    if (backimg.isNotEmpty)
                                      SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              children: backimg
                                                  .toList()
                                                  .map((image) => Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          image:
                                                              DecorationImage(
                                                            image: image.image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )))
                                                  .toList())),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(children: [
                                          SizedBox(height: 40.h),
                                          Row(children: [
                                            IconButton(
                                              onPressed: () {
                                                if (dummyFille.length < 3) {
                                                  PermissionQuest();
                                                  dummyFilles();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "You cannot upload more than three images.");
                                                }
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                size: 30.r,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                if (dummyFille.length < 3) {
                                                  PermissionQuest();
                                                  dummyFillefun();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "You cannot upload more than three images.");
                                                }
                                              },
                                              icon: Icon(
                                                Icons.photo,
                                                size: 30.r,
                                              ),
                                            ),
                                          ]),
                                        ]),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'asset/image/pethelp.png',
                                              width: 30.w,
                                            ),
                                            Checkbox(
                                              value: help,
                                              onChanged: (value) {
                                                setState(() {
                                                  help = !help;
                                                });
                                              },
                                              visualDensity:
                                                  VisualDensity.compact,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ))),
              );
            } else
              return CircularProgressIndicator();
          });
    else
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: widget.setScreen,
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  elevation: 2,
                ),
                onPressed: () async {
                  if (detailids != null) {
                    await convertImagesToMultipartFiles(imageUrl);
                    int test = await PutBoardsType(detailids!,
                        dummyFille.toList(), title.text, contents.text, help);
                    if (test == 201 || test == 200) {
                      widget.setScreen();
                    }
                  }
                  int test = await PostBoards(
                      dummyFille.toList(), title.text, contents.text, help);
                  if (test == 201 || test == 200) {
                    widget.setScreen();
                  }
                },
                child: Text("완료"),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                top: true,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            PostTextbox(
                              controller: title,
                              hintText: "Title",
                              height: 80,
                            ),
                            Column(
                              children: [
                                SizedBox(height: 10.h),
                                PostTextbox(
                                  controller: contents,
                                  hintText: "Contents",
                                  height: 470.h,
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  (backimg.isNotEmpty ? 370 : 280),
                            ),
                            if (backimg.isNotEmpty)
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: backimg
                                          .toList()
                                          .map((image) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  image: DecorationImage(
                                                    image: image.image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )))
                                          .toList())),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  SizedBox(height: 40.h),
                                  Row(children: [
                                    IconButton(
                                      onPressed: () {
                                        if (dummyFille.length < 3) {
                                          PermissionQuest();
                                          dummyFilles();
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "You cannot upload more than three images.");
                                        }
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 30.r,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (dummyFille.length < 3) {
                                          PermissionQuest();
                                          dummyFillefun();
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "You cannot upload more than three images.");
                                        }
                                      },
                                      icon: Icon(
                                        Icons.photo,
                                        size: 30.r,
                                      ),
                                    ),
                                  ]),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      'asset/image/pethelp.png',
                                      width: 30.w,
                                    ),
                                    Checkbox(
                                      value: help,
                                      onChanged: (value) {
                                        setState(() {
                                          help = !help;
                                        });
                                      },
                                      visualDensity: VisualDensity.compact,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ))),
      );
  }

  Future<MultipartFile> imageFileToMultipartFile(String imagePath) async {
    // 이미지 파일을 바이트로 읽기
    final response = await http.get(Uri.parse(imagePath));
    Uint8List imageBytes = response.bodyBytes;
    String fileName = imagePath.split('/').last;

    MultipartFile multipartFile = MultipartFile.fromBytes(
      imageBytes,
      filename: fileName,
    );

    return multipartFile;
  }

  Future<void> convertImagesToMultipartFiles(List<dynamic> imageUrls) async {
    List<MultipartFile> files = [];
    for (String imageUrl in imageUrls) {
      MultipartFile file = await imageFileToMultipartFile(imageUrl);
      files.add(file);
    }
    setState(() {
      dummyFille.addAll(files);
    });
  }

  Future<void> dummyFillefun() async {
    // 사용자 이미지 선택
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (f != null) {
      MultipartFile file = await MultipartFile.fromFile(
        File(f.path).path,
        filename: File(f.path).path.split('/').last,
      );
      setState(() {
        dummyFille.add(file);
        backimg.add(Image.file(File(f.path)));
      });
    }
  }

  Future<void> dummyFilles() async {
    XFile? f = await ImagePicker().pickImage(source: ImageSource.camera);

    if (f != null) {

      MultipartFile file = await
      MultipartFile.fromFile(
        File(f.path).path,
        filename: File(f.path).path.split('/').last,
      );
      setState(() {
        dummyFille.add(file);
        backimg.add(Image.file(File(f.path)));
      });
    }
  }
}
