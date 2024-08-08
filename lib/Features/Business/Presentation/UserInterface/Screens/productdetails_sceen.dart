import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemDetailsEntity/itemdetail_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/cart_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getitems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsingleitem_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/masseges.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/sellerstore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../AppCores/CoreWidgets/appbartitle.dart';
import '../CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String id;
  const ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final list = [
    ['49%', 'Positive Ratings'],
    ['79%', 'Ship On Time'],
    ['80%', 'Chat Response Rate']
  ];

  bool loadFailed = false;

  final _formKey = GlobalKey<FormState>();
  final _bidAmountController = TextEditingController();
  final _optionalMessageController = TextEditingController();
  double minimumBidAmount = 10.0;
  @override
  void initState() {
    BlocProvider.of<GetsingleitemBloc>(context).getUser(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const AppBarTtile(),
          elevation: 0,
          actions: const [CartNotificationWidget()],
          centerTitle: true,
        ),
        body: BlocBuilder<GetsingleitemBloc, BlocStates>(builder: (ctx, state) {
          var itemdetail =
              BlocProvider.of<GetsingleitemBloc>(context).getItemDetailsLocal();

          if (state is Loading) {
            return const ProgressCircularIndicatorCustom();
          }
          if (state is Sucessfull) {
            return _widget(context, size, itemdetail);
          } else {
            return SizedBox(
              height: size.height,
              child: InkWell(
                onTap: () {
                  BlocProvider.of<GetsingleitemBloc>(context)
                      .getUser(widget.id);
                },
                child: HeadingsWidet.withH1Icon(
                  iconData: (Icons.refresh),
                  h1: "Something Went Wrong",
                  alignment: Alignment.center,
                  h2: "Tap to retry",
                ),
              ),
            );
          }
        }));
  }

  Widget _widget(
      BuildContext context, Size size, ItemDetailEntity itemDetailEntity) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _productImages(context, size, itemDetailEntity),
          _prodctOverView(context, size, itemDetailEntity),
          _btns(context, size),
          _shortDes(context, size),
          _additonalDetails(context, size),
          _reviews(context, size, itemDetailEntity),
          _aboutSeller(context, size, itemDetailEntity),
          _moreProducts(context, size, itemDetailEntity)
        ],
      ),
    );
  }

  Widget _prodctOverView(
      BuildContext context, Size size, ItemDetailEntity itemDetailEntity) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .02, vertical: size.width * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                itemDetailEntity.itemTitle as String,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.orangeAccent, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              child: Text(
                'RS ${itemDetailEntity.buyItNowPrice.toString()}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    decoration: TextDecoration.underline,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _btns(BuildContext context, Size size) {
    var itemdetail =
        BlocProvider.of<GetsingleitemBloc>(context).getItemDetailsLocal();
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.height * .001, vertical: size.height * .04),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              child: ElevatedButtonWidget(
                  bgColor: Colors.blue,
                  buttonSize: null,
                  function: () {
                    BlocProvider.of<GetCartBloc>(context)
                        .addToCart(itemdetail.id as String)
                        .then((_) {
                      if (BlocProvider.of<GetCartBloc>(context).addedState ==
                          "S") {
                        var snackBar = const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("Added To Cart"),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        var snackBar = const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("Some thing Went Wrong"),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  buttonText: "Add to cart")),
          if (itemdetail.saleType == "auction")
            Expanded(
                child: ElevatedButtonWidget(
                    bgColor: Colors.amber,
                    buttonSize: null,
                    function: () {
                      openAlertDialog(context);
                    },
                    buttonText: "Create Offer")),
          Expanded(
              child: ElevatedButtonWidget(
                  bgColor: Colors.green,
                  buttonSize: null,
                  function: () {},
                  buttonText: "Buy It Now")),
        ],
      ),
    );
  }

  Widget _shortDes(BuildContext context, Size size) {
    var itemdetail =
        BlocProvider.of<GetsingleitemBloc>(context).getItemDetailsLocal();
    return Column(
      children: [
        HeadingsWidet(
          h1: "Short Description",
          alignment: Alignment.centerLeft,
          color: Colors.orangeAccent,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(itemdetail.shortDescription as String),
        )
      ],
    );
  }

  Widget _additonalDetails(BuildContext context, Size size) {
    var itemdetail =
        BlocProvider.of<GetsingleitemBloc>(context).getItemDetailsLocal();
    return Column(
      children: [
        SizedBox(
          height: size.height * .006,
        ),
        HeadingsWidet(
          h1: "Additional Details",
          alignment: Alignment.centerLeft,
          color: Colors.orangeAccent,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              for (int i = 0;
                  i < itemdetail.itemAdditionalInformation!.length;
                  i++)
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * .004,
                          vertical: size.height * .004),
                      color: Colors.grey,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        itemdetail.itemAdditionalInformation![i].title
                            as String,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * .004,
                          vertical: size.height * .004),
                      alignment: Alignment.centerLeft,
                      color: Colors.grey.withOpacity(.2),
                      child: Text(
                        itemdetail.itemAdditionalInformation![i].value
                            as String,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ))
                  ],
                )
            ],
          ),
        )
      ],
    );
  }

  Widget _productImages(
      BuildContext context, Size size, ItemDetailEntity itemDetailEntity) {
    var itemdetail =
        BlocProvider.of<GetsingleitemBloc>(context).getItemDetailsLocal();
    return Container(
      width: double.infinity,
      height: size.height * .4,
      decoration: BoxDecoration(
          image: DecorationImage(
              onError: (e, s) {
                setState(() {
                  loadFailed = true;
                });
              },
              image: NetworkImage(AppAssetsUrl.fallbackImageUrl),
              fit: BoxFit.cover)),
    );
  }

  Widget _aboutSeller(
      BuildContext context, Size size, ItemDetailEntity itemDetailEntity) {
    var itemdetail =
        BlocProvider.of<GetsingleitemBloc>(context).getItemDetailsLocal();
    return Card(
      color: Colors.black,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .01,
            ),
            ListTile(
              leading: CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      NetworkImage(itemdetail.user!.profileImage as String)),
              title: Text(
                itemDetailEntity.user!.name as String,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
              subtitle: Row(
                children: [
                  const Icon(
                    size: 10,
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "(3.9)",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * .002,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .003,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: size.width * .01,
                          ),
                          Text(
                            "Identity Verified",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          itemdetail.user!.identityVerifiedAt == null
                              ? Icons.close
                              : Icons.check,
                          color: itemdetail.user!.identityVerifiedAt == null
                              ? Colors.red
                              : Colors.green,
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: size.width * .01,
                          ),
                          Text(
                            "Phone Verified",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          itemdetail.user!.identityVerifiedAt == null
                              ? Icons.close
                              : Icons.check,
                          color: itemdetail.user!.identityVerifiedAt == null
                              ? Colors.red
                              : Colors.green,
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: size.width * .01,
                          ),
                          Text(
                            "Email Verified",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          itemdetail.user!.emailVerifiedAt == null
                              ? Icons.close
                              : Icons.check,
                          color: itemdetail.user!.emailVerifiedAt == null
                              ? Colors.red
                              : Colors.green,
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * .01),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * .01,
                    ),
                    child: ElevatedButtonWidget(
                        bgColor: Colors.orange,
                        buttonSize: null,
                        function: () {
                          //to store

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerstoreScreen(
                                      isMine: false,
                                      itemDetailEntity: itemDetailEntity)));
                        },
                        buttonText: "Visit Store"),
                  )),
                  SizedBox(
                    width: size.width * .03,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * .01,
                    ),
                    child: ElevatedButtonWidget(
                        bgColor: Colors.grey,
                        buttonSize: null,
                        function: () {
                          //to store
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MassegedOverView()));
                        },
                        buttonText: "Contact"),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _reviews(
      BuildContext context, Size size, ItemDetailEntity itemDetailEntity) {
    String rev =
        "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.";
    return Card(
      child: Column(
        children: [
          HeadingsWidet(h1: "Product Reviews", alignment: Alignment.topLeft),
          SizedBox(
            height: size.height * .01,
          ),
          for (int i = 0; i < 3; i++)
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: size.height * .02, vertical: size.height * .02),
              leading: const CircleAvatar(
                radius: 20,
                child: Text(
                  "J",
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: "John Cena",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: " 10-5-2024",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                rev,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  Widget _moreProducts(
      BuildContext context, Size size, ItemDetailEntity itemDetailEntity) {
    var list = BlocProvider.of<GetitemsBloc>(context).getLocalList();
    return BlocBuilder<GetitemsBloc, BlocStates>(builder: (ctx, state) {
      return Card(
        child: Column(
          children: [
            HeadingsWidet(h1: "Sponsered Items", alignment: Alignment.topLeft),
            SizedBox(
              height: size.height * .01,
            ),
            SizedBox(
              height: size.height * .36, // Fixed height for ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    list.length, // Adjust number of items based on your data
                itemBuilder: (context, index) {
                  // Replace with your actual product data

                  return ProductOverViewWidget(
                    size: size,
                    itemEntity: list[index],
                    blocStates: state,
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }

  Future<void> openAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Create Offer',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _bidAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Bid Amount'),
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Please enter a valid bid amount';
                    }
                    if (double.parse(value) < minimumBidAmount) {
                      return 'Minimum bid amount is $minimumBidAmount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _optionalMessageController,
                  decoration:
                      const InputDecoration(labelText: 'Optional Message'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle offer creation with bid amount and optional message
                  final bidAmount = double.parse(_bidAmountController.text);
                  final optionalMessage = _optionalMessageController.text;
                  // Do something with the bid amount and optional message
                  Navigator.pop(context);
                }
              },
              child: const Text('Create Offer'),
            ),
          ],
        );
      },
    );
  }
}
