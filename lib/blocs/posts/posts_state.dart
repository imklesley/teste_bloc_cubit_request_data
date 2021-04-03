part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

//Listamos todas os possíveis estados(os que irão ocorrer...)

//Obtendo uma lista de postagens
class LoadingPostsState extends PostsState {}

//Obteve com sucesso a lista com postagens
class LoadedPostsState extends PostsState {
  List<Post> posts;
  LoadedPostsState(this.posts);
}

//Erro ao carregar os posts
class FailedToLoadPostsState extends PostsState {
  //Should Be of type Error
  Object error;
  FailedToLoadPostsState(this.error);
}