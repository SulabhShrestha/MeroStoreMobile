import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/view_models/stock_view_model.dart';
import 'package:merostore_mobile/views/add_new_stock/utils/required_marking.dart';
import 'package:merostore_mobile/views/add_new_stock/utils/stock_helper.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:merostore_mobile/views/core_widgets/custom_shadow_container.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_with_dropdownbtn.dart';
import 'package:merostore_mobile/views/core_widgets/normal_heading_for_adding_new_item.dart';

class AddNewStock extends StatefulWidget {
  const AddNewStock({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewStock> createState() => _AddNewStockState();
}

class _AddNewStockState extends State<AddNewStock> {
  String _currentTransactionType =
      ""; // Holds what the user has currently selected

  List<String> _allTransactionType = []; // Stores all the transaction type

  Map<String, TextEditingController> controllers =
      {}; // Holds the controllers for all fields

  List<Map> allFormFields = []; // Holds all the form data

  @override
  void initState() {
    _allTransactionType = StockHelper().getTransactionTypes();
    _currentTransactionType = _allTransactionType.first;
    allFormFields =
        StockHelper().getInformation(transactionType: _currentTransactionType);

    // Initialize controllers based on initial transaction type
    for (Map elem in allFormFields) {
      controllers[elem["heading"]] = TextEditingController();
    }

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
                      options: const ["Hi"],
                      tooltip: "Store selection",
                      onTap: (value) {},
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
                      options: StockHelper().getTransactionTypes(),
                      tooltip: "Transaction type selection",
                      onTap: (value) {
                        Map<String, dynamic> previousUserInput = {};

                        _currentTransactionType = value;

                        // Changing current form fields
                        setState(
                          () => allFormFields = StockHelper().getInformation(
                              transactionType: _currentTransactionType),
                        );

                        // Store the previous user input
                        for (Map elem in allFormFields) {
                          String heading = elem["heading"];
                          if (controllers.containsKey(heading)) {
                            previousUserInput[heading] =
                                controllers[heading]?.text;
                          }
                        }

                        // Clear the controllers
                        controllers.clear();

                        // Changing controllers according to form fields
                        for (Map elem in allFormFields) {
                          String heading = elem["heading"];
                          controllers[heading] = TextEditingController(
                              text: previousUserInput[heading]);
                        }
                      },
                    ),
                  ],
                ),

                ConstantSpaces.height12,

                ..._populateOptions(),

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
                    onTap: () async {
                      final userInput = _getAllDataFromTextEditingController();

                      // User didn't added required fields
                      if (userInput["redFlag"]) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Missing required fields.")));
                      }
                      // User has inserted required fields
                      else {
                        StockViewModel().addNewStock(
                          userInput: userInput["userInput"],
                          onStockAdded: () {
                            Navigator.of(context).pop();
                          },
                          onFailure: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Something went wrong.")));
                          },
                        );
                      }
                    },
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

  List<Widget> _populateOptions() {
    List<Widget> widgets = [];

    for (Map elem in allFormFields) {
      // Adding to widget
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // required heading
            if (elem["required"]) RequiredMarking(heading: elem["heading"]),

            if (elem["required"] == false)
              NormalHeadingForAddingNewItem(text: elem["heading"]),

            // TextField
            if (elem["quantityOption"] == null)
              DottedUnderlineTextField(
                controller: controllers[elem["heading"]],
                keyboardType: elem["keyboardType"] ?? TextInputType.text,
              ),

            // TextField with quantity selection option
            if (elem["quantityOption"] != null)
              DottedUnderlineTextFieldWithDropDownBtn(
                controller: controllers[elem["heading"]],
                keyboardType: elem["keyboardType"] ?? TextInputType.text,
              ),

            ConstantSpaces.height12,
          ],
        ),
      );
    }

    return widgets;
  }

  Map<String, dynamic> _getAllDataFromTextEditingController() {
    bool redFlag = false; // if user hasn't entered required fields
    Map<String, dynamic> userInput = {};
    Map<String, dynamic> details = {}; // holds all stock details

    userInput["Transaction Type"] = _currentTransactionType;
    //TODO: store name and brought quantity should also be added.

    // length of controllers and allFormFields is same.
    for (int i = 0; i < allFormFields.length; i++) {
      Map elem = allFormFields[i]; // Returning Map data of each form item
      // Getting controller using the form's heading
      TextEditingController controller = controllers[elem["heading"]]!;
      String value = controller.text;
      bool isRequired = elem["required"];

      // User has entered important field
      if (isRequired && value.isNotEmpty) {
        details[elem["heading"]] = value;
      }

      // User hasn't entered important field
      else if (isRequired && value.isEmpty) {
        redFlag = true;
        break; // No need to add since necessary field is empty
      }

      // User has entered not important field such as description
      else if (value.isNotEmpty) {
        details[elem["heading"]] = value;
      }
    }

    userInput["details"] = details;

    log(userInput.toString());
    return {
      "redFlag": redFlag,
      "userInput": userInput,
    };
  }
}