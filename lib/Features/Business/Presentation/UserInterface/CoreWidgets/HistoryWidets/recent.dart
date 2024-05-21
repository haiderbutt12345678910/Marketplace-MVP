import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';

class RecentScreen extends StatelessWidget {
  final int id;
  RecentScreen({super.key, required this.id});

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
    return SizedBox(
        height: size.height, // Fixed height for ListView
        child: Column(
          children: [
            for (int i = 0; i < product.length; i++)
              _produtsOverView(context, size, i)
          ],
        ));
  }

  Widget _produtsOverView(BuildContext context, Size size, int i) {
    return Column(
      children: [
        SizedBox(
          height: size.height * .03,
        ),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const ProductDetailsScreen()),
            // );
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: size.height * .15,
                  child: SizedBox(
                    height: size.height * .11,
                    child: Image.network(
                      product[i]["imageUrl"] as String,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.height * .02,
              ),
              Expanded(
                  child: Column(
                children: [
                  // Title
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topLeft,
                    child: Text(
                      product[i]["title"] as String,
                      maxLines: 2, // Allow wrapping for long titles
                      overflow: TextOverflow.ellipsis, // Truncate if too long
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(height: size.height * .02),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * .01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("\$US ${product[i]["discountedPrice"] as String}",
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(
                          width: size.height * .01,
                        ),
                        Text("Free Shipping",
                            style: Theme.of(context).textTheme.titleSmall!),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.height * .04,
                  ),
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}
