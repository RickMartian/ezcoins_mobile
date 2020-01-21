import 'package:ezcoins_mobile/ui/components/donation.text.dart';
import 'package:ezcoins_mobile/ui/components/header.title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        SafeArea(
          child: headerTitle("Histórico"),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: deviceHeight * 0.1,
                  decoration: BoxDecoration(
                    color: Color(0xFFD2D6EF),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              width: deviceHeight * 0.08,
                              height: deviceHeight * 0.08,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://www.rbsdirect.com.br/imagesrc/25265801.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              child: donationText("Fulano", "Ciclano"),
                              margin: EdgeInsets.only(left: 10.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color(0xFF959ED5),
                        ),
                        width: deviceHeight * 0.070,
                        height: deviceHeight * 0.070,
                        child: Center(
                          child: Text(
                            "$index",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
