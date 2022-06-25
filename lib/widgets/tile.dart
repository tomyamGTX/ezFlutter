import 'package:ez_flutter/screen/webview.display.dart';
import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  const Tile({
    Key? key,
    required this.paymentUrl,
    required this.name,
    required this.index,
    this.extent,
    required this.url,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);
  final String paymentUrl;
  final String url;
  final int index;
  final String name;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    final child = Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.url == 'No Data'
              ? 'https://www.computerhope.com/jargon/p/pink-color.jpg'
              : widget.url),
          opacity: 150,
        ),
      ),
      height: widget.extent,
      child: Center(
        child: Text(widget.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );

    if (widget.bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(
            child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewDisplay(
                              url: widget.paymentUrl,
                              title: '',
                            ))),
                child: child)),
        SizedBox(
          height: widget.bottomSpace,
          child: Center(
            child: Text(
              'RM ${widget.index}.00',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
