import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:merostore_mobile/providers/currently_selected_store_provider.dart';
import 'package:merostore_mobile/providers/filter_stocks_provider.dart';
import 'package:merostore_mobile/providers/stock_provider.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/messages_constant.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/view_models/stock_view_model.dart';
import 'package:merostore_mobile/view_models/store_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:merostore_mobile/views/core_widgets/custom_text_button.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_with_dropdownbtn.dart';
import 'package:merostore_mobile/views/core_widgets/normal_heading_for_adding_new_item.dart';
import 'package:merostore_mobile/views/core_widgets/snackbar_message.dart';

import 'widgets/required_marking.dart';
import "../../utils/stock_helper.dart";

class AddNewStock extends ConsumerStatefulWidget {
  const AddNewStock({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddNewStock> createState() => _AddNewStockState();
}

class _AddNewStockState extends ConsumerState<AddNewStock> {
  String _currentStoreName = "";

  // Transaction type related
  String _currentTransactionType = "";
  List<String> _allTransactionTypes = ["Cash", "Credit"];

  // quantity type related
  String _currentQuantityType = "";
  List<String> _allBroughtQuantities = [];

  Map<String, TextEditingController> controllers =
      {}; // Holds the controllers for all fields

  List<Map> allFormFields = []; // Holds all the form data

  // Store provider reference
  late StoreNotifier storesProv;

  @override
  void initState() {
    super.initState();
    storesProv = ref.read(storesProvider.notifier);
    _currentStoreName = storesProv.allStoresNames.first;

    // Transaction types
    _currentTransactionType = _allTransactionTypes.first;

    // Handling related to form data
    allFormFields =
        StockHelper().getInformation(transactionType: _currentTransactionType);

    // Initialize controllers based on initial transaction type
    for (Map elem in allFormFields) {
      controllers[elem["heading"]] = TextEditingController();
    }

    // Brought quantity type
    _allBroughtQuantities =
        storesProv.allQuantityTypes(storeName: _currentStoreName);
    _currentQuantityType = _allBroughtQuantities.first;
  }

  @override
  Widget build(BuildContext context) {
    StocksNotifier stocksProv = ref.read(stocksProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: StoreViewModel().getAllStores(),
            builder: (context, snapshot) {
              return CustomBox(
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
                              color: ConstantAppColors.primaryColor
                                  .withOpacity(0.6),
                            ),
                          ),
                          CustomDropDownBtn(
                            options: storesProv.allStoresNames,
                            tooltip: "Store selection",
                            initialValue: ref
                                .read(currentlySelectedStoreProvider)["stock"],
                            onTap: (storeName) {
                              Map<String, dynamic> previousUserInput =
                                  {}; // for storing previously added data
                              setState(() {
                                _currentStoreName = storeName;
                                // changing transaction type related
                                _allTransactionTypes =
                                    storesProv.allTransactionTypes(
                                        storeName: _currentStoreName);
                                _currentTransactionType =
                                    _allTransactionTypes.first;

                                // changing displaying fields
                                allFormFields = StockHelper().getInformation(
                                    transactionType: _currentTransactionType);

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

                                // changing brought quantity related
                                _allBroughtQuantities =
                                    storesProv.allQuantityTypes(
                                        storeName: _currentStoreName);
                                _currentQuantityType =
                                    _allBroughtQuantities.first;
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
                              color: ConstantAppColors.primaryColor
                                  .withOpacity(0.6),
                            ),
                          ),
                          CustomDropDownBtn(
                            options: _allTransactionTypes,
                            tooltip: "Transaction type selection",
                            initialValue: _currentTransactionType,
                            onTap: (value) {
                              Map<String, dynamic> previousUserInput = {};

                              _currentTransactionType = value;

                              // Changing current form fields
                              setState(
                                () => allFormFields = StockHelper()
                                    .getInformation(
                                        transactionType:
                                            _currentTransactionType),
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
                            color:
                                ConstantAppColors.primaryColor.withOpacity(0.6),
                          ),
                          Text(
                            DateFormat("yyyy-MM-dd")
                                .format(DateTime.now())
                                .toString(),
                            style: ConstantTextStyles.normalStyle20.copyWith(
                              color: ConstantAppColors.primaryColor
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),

                      ConstantSpaces.height20,

                      // submit button
                      Align(
                        alignment: Alignment.center,
                        child: CustomTextButton(
                          text: "Submit",
                          onTap: () async {
                            final userInput = _getAllDataFromUserInputs();

                            // User didn't added required fields
                            if (userInput["redFlag"]) {
                              SnackBarMessage()
                                  .showMessage(context, userInput["flagDesc"]);
                            }
                            // User has inserted required fields
                            else {
                              StockViewModel().addNewStock(
                                userInput: userInput["userInput"],
                                onStockAdded: (addedStock) {
                                  stocksProv.addStock(addedStock);
                                  ref
                                      .read(filteredStocksProvider.notifier)
                                      .filterStocks();
                                  SnackBarMessage().showMessage(
                                      context, "Stock added successfully.");
                                  Navigator.of(context).pop();
                                },
                                onUpdated: (updatedStock) {
                                  stocksProv.updateStockById(
                                      id: updatedStock["_id"],
                                      data: updatedStock);
                                  ref
                                      .read(filteredStocksProvider.notifier)
                                      .filterStocks();
                                  Navigator.of(context).pop();
                                  SnackBarMessage().showMessage(
                                      context, "Stock updated successfully.");
                                },
                                onFailure: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(MessagesConstant()
                                              .somethingWentWrong)));
                                },
                              );
                            }
                          },
                        ),
                      ),

                      ConstantSpaces.height16,
                    ],
                  ),
                ),
              );
            }),
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
                initialSelectedValue: _currentQuantityType,
                keyboardType: elem["keyboardType"] ?? TextInputType.text,
                quantityTypes: _allBroughtQuantities,
                onSelected: (newQuantityType) {
                  _currentQuantityType = newQuantityType;
                },
              ),

            ConstantSpaces.height12,
          ],
        ),
      );
    }

    return widgets;
  }

  Map<String, dynamic> _getAllDataFromUserInputs() {
    bool redFlag = false; // if user hasn't entered required fields
    String flagDesc = ""; // cause of red flag

    Map<String, dynamic> userInput = {};
    Map<String, dynamic> details = {}; // holds all stock details

    userInput["transactionType"] = _currentTransactionType;
    userInput["storeName"] = _currentStoreName;

    details["broughtQuantityType"] = _currentQuantityType;

    // length of controllers and allFormFields is same.
    for (int i = 0; i < allFormFields.length; i++) {
      Map elem = allFormFields[i]; // Returning Map data of each form item

      // Getting controller using the form's heading
      TextEditingController controller = controllers[elem["heading"]]!;
      String value = controller.text;
      bool isRequired = elem["required"];

      // Trying to convert to it's defined data type from string
      if (elem["dataType"] != String) {
        try {
          double data = double.parse(value);

          // User has entered negative value
          if (data < 0) {
            redFlag = true;
            flagDesc = MessagesConstant().invalidPrice;
            break;
          }
          details[elem["fieldName"]] = data;

          continue; // No need to check other conditions
        } catch (e) {
          redFlag = true;
          flagDesc = MessagesConstant().invalidQuantity;
          break;
        }
      }

      // User has entered important field
      if (isRequired && value.isNotEmpty) {
        details[elem["fieldName"]] = value;
      }

      // User hasn't entered important field
      else if (isRequired && value.isEmpty) {
        redFlag = true;
        flagDesc = MessagesConstant().missingRequiredFields;
        break; // No need to add since necessary field is empty
      }

      // User has entered not important field such as description
      else if (value.isNotEmpty) {
        details[elem["fieldName"]] = value;
      }
    }

    userInput["details"] = details;

    log(userInput.toString());
    return {
      "redFlag": redFlag,
      "flagDesc": flagDesc,
      "userInput": userInput,
    };
  }
}
