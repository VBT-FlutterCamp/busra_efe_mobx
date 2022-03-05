import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobxmvvm/features/post/viewmodel/post_viewmodel.dart';

class PostView extends StatelessWidget {
  final _viewModel = PostViewModel();

  PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.getAllPost2();
        },
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            switch (_viewModel.pageState) {
              case PageState.LOADING:
                return const CircularProgressIndicator();
              case PageState.ERROR:
                return const Center(child: Text("Error"));
              case PageState.SUCCESS:
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: _viewModel.posts.length,
                  itemBuilder: (context, index) {
                    return buildListTile(index);
                  },
                );
              default:
                return const FlutterLogo();
            }
          },
        ),
      ),
    );
  }

  ListTile buildListTile(int index) {
    return ListTile(
        title: Text(_viewModel.posts[index].title ?? ''),
        subtitle: Text(_viewModel.posts[index].body ?? ''),
        trailing: Text(_viewModel.posts[index].id.toString()));
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text('VB10'),
      leading: Observer(
        builder: (_) {
          return Visibility(
            visible: _viewModel.isLoading,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
