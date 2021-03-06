import 'package:flutter/material.dart';
import 'package:popular_list/detail_page.dart';
import 'package:popular_list/models/movie.dart';
import 'package:popular_list/models/movie_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PopularList extends StatefulWidget {
  const PopularList({Key? key}) : super(key: key);

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  late List<Movie> _movie;
  bool _isLoading = true;
  int _itemcount = 8;
  @override
  void initState() {
    super.initState();
    getMovies();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> getMovies() async {
    _movie = await MovieApi.getMovie();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Popular list',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      child: gridViewBuilder(),
                      onRefresh: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        if (_itemcount > 8) {
                          _itemcount = 8;
                        }
                        if (mounted) setState(() {});
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        //monitor fetch data from network
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        setState(() {
                          _itemcount = _itemcount + 8;
                        });
                        if (mounted) setState(() {});
                        _refreshController.loadComplete();
                      }),
                )
              ],
            )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black,
        ),
      ),
      title: const Text(
        'Back',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 80,
      titleSpacing: -20,
      leadingWidth: 70,
    );
  }

  GridView gridViewBuilder() {
    return GridView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: _itemcount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2 / 3),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print(_movie[index].title);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailPage(
                            title: _movie[index].title,
                            posterPath: _movie[index].posterPath,
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(
                      5.0,
                      15.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.multiply,
                  ),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w185/${_movie[index].posterPath}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_movie[index].releaseDate.substring(5, 7)}/${_movie[index].releaseDate.substring(0, 4)}',
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          _movie[index].title.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 115),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(24)),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Text(
                        _movie[index].voteAverage.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
