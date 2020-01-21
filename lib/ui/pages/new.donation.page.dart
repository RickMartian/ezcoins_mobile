import 'package:ezcoins_mobile/ui/components/header.title.dart';
import 'package:flutter/material.dart';

class NewDonationPage extends StatefulWidget {
  @override
  _NewDonationPageState createState() => _NewDonationPageState();
}

class _NewDonationPageState extends State<NewDonationPage>
    with TickerProviderStateMixin {
  String _currentReceiver;
  List<String> _receivers = [
    "Rafael",
    "Maykon",
    "Ítalo",
    "Gabriel",
    "Aylon",
    "Wellington"
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  DateTime _selectedDate = DateTime.now();
  AnimationController _releaseAnimationController;
  AnimationController _returnAnimationController;
  Animation<double> _releaseAnimation;
  bool _accepted = false;
  bool _canShowDonationCard = true;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = _getReceivers();
    _currentReceiver = _dropDownMenuItems[0].value;
    _releaseAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), value: 1.0, vsync: this);
    _releaseAnimation = CurvedAnimation(
        parent: _releaseAnimationController, curve: Curves.bounceInOut);
    _releaseAnimationController.addStatusListener((listener) {
      print("listener -> $listener");
      if (listener == AnimationStatus.dismissed) {
        setState(() {
          _accepted = false;
          _canShowDonationCard = true;
        });
        _releaseAnimationController.value = 1.0;
      }
    });
  }

  @override
  void dispose() {
    _returnAnimationController.dispose();
    _releaseAnimationController.dispose();
    super.dispose();
  }

  void _changeReceiver(String newReceiver) {
    setState(() {
      _currentReceiver = newReceiver;
    });
  }

  List<DropdownMenuItem<String>> _getReceivers() {
    return _receivers.map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  Future<Null> _datePicker() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2101));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  _changeAccepted(bool status) {
    setState(() {
      _accepted = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SafeArea(
          child: headerTitle("Doações"),
        ),
        Draggable(
          data: "OK!",
          maxSimultaneousDrags: 1,
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            _changeAccepted(false);
          },
          child: _canShowDonationCard
              ? donationCard(
                  false,
                  deviceWidth,
                  deviceHeight,
                  _datePicker,
                  _selectedDate,
                  _currentReceiver,
                  _changeReceiver,
                  _dropDownMenuItems,
                  _releaseAnimation)
              : Container(
                  height: deviceHeight * 0.28,
                ),
          childWhenDragging: Container(
            height: deviceHeight * 0.28,
          ),
          feedback: donationCard(
              true,
              deviceWidth,
              deviceHeight,
              _datePicker,
              _selectedDate,
              _currentReceiver,
              _changeReceiver,
              _dropDownMenuItems,
              _releaseAnimation),
        ),
        Container(
          height: deviceHeight * 2 / 5,
          color: Colors.amber,
          child: Center(
            child: DragTarget(
              builder: (BuildContext context, List<String> candidateData,
                  List<dynamic> rejectedData) {
                print("candidateData -> $candidateData");
                print("rejectedData -> $rejectedData");
                Center defaultContainer = Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    color:
                        _accepted ? Colors.blue.withOpacity(0.4) : Colors.red,
                    child: Center(
                      child: Text(_accepted ? "Accepted!" : "Not accepted!"),
                    ),
                  ),
                );

                return _accepted
                    ? Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          defaultContainer,
                          donationCard(
                              false,
                              deviceWidth,
                              deviceHeight,
                              _datePicker,
                              _selectedDate,
                              _currentReceiver,
                              _changeReceiver,
                              _dropDownMenuItems,
                              _releaseAnimation)
                        ],
                      )
                    : defaultContainer;
              },
              onWillAccept: (data) {
                return data == "OK!";
              },
              onAccept: (data) {
                print("Aceitou o card!!, enviar doação e resetar o card!!");
                _changeAccepted(true);
                setState(() {
                  _canShowDonationCard = false;
                });
                _releaseAnimationController.reverse();
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget rowSpaced(Widget firstWidget, Widget secondWidget,
    MainAxisAlignment alignType, double deviceWidth, double deviceHeight) {
  return Row(
    mainAxisAlignment: alignType,
    children: <Widget>[firstWidget, secondWidget],
  );
}

Widget donationCard(
    bool needsMaterial,
    double deviceWidth,
    double deviceHeight,
    Future<Null> _datePicker(),
    DateTime _selectedDate,
    String _currentReceiver,
    void _changeReceiver(String value),
    List<DropdownMenuItem<String>> _dropDownMenuItems,
    CurvedAnimation _animation) {
  Widget donationCardWidget;

  donationCardWidget = ScaleTransition(
    scale: _animation,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Color(0xFF454C7D),
        borderRadius: BorderRadius.circular(14.0),
      ),
      height: deviceHeight * 0.28,
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: deviceWidth * 0.8,
        decoration: BoxDecoration(
          color: Color(0xFF959ED5),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(14.0),
            bottomRight: Radius.circular(14.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () => _datePicker(),
              child: rowSpaced(
                Text(
                  "Parabéns",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  width: deviceWidth * 0.35,
                  height: deviceHeight * 0.038,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "${_selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.date_range,
                        color: Color(0xFF909090),
                        size: deviceWidth * 0.04,
                      ),
                    ],
                  ),
                ),
                MainAxisAlignment.spaceBetween,
                deviceWidth,
                deviceHeight,
              ),
            ),
            Spacer(flex: 2),
            rowSpaced(
              Container(
                alignment: Alignment.topLeft,
                height: deviceHeight * 0.038,
                child: Text(
                  "Para: ",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: deviceHeight * 0.038,
                width: deviceWidth * 0.48,
                child: DropdownButton<String>(
                  value: _currentReceiver,
                  underline: Container(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF909090),
                  ),
                  elevation: 12,
                  isExpanded: true,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                  onChanged: _changeReceiver,
                  items: _dropDownMenuItems,
                ),
              ),
              MainAxisAlignment.spaceBetween,
              deviceWidth,
              deviceHeight,
            ),
            Spacer(
              flex: 1,
            ),
            rowSpaced(
              Container(
                alignment: Alignment.topLeft,
                height: deviceHeight * 0.038 * 1.8,
                child: Text(
                  "Motivo: ",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: deviceHeight * 0.038 * 1.8,
                width: deviceWidth * 0.48,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              MainAxisAlignment.spaceBetween,
              deviceWidth,
              deviceHeight,
            ),
            Spacer(flex: 2),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: deviceWidth * 0.25,
                height: deviceHeight * 0.050,
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextField(
                  maxLength: 2,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    prefixText: "EZȻ ",
                    prefixStyle: TextStyle(
                      color: Color(0xFF909090),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );

  return !needsMaterial
      ? donationCardWidget
      : Material(
          color: Colors.transparent,
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: deviceWidth),
              child: donationCardWidget),
        );
}
