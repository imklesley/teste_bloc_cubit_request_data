part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}
// Eventos que podem ocorrer
class LoadPostsEvent extends PostsEvent {}

class PullToRefreshPostsEvent extends PostsEvent {}

