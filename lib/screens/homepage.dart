import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/screens/blog_details.dart';
import 'package:miniblog/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    List<Blog> blogsFromDb =
        jsonData.map((json) => Blog.fromJson(json)).toList();

    setState(() {
      blogs = blogsFromDb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text("Bloglar"),
          actions: [
            IconButton(
                onPressed: () async {
                  bool? result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddBlog()));

                  if (result == true) {
                    fetchBlogs();
                  }
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: blogs.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  fetchBlogs();
                },
                child: ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) => InkWell(
                    child: BlogItem(blog: blogs[index]),
                    onTap: () {
                      if (blogs[index].id != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlogDetails(
                                      blogsId: blogs[index].id!,
                                    )));
                      }
                    },
                  ),
                ),
              ));
  }
}
