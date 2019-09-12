import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{

  OpenableController informatinController;
  OpenableController commentsController;

  @override
  void initState() {
    super.initState();
    informatinController = new OpenableController(
      vsync: this, 
      openDuration: const Duration(milliseconds: 500),
    )
    ..addListener(()=> setState((){}));

    commentsController = new OpenableController(
      vsync: this, 
      openDuration: const Duration(milliseconds: 500),
    )
    ..addListener(()=> setState((){}));
  }

  @override
  void dispose() {
    informatinController.dispose();
    commentsController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            // Product
            new Product(),


            // Information
            Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    informatinController.isOpen() ? informatinController.close() : null;
                    commentsController.isOpen() ? commentsController.close() : null;
                  }
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.translate(
                    offset: Offset(0, 480*(1.0 - informatinController.percentOpen)),
                    child: new Information(controller: informatinController, commentsController: commentsController,),
                  ),
                ),


                // Comments
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.translate(
                    offset: Offset(0, 480*(1.0 - commentsController.percentOpen)),
                    child: new Comments(controller: commentsController, informationController: informatinController,),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),      
    );
  }
}

class Comments extends StatelessWidget {

  final OpenableController controller;
  final OpenableController informationController;

  double yStart;
  double yUpdate;

  Comments({this.controller, this.informationController});

  Widget commentTile(){
    return Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(backgroundColor: Colors.white24, radius: 19,),
            title: Text(
              "Name Name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14
              ),
            ),
            subtitle: Text(
              "June 27",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11
              ),
            ),
            trailing: Text(
              "40",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11
              ),
            ),
          ),
          Text(
            "Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word ",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13
            ),
          ),
          SizedBox(height: 15)
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(27, 20, 100,1.0),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                 Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 40, right: 10),
                    child: Text(
                      "Comments",
                      style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "4.0",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 195, 18,1.0)
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Color.fromRGBO(255, 195, 18,1.0),
                                size: 17,
                              ),
                              
                              Icon(
                                Icons.star,
                                color: Color.fromRGBO(255, 195, 18,1.0),
                                size: 17,
                              ),
                              Icon(
                                Icons.star,
                                color: Color.fromRGBO(255, 195, 18,1.0),
                                size: 17,
                              ),
                              Icon(
                                Icons.star,
                                color: Color.fromRGBO(255, 195, 18,1.0),
                                size: 17,
                              ),
                              Icon(
                                Icons.star,
                                color: Color.fromRGBO(48, 57, 82,1.0),
                                size: 17,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "1160",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10
                                ),
                              )

                            ],
                          ),
                          Text(
                            "Satisfactory",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          commentTile(),
                          commentTile(),
                          commentTile(),
                          
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: Offset(-200*(1.0 - controller.percentOpen), 0),
              child: Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255,0.2),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60))
                ),
                child: Center(
                  child: Text(
                    "Write a comment",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(controller.isClosed()) {
                controller.open();
                informationController.isClosed() ? informationController.open() : null;
              }
            },
            onVerticalDragStart: (coord){
              yStart = coord.globalPosition.dy;
            },
            onVerticalDragUpdate: (coord){
              yUpdate = coord.globalPosition.dy;
            },
            onVerticalDragEnd: (velocity){
              if(yUpdate-yStart > 0){
                controller.close();
                informationController.close();
              }
            },
            
          )
        ],
      ),
    );
  }
}

class Information extends StatelessWidget {

  final OpenableController controller;
  final OpenableController commentsController;
  Information({this.controller, this.commentsController});

  double yStart;
  double yUpdate;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(22, 160, 133,1.0),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 30, right: 10),
                  child: Text(
                    "Information",
                    style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(27, 20, 100,1.0)
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Something",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word vWord Word Word Word Word Word ",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Something",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word Word",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: (){
              controller.isClosed() ? controller.open() : null;
              commentsController.isOpen() ? commentsController.close() : null;             
            },
            onVerticalDragStart: (coord){
              yStart = coord.globalPosition.dy;
            },
            onVerticalDragUpdate: (coord){
              yUpdate = coord.globalPosition.dy;
            },
            onVerticalDragEnd: (velocity){
              yUpdate-yStart > 0 ? controller.close() : null;
            },

          )
        ],
      ),
    );
  }
}

class Product extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: 300,
          child: Center(child: Image.asset("assets/img.jfif",)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
            "Shoe",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "A shoe for male",
                style: TextStyle(
                  color: Colors.black45
                ),
              ),
              CircleAvatar(
                backgroundColor: Color.fromRGBO(22, 160, 133,1.0),
                child: Icon(Icons.add_circle_outline, color: Colors.white,),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
              "280 ",
              style: TextStyle(
                color: Color.fromRGBO(22, 160, 133,1.0),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "USD",
                  style: TextStyle(
                    color: Color.fromRGBO(22, 160, 133,1.0),
                    fontSize: 12,

                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),

          Text(
            "words words words words words words words words words words words words words words  \n\nwords words words words words words words words words words",
            style: TextStyle(
              color: Colors.black54,
              
            ),
            )
            ],
          ),
        )
      ],
    );
  }
}


class OpenableController extends ChangeNotifier{
  OpenableState _state = OpenableState.closed;
  AnimationController _opening;

  OpenableController({
    @required TickerProvider vsync,
    @required Duration openDuration,
  }): _opening = new AnimationController(duration: openDuration, vsync: vsync){
    _opening
    ..addListener(()=>notifyListeners())
    ..addStatusListener((AnimationStatus status){
      switch (status){
        case AnimationStatus.forward:
        _state = OpenableState.opening;
        break;
        case AnimationStatus.completed:
        _state = OpenableState.open;
        break;
        case AnimationStatus.reverse:
        _state = OpenableState.closing;
        break;
        case AnimationStatus.dismissed:
        _state = OpenableState.closed;
        break;
      }
      notifyListeners();
    });
  }

  get state => _state;

  get percentOpen => _opening.value;

  bool isOpen(){
    return _state == OpenableState.open;
  }

  bool isOpening(){
    return _state == OpenableState.opening;
  }
  bool isClosed(){
    return _state == OpenableState.closed;
  }
    
  bool isClosing(){
    return _state == OpenableState.closing;
  }

  open(){
    _opening.forward(); 
  }
  close(){
    _opening.reverse();
  }
  toggle(){
    if(isClosed()){
      open();
    } else if(isOpen()){
      close();
    }
  }


}

enum OpenableState{
  closed,
  opening,
  open,
  closing,
}