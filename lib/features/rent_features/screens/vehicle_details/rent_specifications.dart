import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:karconnect/features/dashboard/dashbord.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/booking_summery.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';

import '../../../../backend/data_store/book_vehicle_backend.dart';

class RentSpecifications extends StatefulWidget {
  final String VehicleID;
  final String Vehicle_model;
  final int Price;

  const RentSpecifications(
      {super.key,
      required this.VehicleID,
      required this.Vehicle_model,
      required this.Price});

  @override
  State<RentSpecifications> createState() => _RentSpecificationsState();
}

class _RentSpecificationsState extends State<RentSpecifications> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  final DateFormat _timeFormat = DateFormat("hh:mm a");

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _startDateController.addListener(() {
      _formatDateField(_startDateController, _dateFormat);
    });
    _startTimeController.addListener(() {
      _formatTimeField(_startTimeController, _timeFormat);
    });
    _endDateController.addListener(() {
      _formatDateField(_endDateController, _dateFormat);
    });
    _endTimeController.addListener(() {
      _formatTimeField(_endTimeController, _timeFormat);
    });
  }

  void _formatDateField(TextEditingController controller, DateFormat format) {
    String input = controller.text;
    try {
      DateTime date = format.parseStrict(input);
      controller.text = format.format(date);
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    } catch (e) {
      // Handle formatting error if needed
    }
  }

  void _formatTimeField(TextEditingController controller, DateFormat format) {
    String input = controller.text;
    try {
      TimeOfDay time = TimeOfDay(
        hour: int.parse(input.split(":")[0]),
        minute: int.parse(input.split(":")[1].split(" ")[0]),
      );
      controller.text = format.format(
        DateTime(0, 0, 0, time.hour, time.minute),
      );
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    } catch (e) {
      // Handle formatting error if needed
    }
  }

  bool _isEndDateGreaterThanStartDate() {
    try {
      DateTime startDate = _dateFormat.parse(_startDateController.text);
      DateTime endDate = _dateFormat.parse(_endDateController.text);
      return endDate.isAfter(startDate);
    } catch (e) {
      return false; // Handle parsing error
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final textTheme = Theme.of(context).textTheme;
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Book Vehicle",
          style: TextStyle(fontSize: 20),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Select Start Date",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              // Select Start Date
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !isValidDate(value, "dd-MM-yyyy")) {
                    return "Please enter a valid date (dd-MM-yyyy)";
                  }
                },
                controller: _startDateController,
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

                          if (_startDate != null) {
                            final _fstartDate = _dateFormat.format(_startDate);
                            setState(() {
                              _startDateController.text = _fstartDate;
                            });
                          }
                        },
                        icon: const Icon(
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
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey), // Color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: TColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text("Select Start Time",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left),
              ),
              // Select Start Time
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !isValidTime(value)) {
                    return "Please enter a valid time (hh:mm a)";
                  }
                },
                controller: _startTimeController,
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
                              context: context, initialTime: TimeOfDay.now());
                          if (_startTime != null) {
                            setState(() {
                              _startTimeController.text = _timeFormat.format(
                                DateTime(0, 0, 0, _startTime.hour,
                                    _startTime.minute),
                              );
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.timer_outlined,
                          color: TColors.primary,
                        )),
                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    hintText: "HH : MM AM",
                    hintStyle: TextStyle(
                        color: dark ? TColors.white : TColors.primary),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey), // Color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: TColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Select End Date",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              // Select End Date
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !isValidDate(value, "dd-MM-yyyy")) {
                    return "Please enter a valid date (dd-MM-yyyy)";
                  }
                },
                controller: _endDateController,
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

                          if (_endDate != null) {
                            final _fendDate = _dateFormat.format(_endDate);
                            setState(() {
                              _endDateController.text = _fendDate;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: TColors.primary,
                        )),
                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    hintText: "DD-MM-YYYY",
                    hintStyle: TextStyle(
                        color: dark ? TColors.white : TColors.primary),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey), // Color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: TColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text("Select End Time",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left),
              ),
              // Select End Time
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !isValidTime(value)) {
                    return "Please enter a valid time (hh:mm a)";
                  }
                },
                controller: _endTimeController,
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
                              context: context, initialTime: TimeOfDay.now());
                          if (_endTime != null) {
                            setState(() {
                              _endTimeController.text = _timeFormat.format(
                                DateTime(
                                    0, 0, 0, _endTime.hour, _endTime.minute),
                              );
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.timer_outlined,
                          color: TColors.primary,
                        )),
                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    hintText: "HH : MM AM",
                    hintStyle: TextStyle(
                        color: dark ? TColors.white : TColors.primary),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey), // Color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: TColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final start_date = _startDateController.text;
                    final end_date = _endDateController.text;
                    final start_time = _startTimeController.text;
                    final end_time = _endTimeController.text;

                    if (start_time.isEmpty ||
                        end_time.isEmpty ||
                        start_date.isEmpty ||
                        end_date.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Fill Required Data Fields Correctly',
                        backgroundColor: Color.fromARGB(92, 240, 240, 240),
                        icon: const Icon(
                          Icons.warning,
                          color: Color.fromARGB(225, 251, 3, 3),
                        ),
                      );
                    } else if (!_isEndDateGreaterThanStartDate()) {
                      Get.snackbar(
                        'Error',
                        'End Date must be greater than Start Date',
                        backgroundColor: Color.fromARGB(92, 240, 240, 240),
                        icon: const Icon(
                          Icons.warning,
                          color: Color.fromARGB(225, 251, 3, 3),
                        ),
                      );
                    } else {
                      String pickupDateTime = formatDateTime(
                          _startDateController, _startTimeController);
                      String dropoffDateTime = formatDateTime(
                          _endDateController, _endTimeController);
                      int days =
                          getDayCount(_startDateController, _endDateController);

                      Get.to(
                        () => BookingConfirmationPage(
                          VehicleID: widget.VehicleID,
                          pickupDateTime: pickupDateTime,
                          pickupLocation: 'Colombo ',
                          dropoffDateTime: dropoffDateTime,
                          dropoffLocation: 'Colombo ',
                          carPrice: (widget.Price) * days,
                          carModel: widget.Vehicle_model,
                          seats: 4,
                          transmission: 'Automatic',
                          largeBags: 1,
                          smallBags: 1,
                          unlimitedMileage: true,
                          driverIncluded: true,
                          startDate: _startDateController.text,
                          startTime: _startTimeController.text,
                          endDate: _endDateController.text,
                          endTime: _endTimeController.text,
                        ),
                      );
                    }
                  },
                  child: Text("Rent Vehicle"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidDate(String value, String format) {
    try {
      DateFormat(format).parseStrict(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool isValidTime(String value) {
    try {
      _timeFormat.parseStrict(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}

String formatDateTime(TextEditingController dateController,
    TextEditingController timeController) {
  try {
    // Parse the date and time from the controllers
    DateTime date = DateFormat("dd-MM-yyyy").parseStrict(dateController.text);
    DateTime time = DateFormat("hh:mm a").parseStrict(timeController.text);

    // Combine date and time
    DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    // Format the combined datetime to '26 Aug, 10:00'
    String formattedDate = DateFormat("d MMM, hh:mm").format(combinedDateTime);

    return formattedDate;
  } catch (e) {
    return "Invalid date or time format";
  }
}

int getDayCount(TextEditingController startDateController,
    TextEditingController endDateController) {
  try {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");

    DateTime startDate = dateFormat.parse(startDateController.text);
    DateTime endDate = dateFormat.parse(endDateController.text);

    // Calculate the difference in days
    int dayCount = endDate.difference(startDate).inDays;
    return dayCount > 0 ? dayCount : 0;
  } catch (e) {
    return 0;
  }
}
