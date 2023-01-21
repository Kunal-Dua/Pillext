import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(snap['profileImage']),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ]),
              )),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            )),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          child: Row(children: [
            IconButton(
                icon: const Icon(Icons.favorite_outline), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.comment_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.send), onPressed: () {}),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ))
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${snap["likes"].length} likes'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 4),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          text: snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: snap["description"])
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Text(
                    "View all 200 comments",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  DateFormat.yMMMd().format(snap["datePublished"].toDate()),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
