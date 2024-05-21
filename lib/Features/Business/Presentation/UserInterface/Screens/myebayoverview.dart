import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/history.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/masseges.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/settingsscreen.dart';

class MyEbayOverView extends StatelessWidget {
  MyEbayOverView({super.key});

  final list = [
    [
      Icons.favorite_outlined,
      'Saved',
    ],
    [
      Icons.refresh,
      'Buy Again',
    ],
    [
      Icons.pan_tool_sharp,
      'Bids and offers',
    ],
  ];
  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.height * .05),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: size.width * .6,
                child: Column(
                  children: [
                    _profileSection(context, size),
                    _notificationSection(context, size),
                    _history(context, size),
                    _settings(context, size)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileSection(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * .04,
        ),
        const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://tse1.mm.bing.net/th?id=OIP.ZWkglY4zTe4gYJzS-qAnqAHaHT&pid=Api")),
        SizedBox(
          height: size.height * .03,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "UserName101",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Text(
                    "03241029381",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {},
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
