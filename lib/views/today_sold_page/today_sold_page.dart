import 'package:flutter/material.dart';
import 'package:merostore_mobile/views/add_new_sales_transaction/add_new_sales_transaction.dart';
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
                tooltip: "Store selection",
                options: const ["hello", "hi"],
                onTap: (val) {},
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            // add new transaction
            Positioned(
              right: 16,
              bottom: 16,
              child: AnimatedContainer(
                width: 58,
                height: 58,
                duration: const Duration(milliseconds: 250),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const AddNewSalesTransaction()));
                  },
                  tooltip: "Add new sales transaction",
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
