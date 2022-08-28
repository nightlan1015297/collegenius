import 'package:collegenius/routes/hero_dialog_route.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  Gallery({
    required this.children,
    this.height,
  });

  final double? height;
  final List<Widget> children;

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Container(
        width: constrains.maxWidth,
        height: widget.height ?? constrains.maxHeight,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: Stack(
          children: [
            PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              children: widget.children,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (context, snapshot) {
                  return CustomPaint(
                    painter: PageIndicatorPaint(
                      spacing: 6,
                      pageCount: widget.children.length,
                      dotRadius: 4,
                      scrollposition: _pageController.page ?? 0.0,
                      dotFillcolor: Colors.grey.shade400,
                      dotOutlineColor: Colors.grey.shade600,
                      indicatorColor: Colors.lightBlue,
                      outlineThickness: 1,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class GalleryCard extends StatelessWidget {
  const GalleryCard(
      {Key? key,
      required this.assets,
      required this.title,
      required this.content})
      : super(key: key);
  final String assets;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            HeroDialogRoute(
              builder: (context) {
                return GalleryPopupView(
                  assets: assets,
                  title: title,
                  content: content,
                );
              },
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image(
            image: AssetImage(assets),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GalleryPopupView extends StatelessWidget {
  const GalleryPopupView({
    Key? key,
    required this.assets,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String assets;
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: _theme.iconTheme,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Row(
                children: [
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      width: 250,
                      height: 250,
                      image: AssetImage(assets),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: _theme.textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(content),
            ),
          ],
        ),
      ),
    );
  }
}

class PageIndicatorPaint extends CustomPainter {
  PageIndicatorPaint({
    required Color dotFillcolor,
    required Color dotOutlineColor,
    required Color indicatorColor,
    required this.scrollposition,
    required this.pageCount,
    required this.dotRadius,
    required this.outlineThickness,
    required this.spacing,
  })  : dotFillpaint = Paint()..color = dotFillcolor,
        dotOutlinePaint = Paint()..color = dotOutlineColor,
        indicatorPaint = Paint()..color = indicatorColor;

  final int pageCount;
  final double dotRadius;
  final double outlineThickness;
  final double spacing;
  final Paint dotFillpaint;
  final Paint dotOutlinePaint;
  final Paint indicatorPaint;
  final double scrollposition;

  @override
  void paint(Canvas canvas, Size size) {
    final double fullwidth =
        (pageCount * (2 * dotRadius) + ((pageCount - 1) * spacing));
    _drawDots(fullwidth, canvas);
    _drawIndicator(canvas, fullwidth);
  }

  void _drawIndicator(Canvas canvas, double fullwidth) {
    final int page = scrollposition.floor();
    final double leftDotX = page * (dotRadius * 2 + spacing) - fullwidth / 2;
    final double transitionPercentage = scrollposition - page;

    final double laggingpercentage =
        (transitionPercentage - 0.3).clamp(0.0, 1.0) / 0.7;
    final double acceleratepercentage =
        (transitionPercentage / 0.5).clamp(0.0, 1.0);

    final double indicatorLeftX =
        leftDotX + laggingpercentage * ((2 * dotRadius) + spacing);

    final double indicatorRightX = leftDotX +
        acceleratepercentage * ((2 * dotRadius) + spacing) +
        (2 * dotRadius);

    canvas.drawRRect(
        RRect.fromLTRBR(indicatorLeftX, 2 * dotRadius, indicatorRightX, 0,
            Radius.circular(dotRadius)),
        indicatorPaint);
  }

  void _drawDots(double fullwidth, Canvas canvas) {
    for (int i = 0; i < pageCount; i++) {
      Offset _dotCenter = Offset(
          dotRadius + i * (dotRadius * 2 + spacing) - fullwidth / 2, dotRadius);
      _drawDot(canvas, _dotCenter);
    }
  }

  void _drawDot(Canvas canvas, Offset _dotCenter) {
    canvas.drawCircle(_dotCenter, dotRadius - outlineThickness, dotFillpaint);
    Path _outlinePath = Path()
      ..addOval(Rect.fromCircle(center: _dotCenter, radius: dotRadius))
      ..addOval(Rect.fromCircle(
          center: _dotCenter, radius: dotRadius - outlineThickness));
    canvas.drawPath(_outlinePath, dotOutlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
