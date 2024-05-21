import 'package:flutter/material.dart';

class BannerAdsWidget extends StatefulWidget {
  final double height;
  const BannerAdsWidget({super.key, required this.height});

  @override
  // ignore: library_private_types_in_public_api
  _BannerAdsWidgetState createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  final pageController = PageController();
  final duration = const Duration(seconds: 2);
  int currentPage = 0;
  final List<String> images = [
    "https://static.vecteezy.com/system/resources/previews/000/177/333/original/vector-promotional-advertising-banner-poster-template-with-offer-detail.jpg",
    "https://static.vecteezy.com/system/resources/previews/005/741/458/original/cosmetics-or-skin-care-product-ads-with-bottle-banner-ad-for-beauty-products-and-leaf-background-glittering-light-effect-design-vector.jpg",
    "https://tse1.mm.bing.net/th?id=OIP.wwCgA3XcIPW4_NK9Z4VGaAHaFT&pid=Api&P=0&h=220",
    "https://static.vecteezy.com/system/resources/previews/000/177/333/original/vector-promotional-advertising-banner-poster-template-with-offer-detail.jpg"
  ];

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void startAutoScroll() {
    Future.delayed(duration, () {
      final nextPage = (currentPage + 1) % images.length;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: images.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
          if (index == images.length - 1) {
            Future.delayed(const Duration(milliseconds: 500), () {
              pageController.jumpToPage(0);
            });
          }
        },
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
