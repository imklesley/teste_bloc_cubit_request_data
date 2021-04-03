import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/posts/posts_bloc.dart';
import 'views/home.dart';

// SE FOR RODAR ESSE CÓDIGO NOVAMENTE, LEMBRE QUE O "https://jsonplaceholder.typicode.com/" MUDA OS DADOS O TEMPO TODOO, LOGO PODE N FUNCIONAR

void main() {
  runApp(new MyApp());
}

//Cubit
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //Os blocs só podem vir como filho de material, não pai
//       home: BlocProvider<PostsCubit>(
//         // Esses dois pontos antes de "getPosts()" se chama cascade e permite acessar os métodos de PostsCubit
//         create: (context) => PostsCubit()..getPosts(),
//         child: Home(),
//       ),
//     );
//   }
// }

//BLoC
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Os blocs só podem vir como filho de material, não pai
      home: BlocProvider<PostsBloc>(
        // Esses dois pontos antes de "add()" se chama cascade e permite acessar
        // os métodos de PostsBloc, aqui se está adicionando o loadPostsEvent no sink
        // para dar início ao Loading posts -- retirei o code que o comentário fazia
        // referência, caso deseje já iniciar em um estado use: PostsBloc()..add(LoadPostsEvent())
        create: (context) => PostsBloc()..add(LoadPostsEvent()),
        child: Home(),
      ),
    );
  }
}
