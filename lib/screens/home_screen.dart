import 'package:flutter/material.dart';
import 'latest_movies.dart';  

class HomeScreen extends StatelessWidget {
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: movieService.fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie.title),
                );
              },
            );
          }
        },
      ),
    );
  }
}
