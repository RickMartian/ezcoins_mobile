import 'package:ezcoins_mobile/ui/pages/history.page.dart';
import 'package:ezcoins_mobile/ui/pages/new.donation.page.dart';
import 'package:ezcoins_mobile/ui/pages/profile.page.dart';
import 'package:flutter/material.dart';

class TabRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          bottomNavigationBar: BottomAppBar(
            color: Color(0xFF454C7D),
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.book,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.credit_card,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              HistoryPage(),
              NewDonationPage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}
