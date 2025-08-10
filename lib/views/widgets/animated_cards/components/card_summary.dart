import 'package:flutter/material.dart';
import 'my_data.dart';

enum MyCardTheme { dark, light }

class CardSummary extends StatelessWidget {
  final DummyData dummy;
  final MyCardTheme theme;
  final bool isOpen;

  const CardSummary({
    super.key,
    required this.dummy,
    this.theme = MyCardTheme.light,
    this.isOpen = false,
  });


  Color _getBackgroundColor(BackgroundStyle background) {
    if (background is SolidColorBackground) {
      return background.color;
    }

    if (background is GradientBackground) {
      return background.colors.first;
    }

    return Colors.black;
  }
  Color get mainTextColor {
    if (theme == MyCardTheme.dark) {
      return Colors.white;
    }

    if (dummy.bgColor is SolidColorBackground) {
      return (dummy.bgColor as SolidColorBackground).color;
    }

    if (dummy.bgColor is GradientBackground) {
      return (dummy.bgColor as GradientBackground).colors.first;
    }
    return Colors.black;
  }
  Color get secondaryTextColor =>
      (theme == MyCardTheme.dark) ? Color(0xff61849c) : Color(0xFF838383);
  Color get separatorColor =>
      (theme == MyCardTheme.dark) ? Color(0xffeaeaea) : Color(0xff396583);

  TextStyle get bodyTextStyle =>
      TextStyle(color: mainTextColor, fontSize: 13, fontFamily: 'Oswald');

  bool get isLight => theme == MyCardTheme.light;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBackgroundDecoration(),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildLogoHeader(),
            _buildSeparationLine(),
            _buildTicketHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildLogo(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildSmallLogo(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset('images/me.png', height: 90, width: 90),
                  ),
                ],
              ),
            ),
            _buildBottomIcon(),
          ],
        ),
      ),
    );
  }

  _getBackgroundDecoration() {
    if (isLight) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      );
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: dummy.bgColor is SolidColorBackground
          ? (dummy.bgColor as SolidColorBackground).color
          : null,
      gradient: dummy.bgColor is GradientBackground
          ? (dummy.bgColor as GradientBackground).gradient
          : null,
    );
  }

  _buildLogoHeader() {
    if (isLight) {
      return Text(
        'Imran mani'.toUpperCase(),
        style: TextStyle(
          color:_getBackgroundColor(dummy.bgColor),
          fontFamily: 'OpenSans',
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      );
    } else {
      return Text(
        'Imran mani'.toUpperCase(),
        style: TextStyle(
          color: separatorColor,
          fontFamily: 'OpenSans',
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      );
    }
  }

  Widget _buildSeparationLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: isLight ? _getBackgroundColor(dummy.bgColor) : separatorColor,
    );
  }

  Widget _buildTicketHeader(context) {
    var headerStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: isLight ? Color(0xFFe46565) : separatorColor,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(dummy.platformName.toUpperCase(), style: headerStyle),
        Text(dummy.userName, style: headerStyle),
      ],
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Image.asset(
        dummy.logo,
        height: 80,
        width: 80,
        color: isLight ? null : Colors.white,
      ),
    );
  }

  Widget _buildSmallLogo() {
    final littleLogo = Image.asset(
      dummy.logo,
      height: 20,
      width: 20,
      fit: BoxFit.contain,
      color: isLight ? null : Colors.white,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: 20,
          height: 58,
          child: isLight
              ? littleLogo
              : _AnimatedSlideToRight(isOpen: isOpen, child: littleLogo),
        ),
        if(isLight)
        Text("Check Now", textAlign: TextAlign.center, style: bodyTextStyle),
      ],
    );
  }

  Widget _buildBottomIcon() {
    IconData icon =
        isLight ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up;
    return Icon(
      icon,
      color: isLight ? separatorColor : Colors.white,
      size: 18,
    );
  }
}

class _AnimatedSlideToRight extends StatefulWidget {
  final Widget child;
  final bool isOpen;

  const _AnimatedSlideToRight({required this.child, required this.isOpen});

  @override
  _AnimatedSlideToRightState createState() => _AnimatedSlideToRightState();
}

class _AnimatedSlideToRightState extends State<_AnimatedSlideToRight>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 1700),
  );

  @override
  Widget build(BuildContext context) {
    if (widget.isOpen) controller.forward(from: 0);
    return SlideTransition(
      position: Tween(
        begin: Offset(-2, 0),
        end: Offset(1, 0),
      ).animate(CurvedAnimation(curve: Curves.easeOutQuad, parent: controller)),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
