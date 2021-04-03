import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teste_bloc_cubit_request_data/models/post_model.dart';
import 'package:teste_bloc_cubit_request_data/repositorys/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  //Repository to acess the api
  PostsRepository _postsRepository = PostsRepository();

  // É preciso inicializar nosso bloc, logo chamamos o construtor e passamos um dos estados
  PostsBloc() : super(LoadingPostsState());

  //passa por uma stream
  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is LoadPostsEvent || event is PullToRefreshPostsEvent) {
      //Para usar o yield é preciso colocar na função a keyword async*
      yield LoadingPostsState();// Manda pro stream, logo aonde state is LoadingPostsState pode acontecer algo

      try {
        final posts = await _postsRepository.getPosts();
        yield LoadedPostsState(posts);//Manda pro stream
      } catch (error) {
        yield FailedToLoadPostsState(error); //Manda pro stream
      }
    }
  }
}
