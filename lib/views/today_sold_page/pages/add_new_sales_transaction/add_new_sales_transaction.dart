import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:merostore_mobile/providers/all_sales_provider.dart';
import 'package:merostore_mobile/providers/filter_sales_provider.dart';
import 'package:merostore_mobile/providers/filter_stocks_provider.dart';
import 'package:merostore_mobile/providers/today_sales_provider.dart';
import 'package:merostore_mobile/providers/stock_provider.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/messages_constant.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/view_models/sales_view_model.dart';
import 'package:merostore_mobile/view_models/stock_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:merostore_mobile/views/core_widgets/custom_text_button.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_.dart';
import 'package:merostore_mobile/views/core_widgets/dotted_underline_textfield_with_dropdownbtn.dart';
import 'package:merostore_mobile/views/core_widgets/normal_heading_for_adding_new_item.dart';
import 'package:merostore_mobile/views/core_widgets/snackbar_message.dart';

import 'package:merostore_mobile/views/instock_page/pages/add_new_stock/widgets/required_marking.dart';
import 'package:merostore_mobile/views/instock_page/utils/stock_helper.dart';
import 'package:merostore_mobile/views/today_sold_page/utils/sales_helper.dart';

import 'widgets/textfield_with_suggestions.dart';

class AddNewSalesTransaction extends ConsumerStatefulWidget {
  const AddNewSalesTransaction({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddNewSalesTransaction> createState() =>
      _AddNewSalesTransactionState();
}

class _AddNewSalesTransactionState
    extends ConsumerState<AddNewSalesTransaction> {
  String _currentStoreName = "";

  // Transaction type related
  String _currentTransactionType = "";
  List<String> _allTransactionTypes = [];

  // quantity type related
  String _currentQuantityType = "";
  List<String> _allBroughtQuantities = [];

  Map<String, TextEditingController> controllers =
      {}; // Holds the controllers for all fields

  List<Map> allFormFields = []; // Holds all the form data

  // Store provider reference
  late StoreNotifier storesProv;
  late StocksNotifier stocksProv;

  @override
  void initState() {
    // initializing provider
    storesProv = ref.read(storesProvider.notifier);
    stocksProv = ref.read(stocksProvider.notifier);

    // current store name
    _currentStoreName = storesProv.allStoresNames.first;

    // Transaction types
    _allTransactionTypes = StockHelper().getTransactionTypes();
    _currentTransactionType = _allTransactionTypes.first;

    // Handling related to form data
    allFormFields =
        SalesHelper().getInformation(transactionType: _currentTransactionType);

    // Initialize controllers based on initial transaction type
    for (Map elem in allFormFields) {
      controllers[elem["heading"]] = TextEditingController();
    }

    // Brought quantity type
    _allBroughtQuantities =
        storesProv.allQuantityTypes(storeName: _currentStoreName);
    _currentQuantityType = _allBroughtQuantities.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: StockViewModel()
                .getAllMaterialNames(storeName: _currentStoreName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error occurred"));
              } else {
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
                              initialValue: _currentStoreName,
                              tooltip: "Store selection",
                              onTap: (storeName) {
                                Map<String, dynamic> previousUserInput = {};
                                setState(() {
                                  _currentStoreName = storeName;
                                  // changing transaction type related
                                  _allTransactionTypes =
                                      storesProv.allTransactionTypes(
                                          storeName: _currentStoreName);
                                  _currentTransactionType =
                                      _allTransactionTypes.first;

                                  // changing displaying fields
                                  allFormFields = SalesHelper().getInformation(
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
                                    controllers[heading] =
                                        TextEditingController(
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

                        ..._populateOptions(stocksProv
                            .getMaterialNamesByStore(_currentStoreName)),

                        // Today's date
                        Row(
                          children: [
                            Icon(
                              Icons.today_outlined,
                              color: ConstantAppColors.primaryColor
                                  .withOpacity(0.6),
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
                                SnackBarMessage().showMessage(
                                    context, userInput["flagDesc"]);
                              }
                              // User has inserted required fields
                              else {
                                SalesViewModel()
                                    .addNewSales(
                                  userInput: userInput["salesRecord"],
                                )
                                    .then((value) {
                                  ref
                                      .watch(todaySalesProvider.notifier)
                                      .addSales(value);
                                  ref
                                      .watch(allSalesProvider.notifier)
                                      .addSales(value);
                                  ref
                                      .watch(filteredSalesProvider.notifier)
                                      .filterSales();
                                  Navigator.of(context).pop(
                                      true); // indicating data is successfully saved
                                }).onError((error, stackTrace) {
                                  SnackBarMessage()
                                      .showMessage(context, error.toString());
                                });
                              }
                            },
                          ),
                        ),

                        ConstantSpaces.height16,
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  List<Widget> _populateOptions(List<String> textSuggestions) {
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

            // material name
            if (elem["heading"] == "Material Name")
              TextFieldWithSuggestions(
                suggestions: textSuggestions,
                controller: controllers[elem["heading"]],
              ),

            // TextField
            if (elem["quantityOption"] == null &&
                elem['heading'] != "Material Name")
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

    Map<String, dynamic> salesRecord = {};
    Map<String, dynamic> details = {}; // holds all sales details

    salesRecord["transactionType"] = _currentTransactionType;
    salesRecord["storeName"] = _currentStoreName;

    details["soldQuantityType"] = _currentQuantityType;

    // length of controllers and allFormFields is same.
    for (int i = 0; i < allFormFields.length; i++) {
      Map elem = allFormFields[i]; // Returning Map data of each form item
      // Getting controller using the form's heading
      TextEditingController controller = controllers[elem["heading"]]!;
      String value = controller.text;
      bool isRequired = elem["required"];

      // Trying to convert to it's defined data type from string
      if (elem["dataType"] != String) {
        if (elem["dataType"] == int) {
          try {
            int data = int.parse(value);

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
        } else if (elem["dataType"] == double) {
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

    salesRecord["details"] = details;

    log(salesRecord.toString());
    return {
      "redFlag": redFlag,
      "flagDesc": flagDesc,
      "salesRecord": salesRecord,
    };
  }
}
