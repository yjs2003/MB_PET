import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/url.dart';
import 'package:pet/comunity/api/comment/get_comments.dart';
import 'package:pet/comunity/api/comment/model/comment_model.dart';
import 'package:pet/comunity/api/model/boardModel.dart';
import 'package:pet/comunity/api/model/detailModel.dart';
import 'package:pet/comunity/api/get_boards_type.dart';
import 'package:pet/home/api/get_pets.dart';
import 'package:pet/home/api/get_pets_type.dart';
import 'package:pet/shopping/api/get_category.dart';
import '../comunity/api/get_boards.dart';
import '../home/api/pet_detail_model.dart';
import '../home/api/pet_model.dart';
import '../shopping/api/model/categoryModel.dart';

//상품카테고리
final categoryProvider = FutureProvider.autoDispose.family<List<CategoryModel>, String>((ref, category) async {
  return await getCategory(category);
});
//------
//게시판전체
final boardProvider = FutureProvider.autoDispose<List<boardModel>>((ref) async {
  return await GetBoards();
});

//글상세보기
final detailProvider = FutureProvider.autoDispose.family<detailModel, String>((ref, detailId) async {
  return await GetBoardsType(detailId);
});
//------
//펫정보
final homeProvider = FutureProvider.autoDispose<List<petModel>>((ref) async {
  return await GetPets();
});

//특정펫정보
final homepetProvider = FutureProvider.autoDispose.family<petDetailModel, String>((ref, petId)async {
  return await GetPetsType(petId);
});


//댓글보기
final commentProvider = FutureProvider.autoDispose.family<List<CommentModel>, String>((ref, detailId)async {
  return await GetComments(detailId);
});
