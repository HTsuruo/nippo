import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nippo/models/post.dart';
import 'package:nippo/theme.dart';
import 'package:nippo/util.dart';
import 'package:nippo/models/user.dart';

class ContentCard extends StatelessWidget {
  ContentCard({this.post, this.user});
  Post post;
  User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: InkWell(
        onTap: () async {
          onTapCard(context: context);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: CircleAvatar(
                      child: Image.network(
                        user.photoUrl,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, left: 4),
                        child: Text(
                          post.title,
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, left: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(post.description),
                            const SizedBox(height: 4),
                            Text(
                              formatDateFromTimeStamp(
                                  timestamp: post.createdAt),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: VIC.navy),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: VIC.red,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapCard({BuildContext context}) async {
    final res = await showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.network(
                      user.photoUrl,
                      height: 36,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(user.displayName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            '${formatDateFromTimeStamp(timestamp: post.createdAt)} に投稿'),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(post.title,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(post.description,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
          );
        });
    print('bottom sheet result: $res');
  }
}
