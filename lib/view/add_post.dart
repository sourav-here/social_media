import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(31, 72, 72, 72)),
              height: 400,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 54, 53, 53),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                            child: Text(
                          'Select Post',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border_rounded)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.comment)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.ios_share_rounded))
                      ],
                    ),
                    const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('  Like'),
                      Text('Comment'),
                      Text('Share')
                    ],)
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
