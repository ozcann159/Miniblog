// import 'package:flutter/material.dart';
// import 'package:miniblog/models/blog.dart';

// class BlogDetails extends StatelessWidget {
//   const BlogDetails({Key? key, required this.blog}) : super(key: key);
//   final Blog blog;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(blog.title!),
//       ),
//       body: Column(children: [Image.network(blog.thumbnail!)]),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class BlogDetails extends StatefulWidget {
  const BlogDetails({super.key, required this.blogsId});
  final String? blogsId;

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  Blog? blog;

  @override
  void initState() {
    super.initState();
    fetchBlog();
  }

  fetchBlog() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogsId}");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);

    setState(() {
      blog = Blog.fromJson(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(blog?.title ?? ""),
      ),
      body: blog == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: 2 / 2,
                      child: Container(
                          color: const Color.fromARGB(109, 210, 210, 210),
                          child: Image.network(
                            blog?.thumbnail! ?? "",
                            fit: BoxFit.contain,
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    blog?.title! ?? "",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(blog?.content! ?? ""),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    blog?.author! ?? "",
                  ),
                ],
              )),
    );
  }
}
