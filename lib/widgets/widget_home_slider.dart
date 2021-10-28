import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/homeLayout.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/productBuilder.dart';
import 'package:wooapp/screens/searchProduct.dart';
import 'package:wooapp/utils/widget_helper.dart';

Widget homeAppBar(BuildContext context, Widget icon) {
  return AppBar(
    backgroundColor: Theme.of(context).backgroundColor,
    centerTitle: true,
    elevation: 0,
    // title: Text(appName, style: styleProvider(fontWeight: medium, size: 12, color: black),),
    iconTheme: new IconThemeData(color: black),
    leading: icon,
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () {
              changeScreen(
                context,
                SearchScreen(),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/ic_search.svg',
              color: Theme.of(context).accentColor,
            ),
          ))
    ],
  );
}

Widget imageSlider() {
  return Container(
    height: 230,
    color: grey_200,
    child: Carousel(
      boxFit: BoxFit.fill,
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      dotSize: 2.0,
      dotIncreaseSize: 6.0,
      dotBgColor: transparent,
      dotColor: grey,
      dotPosition: DotPosition.bottomCenter,
      showIndicator: true,
      indicatorBgPadding: 6.0,
    ),
  );
}

class BannerSlider extends StatefulWidget {
  HomeLayout homeLayout;
  BannerSlider({Key key, this.homeLayout}) : super(key: key);
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  HomeLayoutBanner topBanner;
  HomeLayoutBanner secondaryBanner;
  ProductsProvider product;
  @override
  void initState() {
    super.initState();
    product = Provider.of<ProductsProvider>(context, listen: false);
    for (int i = 0; i < widget.homeLayout.banners.length; i++) {
      if (widget.homeLayout.banners[i].location == "top") {
        topBanner = widget.homeLayout.banners[i];
      } else if (widget.homeLayout.banners[i].location == "secondary") {
        secondaryBanner = widget.homeLayout.banners[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        topBanner != null && topBanner.banner.length > 0
            ? Container(
                width: double.infinity,
                height: 100,
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      pauseAutoPlayOnTouch: true),
                  items: topBanner.banner.map((e) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: grey_200,
                            ),
                            child: GestureDetector(
                                child: Image.network(e.bannerUrl,
                                    fit: BoxFit.cover),
                                onTap: () {
                                  if (e.bannerType == "category") {
                                    changeScreen(
                                        context,
                                        ShopView(
                                          categoryId: e.connectId,
                                        ));
                                  } else if (e.bannerType == "page") {}
                                }));
                      },
                    );
                  }).toList(),
                ),
              )
            : Container(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: widget.homeLayout.sectionBanners.map((e) {
              return Builder(builder: (BuildContext context) {
                if (e.layoutType == "1") {
                  return layoutType1(e, context);
                } else if (e.layoutType == "2") {
                  return layoutType2(e, context);
                } else if (e.layoutType == "3") {
                  return layoutType3(e, context);
                } else {
                  return layoutType4(e, context);
                }
              });
            }).toList(),
          ),
        ),
        secondaryBanner != null && secondaryBanner.banner.length > 0
            ? Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 150,
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      pauseAutoPlayOnTouch: true),
                  items: secondaryBanner.banner.map((e) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: grey_200,
                            ),
                            child: GestureDetector(
                                child: Image.network(e.bannerUrl,
                                    fit: BoxFit.cover),
                                onTap: () {
                                  if (e.bannerType == "category") {
                                    changeScreen(
                                        context,
                                        ShopView(
                                          categoryId: e.connectId,
                                        ));
                                  } else if (e.bannerType == "page") {
                                    product.fetchProductByPageId(
                                        page_id: e.connectId);
                                  }
                                }));
                      },
                    );
                  }).toList(),
                ),
              )
            : Container(),
      ],
    ));
  }

  Widget layoutType1(SectionBanner sectionBanner, BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Text(
              sectionBanner.title,
              style: styleProvider(
                  size: 12, color: Colors.black, fontWeight: semiBold),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
                child: FadeInImage.assetNetwork(
                    placeholder: ic_thumbnail_png,
                    height: 30,
                    width: 30,
                    image: sectionBanner.banner[0].bannerUrl,
                    fit: BoxFit.cover),
                onTap: () {
                  if (sectionBanner.banner[0].bannerType == "category") {
                    changeScreen(
                        context,
                        ShopView(
                          categoryId: sectionBanner.banner[0].connectId,
                        ));
                  } else if (sectionBanner.banner[0].bannerType == "page") {
                    product.fetchProductByPageId(
                        page_id: sectionBanner.banner[0].connectId);
                  }
                }),
          ],
        ));
  }

  Widget layoutType2(SectionBanner sectionBanner, BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionBanner.title,
              style: styleProvider(
                  size: 12, color: Colors.black, fontWeight: semiBold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (sectionBanner.banner[0].bannerType == "category") {
                        changeScreen(
                            context,
                            ShopView(
                              categoryId: sectionBanner.banner[0].connectId,
                            ));
                      } else if (sectionBanner.banner[0].bannerType == "page") {
                        var product = Provider.of<ProductsProvider>(context,
                            listen: false);
                        product.fetchProductByPageId(
                            page_id: sectionBanner.banner[0].connectId);
                      }
                    },
                    child: FadeInImage.assetNetwork(
                        placeholder: ic_thumbnail_png,
                        image: sectionBanner.banner[0].bannerUrl,
                        fit: BoxFit.cover),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (sectionBanner.banner[1].bannerType == "category") {
                        changeScreen(
                            context,
                            ShopView(
                              categoryId: sectionBanner.banner[0].connectId,
                            ));
                      } else if (sectionBanner.banner[1].bannerType == "page") {
                        var product = Provider.of<ProductsProvider>(context,
                            listen: false);
                        product.fetchProductByPageId(
                            page_id: sectionBanner.banner[1].connectId);
                      }
                    },
                    child: FadeInImage.assetNetwork(
                        placeholder: ic_thumbnail_png,
                        image: sectionBanner.banner[1].bannerUrl,
                        fit: BoxFit.cover),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget layoutType3(SectionBanner sectionBanner, BuildContext context) {
    return Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionBanner.title,
              style: styleProvider(
                  size: 12, color: Colors.black, fontWeight: semiBold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (sectionBanner.banner[0].bannerType == "category") {
                          changeScreen(
                              context,
                              ShopView(
                                categoryId: sectionBanner.banner[0].connectId,
                              ));
                        } else if (sectionBanner.banner[0].bannerType ==
                            "page") {
                          var product = Provider.of<ProductsProvider>(context,
                              listen: false);
                          product.fetchProductByPageId(
                              page_id: sectionBanner.banner[0].connectId);
                        }
                      },
                      child: Container(
                        height: 170,
                        width: 200,
                        child: FadeInImage.assetNetwork(
                            placeholder: ic_thumbnail_png,
                            image: sectionBanner.banner[0].bannerUrl,
                            fit: BoxFit.fill),
                      )),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (sectionBanner.banner[1].bannerType ==
                                  "category") {
                                changeScreen(
                                    context,
                                    ShopView(
                                      categoryId:
                                          sectionBanner.banner[0].connectId,
                                    ));
                              } else if (sectionBanner.banner[1].bannerType ==
                                  "page") {
                                var product = Provider.of<ProductsProvider>(
                                    context,
                                    listen: false);
                                product.fetchProductByPageId(
                                    page_id: sectionBanner.banner[1].connectId);
                              }
                            },
                            child: Container(
                              height: 80,
                              width: 140,
                              child: FadeInImage.assetNetwork(
                                  placeholder: ic_thumbnail_png,
                                  image: sectionBanner.banner[1].bannerUrl,
                                  fit: BoxFit.fill),
                            )),
                        GestureDetector(
                            onTap: () {
                              if (sectionBanner.banner[2].bannerType ==
                                  "category") {
                                changeScreen(
                                    context,
                                    ShopView(
                                      categoryId:
                                          sectionBanner.banner[0].connectId,
                                    ));
                              } else if (sectionBanner.banner[2].bannerType ==
                                  "page") {
                                var product = Provider.of<ProductsProvider>(
                                    context,
                                    listen: false);
                                product.fetchProductByPageId(
                                    page_id: sectionBanner.banner[2].connectId);
                              }
                            },
                            child: Container(
                              height: 80,
                              width: 140,
                              child: FadeInImage.assetNetwork(
                                  placeholder: ic_thumbnail_png,
                                  image: sectionBanner.banner[1].bannerUrl,
                                  fit: BoxFit.fill),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget layoutType4(SectionBanner sectionBanner, BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.8;
    final double itemWidth = size.width / 2;
    return Container(
      child: Column(
        children: [
          Text(
            sectionBanner.title,
            style: styleProvider(
                size: 12, color: Colors.black, fontWeight: semiBold),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 300,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              children: sectionBanner.banner.map((e) {
                return GestureDetector(
                    onTap: () {
                      if (e.bannerType == "category") {
                        changeScreen(
                            context,
                            ShopView(
                              categoryId: e.connectId,
                            ));
                      } else if (e.connectId == "page") {
                        var product = Provider.of<ProductsProvider>(context,
                            listen: false);
                        product.fetchProductByPageId(page_id: e.connectId);
                      }
                    },
                    child: FadeInImage.assetNetwork(
                        placeholder: ic_thumbnail_png,
                        image: e.bannerUrl,
                        fit: BoxFit.fill));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
