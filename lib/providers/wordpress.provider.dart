import 'package:ez_flutter/models/wordpress.video.url.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_api/wordpress_api.dart';

class WordpressProvider extends ChangeNotifier {
  WordpressProvider() {
    getPost();
  }

  List<Post> post = [];
  List<VideoUrl> url = [];

  Future<void> getPost() async {
    final api = WordPressAPI('http://dev.islam.gov.my/isign/');
    final WPResponse res = await api.posts.fetch(args: {"per_page": "5"});
    for (final _post in res.data) {
      if (!post.contains(_post)) {
        post.add(_post);
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
}
