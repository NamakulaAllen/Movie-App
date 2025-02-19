import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class LatestMovies extends StatefulWidget {
  @override
  _LatestMoviesState createState() => _LatestMoviesState();
}

class _LatestMoviesState extends State<LatestMovies> {
  List<dynamic> _movies = [];
  bool _isLoading = true;
  String _errorMessage = '';

  // API Key for Movie DB API
  final String apiKey = 'YOUR_API_KEY_HERE';
  final String apiUrl = "https://api.themoviedb.org/3/movie";

  // Fetch movies data from API
  Future<void> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _movies = json.decode(response.body)['results'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load movies';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Something went wrong!';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latest Movies')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Horizontal list of movies
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _movies.length,
                          itemBuilder: (context, index) {
                            var movie = _movies[index];
                            return GestureDetector(
                              onTap: () {
                                // Handle movie tap (optional)
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                      imageBuilder: (context, imageProvider) => Container(
                                        width: 120,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      movie['title'],
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LatestMovies(),
  ));
}
