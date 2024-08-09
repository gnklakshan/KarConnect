import 'package:flutter/material.dart';
import 'package:karconnect/features/Search_filter/widgets/search_result.dart';

class SearchVehicle extends StatefulWidget {
  const SearchVehicle({super.key});

  @override
  State<SearchVehicle> createState() => _SearchVehicleState();
}

class _SearchVehicleState extends State<SearchVehicle> {
  TextEditingController pickLocation = TextEditingController();
  String? selectedVehicleType;
  String? selectedModel;

  final Map<String, List<String>> vehicleModels = {
    'Car': ['BMW', 'Mercedes', 'Audi', 'Nissan', 'Jaguar', 'Toyota'],
    'Van': ['Toyota', 'Nissan'],
    'Truck': ['Toyota', 'Nissan', 'Dimmo', 'TATA'],
  };

  List<String> models = [];

  void _search() {
    print('Searching for $selectedVehicleType - $selectedModel');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Explore", style: theme.textTheme.headlineSmall)),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: pickLocation,
              autocorrect: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded,
                    color: theme.iconTheme.color),
                contentPadding: const EdgeInsets.all(5.0),
                hintText: "Pick-up Location",
                hintStyle: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedVehicleType,
                    onChanged: (newValue) {
                      setState(() {
                        selectedVehicleType = newValue;
                        models = vehicleModels[selectedVehicleType!] ?? [];
                        selectedModel = null; // Reset model selection
                      });
                    },
                    items: vehicleModels.keys.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.directions_car_outlined,
                          color: theme.iconTheme.color),
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: "Vehicle Type",
                      hintStyle: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedModel,
                    onChanged: (newValue) {
                      setState(() {
                        selectedModel = newValue;
                      });
                    },
                    items: models.map((model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(model),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.car_rental_outlined,
                          color: theme.iconTheme.color),
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: "Model",
                      hintStyle: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _search,
                child: const Text("Search"),
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor:
                      theme.primaryColor, // Use theme's primary color
                ),
              ),
            ),
          ),
          Expanded(
            child: Search_result_list(
              collectionName: 'vehicle_db',
              VehicleType: selectedVehicleType ?? 'null',
              VehicleBrand: selectedModel ?? 'null',
            ),
          ),
        ],
      ),
    );
  }
}
