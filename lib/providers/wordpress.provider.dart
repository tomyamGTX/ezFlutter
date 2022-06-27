import 'package:ez_flutter/models/wordpress.video.url.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_api/wordpress_api.dart';

class WordpressProvider extends ChangeNotifier {
  WordpressProvider() {
    getPostIsign();
    getPostPintarHub();
  }

  List<Post> postPintarHub = [];
  List<Post> postIsign = [];
  List<VideoUrl> url = [];

  Future<void> getPostIsign() async {
    final api = WordPressAPI('http://dev.islam.gov.my/isign/');
    final WPResponse res = await api.posts.fetch(args: {"per_page": "5"});
    for (final _post in res.data) {
      if (!postIsign.contains(_post)) {
        postIsign.add(_post);
        String content = _post.content!;
        var videoBlock = content.split('<hr class="wp-block-separator"/>');
        var cleanData = videoBlock.first
            .replaceAll('<figure class="wp-block-video"><video controls', "")
            .replaceAll('></video></figure>', '');
        var dataList = cleanData
            .trim()
            .replaceAll('poster=', '')
            .replaceAll('src=', '')
            .replaceAll('"', "")
            .split(" ");
        var videoUrl;
        var imageUrl;
        if (dataList.length == 1) {
          videoUrl = dataList.first;
        } else {
          imageUrl = dataList.first;
          videoUrl = dataList.last;
        }
        url.add(VideoUrl(
            videoUrl: videoUrl,
            id: _post.id,
            imageUrl: imageUrl ??
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
            content: content));
      }
      notifyListeners();
    }
  }

  Future<void> getPostPintarHub() async {
    final api = WordPressAPI('https://pintarhub.com/');
    final WPResponse res = await api.posts.fetch(args: {"per_page": "5"});
    for (final _post in res.data) {
      if (!postPintarHub.contains(_post)) {
        postPintarHub.add(_post);
        notifyListeners();
      }
    }
  }
}
