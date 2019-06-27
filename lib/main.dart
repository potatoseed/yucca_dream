import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const cardColor = Color(0xFF938881);
const buttonTextColor = Colors.white;
// This height will allow for all the Card's content to fit comfortably within the card.
const double cardHeight = 258.0;
const ShapeBorder shapeBroader = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(8.0),
    topRight: Radius.circular(8.0),
    bottomLeft: Radius.circular(8.0),
    bottomRight: Radius.circular(8.0),
  ),
);

//const ShapeBorder shapeBroader = CircleBorder(side: BorderSide.none);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yucca Dream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Yucca Dream'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey[700],
      ),
      backgroundColor: Colors.grey,
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          children: MainFeatureList.map<Widget>((MainFeature mainFeature) {
            Widget child;
            child = MainFeatureItem(
              mainFeature: mainFeature,
              shape: shapeBroader,
            );

            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: child,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MainFeature {
  const MainFeature({
    @required this.assetName,
    @required this.inkText,
    @required this.featureName,
    @required this.buttonName,
  })  : assert(assetName != null),
        assert(featureName != null),
        assert(inkText != null);

  final String assetName;
  final String inkText;
  final String featureName;
  final String buttonName;
}

const List<MainFeature> MainFeatureList = <MainFeature>[
  MainFeature(
      assetName: 'images/build_dream_1.jpg',
      inkText: 'Test ink text',
      featureName: 'BUILD YOUR DREAM',
      buttonName: 'BUILD YOUR DREAM'),
  MainFeature(
      assetName: 'images/goto_dream1.jpg',
      inkText: 'Test ink text',
      featureName: 'Go To Your Dream',
      buttonName: 'GO TO YOUR DREAM'),
];

class MainFeatureContent extends StatelessWidget {
  const MainFeatureContent({Key key, @required this.mainFeature})
      : assert(mainFeature != null),
        super(key: key);

  final MainFeature mainFeature;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    final List<Widget> children = <Widget>[
      // Photo and title.
      SizedBox(
        height: 184.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              // In order to have the ink splash appear above the image, you
              // must use Ink.image. This allows the image to be painted as part
              // of the Material and display ink effects above it. Using a
              // standard Image will obscure the ink splash.
              child: Ink.image(
                image: AssetImage(mainFeature.assetName),
                fit: BoxFit.cover,
                child: Container(),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  mainFeature.inkText,
                  style: titleStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      // Description and buttons.
//      Padding(
//        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
//        child: DefaultTextStyle(
//          softWrap: false,
//          overflow: TextOverflow.ellipsis,
//          style: descriptionStyle,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              // can add more line text
//              Padding(
//                padding: const EdgeInsets.only(bottom: 8.0),
//                child: Text(
//                  mainFeature.featureName,
//                  style: descriptionStyle.copyWith(color: Colors.black54),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
    ];

    children.add(
      // buttons
      ButtonTheme.bar(
        child: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Text(
                mainFeature.buttonName,
                semanticsLabel: 'Share ${mainFeature.inkText}',
                style: TextStyle(fontSize: 20.0, fontFamily: 'Questrial'),
              ),
//              textColor: Colors.amber.shade500,
              textColor: buttonTextColor,
              onPressed: () {
                print('pressed');
              },
            ),
//            FlatButton(
//              child: Text('EXPLORE',
//                  semanticsLabel: 'Explore ${mainFeature.inkText}'),
//              textColor: Colors.amber.shade500,
//              onPressed: () {
//                print('pressed');
//              },
//            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class MainFeatureItem extends StatelessWidget {
  MainFeatureItem({Key key, @required this.mainFeature, this.shape})
      : assert(mainFeature != null),
        super(key: key);

  final MainFeature mainFeature;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: cardHeight,
              child: Card(
                color: cardColor,
                // This ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: MainFeatureContent(mainFeature: mainFeature),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Expanded(
//child: Container(
//margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
//child: CircleAvatar(
//maxRadius: double.infinity,
//minRadius: 100.0,
//backgroundImage: AssetImage('images/build_dream_1.jpg'),
//),
//),
//),
//Container(
//margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//child: Row(
//children: <Widget>[
//Icon(
//Icons.redeem,
//size: 24,
//color: Colors.teal,
//),
//SizedBox(
//width: 16,
//),
//Text(
//'Build your Dream',
//style: TextStyle(
//fontFamily: 'Questrial',
//fontSize: 24.0,
//color: Colors.white),
//),
//],
//),
//),
//SizedBox(
//height: 16,
//),
//Expanded(
//child: Card(
//elevation: 8,
//margin: EdgeInsets.all(16),
//child: Image(
//image: AssetImage('images/goto_dream1.jpg'),
//),
//),
//),
//ListTile(
//leading: Icon(
//Icons.forward,
//size: 24,
//color: Colors.teal,
//),
//title: Text(
//'Go To Your Dream',
//style: TextStyle(
//fontFamily: 'Questrial',
//fontSize: 24.0,
//color: Colors.white),
//),
//),
//Text(
//'You have pushed the button this many times:',
//),
//Text(
//'$_counter',
//style: Theme.of(context).textTheme.display1,
//),
//],
