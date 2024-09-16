import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:karconnect/backend/data_fetch_and_represent/data_services/fetch_single_vehicle_data.dart';

class vehicle_card extends StatelessWidget {
  final String vehicleName;
  final int price;
  final String mainImage;
  final String docID;

  const vehicle_card(
    this.vehicleName,
    this.price,
    this.mainImage,
    this.docID, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 180,
      child: GestureDetector(
        onTap: () {
          print(docID);
          Get.to(() => fetch_vehicle_Data(
                collectionName: 'vehicle_db',
                docId: docID,
              ));
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: theme.dividerColor.withOpacity(0.4),
              width: 0.5,
            ),
          ),
          color: theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/car.jpg'),
                    image: NetworkImage(mainImage),
                    fit: BoxFit.fill,
                    placeholderFit: BoxFit.fill,
                  ),
                  // child: Image.asset(
                  //   'assets/images/car.jpg',
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
              vehicle_cardDetails(vehicleName: vehicleName, price: price),
            ],
          ),
        ),
      ),
    );
  }
}

class vehicle_cardDetails extends StatefulWidget {
  final String vehicleName;
  final int price;

  vehicle_cardDetails({required this.vehicleName, required this.price});

  @override
  _vehicle_cardDetailsState createState() => _vehicle_cardDetailsState();
}

class _vehicle_cardDetailsState extends State<vehicle_cardDetails> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.vehicleName,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorited ? Icons.favorite_rounded : Iconsax.heart,
                    color: _isFavorited ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Icon(
                Icons.star_border,
                color: Colors.deepOrange,
                size: 18,
              ),
              Icon(
                Icons.star_border,
                color: Colors.deepOrange,
                size: 18,
              ),
              Icon(
                Icons.star_border,
                color: Colors.deepOrange,
                size: 18,
              ),
              Icon(
                Icons.star_border,
                size: 18,
              ),
              Icon(
                Icons.star_border,
                size: 18,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              " Rs ${widget.price}/Day",
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
