import 'package:evantez/app/router/router_constant.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                //
                Navigator.pushNamed(context, RouterConstants.dashboardRoute);
              },
              child:  Text(
                'Admin Side',
              ),
            ),
            InkWell(
              onTap: () {
                //
                Navigator.pushNamed(context, RouterConstants.boysDashboardRoute);
              },
              child: Text(
                'Boy Side',
              ),
            )
          ],
        ),
      ),
    );
  }
}
