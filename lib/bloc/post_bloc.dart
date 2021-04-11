import 'package:bloc/bloc.dart';
import 'package:insta_app/post_presenter.dart';

class PostEvent {}

abstract class PostState {}

class PostUninitialized extends PostState {}

class PostLoaded extends PostState {
  List<PostPresenter> posts;
  bool hasReachedMax;

  PostLoaded({this.posts, this.hasReachedMax});

  PostLoaded copyWith({List<PostPresenter> posts, bool hasReachedMax}) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostUninitialized());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    List<PostPresenter> posts;
    int page = 1;

    if (state is PostUninitialized) {
      posts = await PostPresenter.doGet('friends', page, 10);
      yield PostLoaded(posts: posts, hasReachedMax: false);
    } else {
      PostLoaded postLoaded = state as PostLoaded;
      posts = await PostPresenter.doGet('friends', page + 1, 10);
      yield (posts.isEmpty)
          ? postLoaded.copyWith(hasReachedMax: true)
          : PostLoaded(posts: postLoaded.posts + posts, hasReachedMax: false);
    }
  }
}
