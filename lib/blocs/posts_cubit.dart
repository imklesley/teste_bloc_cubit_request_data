/*Esse arquivo contém a estrutura basica de cubit e bloc. Foi feita uma transição de Cubit para Bloc.
* Onde Cubit é bem mais simples e rápido de ser implementado*/


import 'package:bloc/bloc.dart';
import 'package:teste_bloc_cubit_request_data/models/post_model.dart';
import 'package:teste_bloc_cubit_request_data/repositorys/posts_repository.dart';

// O Cubit é baseado em funções e estados
class PostsCubit extends Cubit<List<Post>> {
  // cria-se uma instância do postRepository
  PostsRepository _postsRepository = PostsRepository();
  //Inicializa com o estado de lista vazia
  PostsCubit() : super([]);

  //Emite o novo estado após ter feito a busca na api. Emitir equivale a colocar a nova lista de dados no Sink(entrada tubo)
  void getPosts() async {
    return emit(await _postsRepository.getPosts());
  }
}


//O Bloc é baseado em eventos e estados
// Essas duas classes serão usadas como generic do Bloc

abstract class PostsEvent {}
// Eventos que podem ocorrer
class LoadPostsEvent extends PostsEvent {}

class PullToRefreshPostsEvent extends PostsEvent {}

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


//A parte de Bloc foi reestruturada da forma que a documentação sugere, está em
// lib\blocs\posts, no qual os eventos e estados estão separados do bloc, para
// conseguir uma melhor organização do código
