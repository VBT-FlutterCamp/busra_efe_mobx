import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:mobxmvvm/features/post/model/post.dart';
part 'post_viewmodel.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  @observable
  PageState pageState = PageState.NORMAL;

  @observable
  List<Post> posts = [];

  final url = "https://jsonplaceholder.typicode.com/posts";

  @observable
  bool isLoading = false;
/*
  @action
  Future<void> getAllPost() async {
    changeRequest();
    final response = await Dio().get(url);

    if (response.statusCode == HttpStatus.ok) {
      final respondeData = response.data as List;
      posts = respondeData.map((e) => Post.fromJson(e)).toList();
    }
    changeRequest();
  }*/

  @action
  Future<void> getAllPost2() async {
    pageState = PageState.LOADING;
    changeRequest();

    try {
      final response = await Dio().get(url);

      if (response.statusCode == HttpStatus.ok) {
        final respondeData = response.data as List;
        posts = respondeData.map((e) => Post.fromJson(e)).toList();
        pageState = PageState.SUCCESS;
      }
      changeRequest();
    } catch (e) {
      pageState = PageState.ERROR;
    }
  }

  @action
  void changeRequest() {
    isLoading = !isLoading;
  }
}

enum PageState { LOADING, ERROR, SUCCESS, NORMAL }
