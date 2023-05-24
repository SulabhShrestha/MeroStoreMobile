import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merostore_mobile/models/stores.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/views/add_new_sales_transaction/utils/sales_helper.dart';
import 'package:merostore_mobile/views/add_new_stock/utils/required_marking.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:merostore_mobile/views/core_widgets/custom_shadow_container.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_with_dropdownbtn.dart';
import 'package:merostore_mobile/views/core_widgets/normal_heading_for_adding_new_item.dart';

class AddNewSalesTransaction extends StatefulWidget {
  final Stores stores;
  const AddNewSalesTransaction({
    Key? key,
    required this.stores,
  }) : super(key: key);

  @override
  State<AddNewSalesTransaction> createState() => _AddNewSalesTransactionState();
}

class _AddNewSalesTransactionState extends State<AddNewSalesTransaction> {
  String _currentTransactionType =
      ""; // Holds what the user has currently selected

  List<String> _allTransactionType = []; // Stores all the transaction type

  String _currentStoreName = "";

  @override
  void initState() {
    _allTransactionType = SalesHelper().getTransactionTypes();
    _currentTransactionType = _allTransactionType.first;
    _currentStoreName = widget.stores.allStoresNames.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomBox(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),

          // wrapping with scroll view since max height is used
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // store name
                Row(
                  children: [
                    Text(
                      "Store Names:",
                      style: ConstantTextStyles.normalStyle20.copyWith(
                        color: ConstantAppColors.primaryColor.withOpacity(0.6),
                      ),
                    ),
                    CustomDropDownBtn(
                      options: widget.stores.allStoresNames,
                      tooltip: "Store selection",
                      onTap: (value) {
                        setState(() {
                          _currentStoreName = value;
                        });
                      },
                    ),
                  ],
                ),

                ConstantSpaces.height12,

                // Transaction type
                Row(
                  children: [
                    Text(
                      "Transaction Type:",
                      style: ConstantTextStyles.normalStyle20.copyWith(
                        color: ConstantAppColors.primaryColor.withOpacity(0.6),
                      ),
                    ),
                    CustomDropDownBtn(
                      options: widget.stores
                          .allTransactionTypes(storeName: _currentStoreName),
                      tooltip: "Transaction type selection",
                      onTap: (value) {
                        setState(() => _currentTransactionType = value);
                      },
                    ),
                  ],
                ),

                ConstantSpaces.height12,

                for (Map elem in SalesHelper()
                    .getInformation(transactionType: _currentTransactionType))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // required heading
                      if (elem["required"])
                        RequiredMarking(heading: elem["heading"]),

                      if (elem["required"] == false)
                        NormalHeadingForAddingNewItem(text: elem["heading"]),

                      // textfield
                      if (elem["quantityOption"] == null)
                        DottedUnderlineTextField(
                          controller: TextEditingController(),
                          keyboardType:
                              elem["keyboardType"] ?? TextInputType.text,
                        ),

                      // textfield with quantity selection option
                      if (elem["quantityOption"] != null)
                        DottedUnderlineTextFieldWithDropDownBtn(
                          keyboardType:
                              elem["keyboardType"] ?? TextInputType.text,
                          quantityTypes: widget.stores
                              .allQuantityTypes(storeName: _currentStoreName),
                        ),

                      ConstantSpaces.height12,
                    ],
                  ),

                // Today's date
                Row(
                  children: [
                    Icon(
                      Icons.today_outlined,
                      color: ConstantAppColors.primaryColor.withOpacity(0.6),
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd")
                          .format(DateTime.now())
                          .toString(),
                      style: ConstantTextStyles.normalStyle20.copyWith(
                        color: ConstantAppColors.primaryColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),

                ConstantSpaces.height20,

                // submit button
                Align(
                  alignment: Alignment.center,
                  child: CustomShadowContainer(
                    onTap: () {},
                    height: 42,
                    width: 96,
                    foregroundColor: ConstantAppColors.greenColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: ConstantAppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                ConstantSpaces.height16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
