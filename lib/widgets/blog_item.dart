import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key, required this.blog}) : super(key: key);
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 2,
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Color.fromARGB(146, 204, 204, 204),
                ),
                width: double.infinity,
                child: Image.network(blog.thumbnail!)),
          ),
          ListTile(
            title: Text(blog.title!),
            subtitle: Text(blog.author!),
          )
        ],
      ),
    );
  }
}
