import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';

class FavSellerWidet extends StatelessWidget {
  final int id;
  FavSellerWidet({super.key, required this.id});

  final product = [
    {
      "imageUrl":
          "https://tse3.mm.bing.net/th?id=OIP.fFw-qnW_uMZqAtNAQDvghQHaIq&pid=Api&P=0&h=220",
      "title": "Sample Product Title",
      "description":
          "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.LOREM IPSUM GENERATOR",
      "price": '19.99',
      "discountedPrice": '14.99',
    },
    {
      "imageUrl":
          "https://tse3.mm.bing.net/th?id=OIP.fFw-qnW_uMZqAtNAQDvghQHaIq&pid=Api&P=0&h=220",
      "title": "Sample Product Title",
      "description":
          "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.LOREM IPSUM GENERATOR",
      "price": '19.99',
      "discountedPrice": '14.99',
    },
    {
      "imageUrl":
          "https://tse3.mm.bing.net/th?id=OIP.fFw-qnW_uMZqAtNAQDvghQHaIq&pid=Api&P=0&h=220",
      "title": "Sample Product Title",
      "description":
          "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.LOREM IPSUM GENERATOR",
      "price": '19.99',
      "discountedPrice": '14.99',
    },
    {
      "imageUrl":
          "https://tse1.mm.bing.net/th?id=OIP.tQJx_q96onpp5b9i2QtfDwHaMB&pid=Api&P=0&h=220",
      "title": "Sample Product Title",
      "description":
          "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.LOREM IPSUM GENERATOR",
      "price": '19.99',
      "discountedPrice": '14.99',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return _favSeller(context, size);
  }

  Widget _favSeller(BuildContext context, Size size) {
    return SizedBox(
      height: size.height, // Fixed height for ListView
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 4, // Adjust number of items based on your data
        itemBuilder: (context, index) {
          // Replace with your actual product data

          return Container(
            width: size.width *
                .58, // Fixed width for each item (adjust if needed)
            margin: EdgeInsets.only(right: size.height * .02),
            child: Column(
              children: [
                // Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: size.height * .15,
                  width: double.infinity,
                  child: SizedBox(
                    height: size.height * .11,
                    child: Image.network(
                      product[index]["imageUrl"] as String,
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        size.height * .02), // Spacing between image and text

                // Title

                SizedBox(
                  width: double.infinity,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: AppColors.iconsDarkTheme,
                        )),
                    leading: const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "https://tse4.mm.bing.net/th?id=OIP.BwHcg0ki1TiNyU_ihIV-SgHaHa&pid=Api&P=0&h=220")),
                    title: Text(
                      "Card RushInc",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      "80293912 followers",
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
