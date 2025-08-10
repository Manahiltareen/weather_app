import 'package:flutter/material.dart';
import 'my_data.dart';

class CardDetails extends StatelessWidget {
  final DummyData dummyData;
  final TextStyle titleTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 11,
    height: 1,
    letterSpacing: .2,
    fontWeight: FontWeight.w600,
    color: Color(0xffafafaf),
  );
  final TextStyle contentTextStyle = TextStyle(
    fontFamily: 'Oswald',
    fontSize: 16,
    height: 1.8,
    letterSpacing: .3,
    color: Color(0xff083e64),
  );

  CardDetails(this.dummyData, {super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.0),
    ),
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              dummyData.data.entries.map<Widget>((entry) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(entry.key.toUpperCase(), style: titleTextStyle),
                      Text(entry.value.toString(), style: contentTextStyle),
                    ],
                  ),
                );
              }).toList(),
        ),
        // my bio/text section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            dummyData.bio,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12,
              height: 1.8,
              letterSpacing: .3,
              color: Color(0xff083e64),
            ),
          ),
        ),
      ],
    ),
  );
}
