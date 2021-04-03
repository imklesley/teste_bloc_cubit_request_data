import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_bloc_cubit_request_data/blocs/posts/posts_bloc.dart';
// import 'package:teste_bloc_cubit_request_data/blocs/posts_cubit.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(icon: Icon(Icons.refresh), onPressed: () {

            BlocProvider.of<PostsBloc>(context).add(LoadPostsEvent());
          })],
          title: Text('Postagens'),
          centerTitle: true,
        ),
        body:
            //CUBIT
            /*BlocBuilder<PostsCubit, List<Post>>(
          builder: (context, posts) {
            if (posts.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Text('${posts[index].title}'),
                    );
                  });
            }
            return Container();
          },
        )*/

            //Bloc
            BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoadedPostsState) {
              return RefreshIndicator(
                onRefresh: () async {
                  //Acessamos a class que contém o bloc desejado. Fazendo isso acessamos
                  // a instância já criada para não precisar criar outra instância,
                  // para então acessarmos o add(entrada do tubo o "sink") para
                  // então trabalharmos com a saída(stream) aqui na nossa view
                  return BlocProvider.of<PostsBloc>(context)
                      .add(PullToRefreshPostsEvent());
                },
                child: ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 50,
                        child: Card(
                          child: Center(
                              child: Text('${state.posts[index].title}')),
                        ),
                      );
                    }),
              );
            } else if (state is FailedToLoadPostsState)
              return Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    '${state.error}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              );
            else {
              return Container();
            }
          },
        ));
  }
}
