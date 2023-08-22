import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imgy/imgy.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> images = [
      {
        "preview":
            "https://images.unsplash.com/photo-1682685797660-3d847763208e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
        "full":
            "https://images.unsplash.com/photo-1682685797660-3d847763208e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=100",
      },
      {
        "preview":
            "https://images.unsplash.com/photo-1692206130097-f66afa1cbc96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "full":
            "https://images.unsplash.com/photo-1692206130097-f66afa1cbc96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2187&q=100",
      },
      {
        "preview":
            "https://images.unsplash.com/photo-1692401134669-4622e26ebede?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "full":
            "https://images.unsplash.com/photo-1692401134669-4622e26ebede?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2128&q=100",
      },
      {
        "preview":
            "https://images.unsplash.com/photo-1682686580433-2af05ee670ad?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "full":
            "https://images.unsplash.com/photo-1682686580433-2af05ee670ad?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2187&q=100"
      },
      {
        "preview":
            "https://images.unsplash.com/photo-1692302858386-6daeab196cec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0MHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "full":
            "https://images.unsplash.com/photo-1692302858386-6daeab196cec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2187&q=100"
      },
      {
        "preview":
            "https://images.unsplash.com/photo-1692467478663-067848d6e177?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1NXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "full":
            "https://images.unsplash.com/photo-1692467478663-067848d6e177?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2187&q=100"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Imgy Component'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        children: images
            .map(
              (e) => Imgy(
                src: e["preview"]!,
                fullSrc: e["full"]!,
                enableFullScreen: true,
                description: "Image description",
                placeholderColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ),
            )
            .toList(),
      ),
    );
  }
}
