import 'package:flutter/material.dart';

const _revealPart = 15;

class CarouselList extends StatefulWidget {
  const CarouselList({required this.children});

  final List<Widget> children;

  @override
  _CarouselListState createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList>
    with WidgetsBindingObserver {
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double _vpWidth = constraints.maxWidth;
        final double _vpHeight = constraints.maxHeight;
        double _cardSize;
        final int _cardQuantity;
        double _cardMargin = 10.0;
        double _verticalPadding = 10.0;

        if (_vpWidth < _vpHeight) {
          _cardSize = _vpWidth - _revealPart * 2 - _cardMargin * 2;
          _cardQuantity = 1;
        } else {
          _cardSize = _vpHeight - _verticalPadding * 2 - _cardMargin * 2;
          _cardQuantity = (_vpWidth - 2 * _revealPart) ~/ _cardSize;
          _cardMargin =
              (_vpWidth - _cardSize * _cardQuantity - 2 * _revealPart) /
                  ((_cardQuantity + 1) * 2);
        }

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: _cardSize,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: _verticalPadding),
            controller: _controller,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              if (index == 0 || index == widget.children.length) {
                return SizedBox(width: _revealPart + _cardMargin);
              }
              return SizedBox(
                width: _cardSize,
                height: _cardSize,
                child: widget.children[index],
              );
            },
          ),
        );
      },
    );
  }
}

/*
class CarouselScrollPhysics extends ScrollPhysics {
  const CarouselScrollPhysics({ScrollPhysics? parent, required this.pagePixel})
      : super(parent: parent);

  final pagePixel;

  @override
  CarouselScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CarouselScrollPhysics(
        parent: buildParent(ancestor), pagePixel: pagePixel);
  }

  double _getPage(ScrollMetrics position) {
    return position.pixels / pagePixel;
  }

  double _getPixels(ScrollMetrics position, double page) {
    return page * pagePixel;
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => true;
}
*/

class CarouselCard extends StatelessWidget {
  const CarouselCard({this.backgroundImage});

  final String? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double _cardSize = constraints.maxWidth;
        final _theme = Theme.of(context);
        final _cardBackground = backgroundImage != null
            ? Container(
                width: _cardSize,
                height: _cardSize,
                child: Image.asset(
                  backgroundImage.toString(),
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                width: _cardSize,
                height: _cardSize,
                color: Colors.blue.shade900,
              );

        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          elevation: 2,
          child: Stack(
            children: [
              _cardBackground,
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      _theme.backgroundColor.withOpacity(0),
                      _theme.backgroundColor.withOpacity(1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: _cardSize,
                          child: Text(
                            "我是大標題",
                            style: _theme.textTheme.headline4,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
