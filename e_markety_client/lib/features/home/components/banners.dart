import 'package:flutter/material.dart';

class Banners extends StatefulWidget {
  const Banners({Key? key, required this.items}) : super(key: key);

  final List<String> items;

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  int _current = 0;

  _indicator(int index) {
    bool isActive = _current == index;
    return Container(
      height: 4,
      width: isActive ? 12 : 4,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isActive ? Colors.orange : Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.215,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        onPageChanged: (int index) => setState(() => _current = index),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: NetworkImage(widget.items[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 30,
                child: Wrap(
                  children: List.generate(
                    widget.items.length,
                    (index) => _indicator(index),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
