import 'package:flutter/material.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';

class TodaySoldPage extends StatelessWidget {
  const TodaySoldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              flexibleSpace: CustomDropDownBtn(
                options: const ["hello", "hi"],
                onTap: (val) {},
              ),
            ),
          ];
        },
        body: const Center(
          child: Text("Today"),
        ),
      ),
    );
  }
}
