import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/user_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getuser_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/history.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/masseges.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/profile_screen.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/settingsscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyEbayOverView extends StatelessWidget {
  MyEbayOverView({super.key});

  final list = [
    [
      Icons.favorite_outlined,
      'Saved',
    ],
    [
      Icons.pan_tool_sharp,
      'Bids and offers',
    ],
  ];
  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          // Customize your app bar title
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(3.0),
            child: TabBar(
              tabs: [
                Tab(text: "Selling"),
                Tab(text: "Buyers"),
                Tab(text: "Account"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * .05),
                child: Column(
                  children: [_profileSection(context, size), SellingTab()],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * .05),
                child: Column(
                  children: [_profileSection(context, size), ByersTab()],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * .05),
                child: Column(
                  children: [_profileSection(context, size), AccountTab()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileSection(BuildContext context, Size size) {
    BlocProvider.of<GetUserBloc>(context).getUser();
    return BlocBuilder<GetUserBloc, BlocStates>(builder: (ctx, state) {
      UserEntity user = BlocProvider.of<GetUserBloc>(context).getUserLocal();
      if (state is Loading) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: size.width * .4,
            height: size.height * .2,
            child: const ProgressCircularIndicatorCustom(
              bgColor: Colors.white,
            ));
      } else if (state is Sucessfull) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .04,
            ),
            CircleAvatar(
                radius: 50, backgroundImage: NetworkImage(user.profileImage)),
            SizedBox(
              height: size.height * .03,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Text(
                        user.mobileNo,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      //Naviget to profile
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward_sharp,
                      color: AppColors.iconsVaraintDarkTheme,
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: size.height * .03,
            ),
            SizedBox(
              width: double.infinity,
              child: Divider(
                color: AppColors.dividerColor,
              ),
            ),
            SizedBox(
              height: size.height * .04,
            )
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _notificationSection(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MassegedOverView(),
              ),
            );
          },
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.mail,
                    color: AppColors.iconsDarkTheme,
                  ),
                )),
                Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Masseges",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          "1",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * .03,
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            color: AppColors.dividerColor,
          ),
        ),
      ],
    );
  }

  Widget _history(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < list.length; i++)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          list[i][0] as IconData,
                          color: AppColors.iconsDarkTheme,
                        ),
                      )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              list[i][1] as String,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: size.height * .03,
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            color: AppColors.dividerColor,
          ),
        ),
      ],
    );
  }

  Widget memberships(BuildContext context, Size size) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: size.height * .04,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.settings,
                        color: AppColors.iconsDarkTheme,
                      ),
                    )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Memberships",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          )
        ],
      ),
    );
  }

  Widget _settings(BuildContext context, Size size) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: size.height * .04,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.settings,
                        color: AppColors.iconsDarkTheme,
                      ),
                    )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Settings",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          )
        ],
      ),
    );
  }
}

class SellingTab extends StatelessWidget {
  SellingTab({super.key});
  final sellingList = [
    ['SELL AN ITEM', Icons.add_shopping_cart],
    ['MY ITEMS', Icons.list_alt],
    ['SOLD ITEMS', Icons.check_box],
    ['UNSOLD ITEMS', Icons.remove_shopping_cart],
    ['ITEM BIDS', Icons.local_offer],
    ['PAYMENTS', Icons.account_balance_wallet],
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < sellingList.length; i++)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          sellingList[i][1] as IconData,
                          color: AppColors.iconsDarkTheme,
                        ),
                      )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              sellingList[i][0] as String,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: size.height * .03,
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            color: AppColors.dividerColor,
          ),
        ),
      ],
    );
  }
}

class ByersTab extends StatelessWidget {
  ByersTab({super.key});
  final buyersList = [
    ['MY BIDS', Icons.gavel],
    ['RECENTLY VIEWED', Icons.visibility],
    ['SAVED', Icons.bookmark],
    ['PURCHASE HISTORY', Icons.history],
    ['MY RETURNS', Icons.assignment_return],
    ['RATINGS AND REVIEWS', Icons.rate_review],
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < buyersList.length; i++)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          buyersList[i][1] as IconData,
                          color: AppColors.iconsDarkTheme,
                        ),
                      )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              buyersList[i][0] as String,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: size.height * .03,
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            color: AppColors.dividerColor,
          ),
        ),
      ],
    );
  }
}

class AccountTab extends StatelessWidget {
  AccountTab({super.key});
  final accountList = [
    ['MESSAGES', Icons.message],
    ['PROFILE', Icons.person],
    ['IDENTITY VERIFICATION', Icons.verified_user],
    ['SETTING', Icons.settings],
    ['MEMBERSHIPS', Icons.card_membership],
    ['CHANGE PASSWORD', Icons.lock],
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < accountList.length; i++)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          accountList[i][1] as IconData,
                          color: AppColors.iconsDarkTheme,
                        ),
                      )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              accountList[i][0] as String,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: size.height * .03,
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            color: AppColors.dividerColor,
          ),
        ),
      ],
    );
  }
}
