import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';

class RentSpecifications extends StatefulWidget {
  const RentSpecifications({super.key});

  @override
  State<RentSpecifications> createState() => _RentSpecificationsState();
}

class _RentSpecificationsState extends State<RentSpecifications> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController __pickupLocationController = TextEditingController();
  TextEditingController _ReturnLocationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Date & Time")),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("Select Start Date",
                      style: TextStyle(
                          color: TColors.primary, fontSize: TSizes.fontSizeMd),
                      textAlign: TextAlign.left),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This is required";
                      }
                    },
                    controller: _startDateController,
                    readOnly: true,
                    cursorColor: const Color.fromARGB(
                      255,
                      208,
                      128,
                      9,
                    ),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final DateTime? _startDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate:
                                      DateTime(2070).add(Duration(days: 365)));

                              final _fstartDate =
                                  DateFormat("dd-MM-yyyy").format(_startDate!);
                              setState(() {
                                _startDateController.text =
                                    _fstartDate.toString();
                              });
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: TColors.primary,
                            )),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        hintText: "Start Date",
                        hintStyle: TextStyle(
                            color: dark ? TColors.white : TColors.primary),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: TColors.darkGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: dark ? TColors.white : TColors.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select Start Time",
                      style: TextStyle(
                          color: TColors.primary, fontSize: TSizes.fontSizeMd),
                      textAlign: TextAlign.left),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This is required";
                      }
                    },
                    controller: _startTimeController,
                    readOnly: true,
                    cursorColor: const Color.fromARGB(
                      255,
                      208,
                      128,
                      9,
                    ),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? _startTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              setState(() {
                                _startTimeController.text =
                                    _startTime!.format(context);
                              });
                            },
                            icon: Icon(
                              Icons.timer_outlined,
                              color: TColors.primary,
                            )),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        hintText: "Start Time",
                        hintStyle: TextStyle(
                            color: dark ? TColors.white : TColors.primary),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: TColors.darkGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: dark ? TColors.white : TColors.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select End Date",
                      style: TextStyle(
                          color: TColors.primary, fontSize: TSizes.fontSizeMd),
                      textAlign: TextAlign.left),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This is required";
                      }
                    },
                    controller: _endDateController,
                    readOnly: true,
                    cursorColor: const Color.fromARGB(
                      255,
                      208,
                      128,
                      9,
                    ),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final DateTime? _endDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate:
                                      DateTime(2070).add(Duration(days: 365)));

                              final _fendDate =
                                  DateFormat("dd-MM-yyyy").format(_endDate!);
                              setState(() {
                                _endDateController.text = _fendDate.toString();
                              });
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: TColors.primary,
                            )),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        hintText: "End Date",
                        hintStyle: TextStyle(
                            color: dark ? TColors.white : TColors.primary),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: TColors.darkGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: dark ? TColors.white : TColors.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select End Time",
                      style: TextStyle(
                          color: TColors.primary, fontSize: TSizes.fontSizeMd),
                      textAlign: TextAlign.left),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This is required";
                      }
                    },
                    controller: _endTimeController,
                    readOnly: true,
                    cursorColor: const Color.fromARGB(
                      255,
                      208,
                      128,
                      9,
                    ),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? _endTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              setState(() {
                                _endTimeController.text =
                                    _endTime!.format(context);
                              });
                            },
                            icon: Icon(
                              Icons.timer_outlined,
                              color: TColors.primary,
                            )),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        hintText: "End Time",
                        hintStyle: TextStyle(
                            color: dark ? TColors.white : TColors.primary),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: TColors.darkGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: dark ? TColors.white : TColors.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select Pickup Location",
                      style: TextStyle(
                          color: TColors.primary, fontSize: TSizes.fontSizeMd),
                      textAlign: TextAlign.left),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This is required";
                      }
                    },
                    controller: __pickupLocationController,
                    readOnly: true,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? _startTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              setState(() {
                                _startTimeController.text =
                                    _startTime!.format(context);
                              });
                            },
                            icon: Icon(
                              Icons.location_on_rounded,
                              color: TColors.primary,
                            )),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        hintText: "Pickup Location",
                        hintStyle: TextStyle(
                            color: dark ? TColors.white : TColors.primary),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: TColors.darkGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: dark ? TColors.white : TColors.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select Return Location",
                      style: TextStyle(
                          color: TColors.primary, fontSize: TSizes.fontSizeMd),
                      textAlign: TextAlign.left),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This is required";
                      }
                    },
                    controller: _ReturnLocationController,
                    readOnly: true,
                    cursorColor: const Color.fromARGB(
                      255,
                      208,
                      128,
                      9,
                    ),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? _startTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              setState(() {
                                _startTimeController.text =
                                    _startTime!.format(context);
                              });
                            },
                            icon: Icon(
                              Icons.location_on_rounded,
                              color: TColors.primary,
                            )),
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Return Location",
                        hintStyle: TextStyle(
                            color: dark ? TColors.white : TColors.primary),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: TColors.darkGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: dark ? TColors.white : TColors.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Get.to(() => const RentSpecifications()),
                          child: Text("Rent Vehicle"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
