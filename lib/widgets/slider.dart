import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/country_profile.dart';
import 'package:eicapp/screens/country_profile_list.dart';
import 'package:eicapp/screens/feedback.dart';
import 'package:eicapp/screens/incentive.dart';
import 'package:eicapp/screens/incentive_list.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/news.dart';
import 'package:eicapp/screens/sector.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:eicapp/screens/service.dart';
import 'package:eicapp/screens/service_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eicapp/providers/slider.dart';

class MySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<SlideProvider>(context).slides == null ||
        Provider.of<SlideProvider>(context).slides.length == 0) {
      return Container();
    }

    List<dynamic> slides = Provider.of<SlideProvider>(context).slides;
    double sliderHeightPercent = 0.5;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      sliderHeightPercent = 0.7;
    }
    double sliderHeight =
        MediaQuery.of(context).size.height * sliderHeightPercent;

    return CarouselSlider(
      enlargeCenterPage: true,
      height: sliderHeight,
      items: slides.map((item) {
        final String img = item.url;
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: <Widget>[
                    CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      fit: BoxFit.cover,
                      imageUrl: img,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    Center(
                      // bottom: 10.0,
                      child: Text(
                        item.caption,
                        textAlign: TextAlign.center,
                        // maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          backgroundColor: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: _onDeepLinkTap(context, item),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  void Function() _onDeepLinkTap(BuildContext context, dynamic item) {
    return () {
      String screenId;
      try {
        screenId = item.screen_id;
      } catch (e) {
        return;
      }

      switch (screenId) {
        case "sector_list_screen":
          Navigator.pushNamed(context, SectorListScreen.id);
          break;

        case "sector_screen":
          Navigator.pushNamed(context, SectorScreen.id,
              arguments: item.argument);
          break;

        case "feedback_screen":
          Navigator.pushNamed(context, FeedbackScreen.id);
          break;

        case "service_screen":
          Navigator.pushNamed(context, ServiceScreen.id,
              arguments: item.argument);
          break;

        case "service_list_screen":
          Navigator.pushNamed(context, ServiceListScreen.id,
              arguments: <String, String>{
                "name": "Leather and Leather Products",
              });
          break;

        case "news_screen":
          Navigator.pushNamed(context, NewsScreen.id, arguments: item.argument);
          break;

        case "chinese_page_screen":
          Navigator.pushNamed(context, ChinesePageScreen.id,
              arguments: item.argument);
          // "name": "来埃塞俄比亚"
          break;

        case "incentive_list_screen":
          Navigator.pushNamed(context, IncentiveListScreen.id,
              arguments: item.argument);
          break;

        case "incentive_package_list_screen":
          Navigator.pushNamed(context, IncentivePackageListScreen.id);
          break;

        case "incentive_screen":
          Navigator.pushNamed(context, IncentiveScreen.id,
              arguments: item.argument);
          break;

        case "country_profile_screen":
          Navigator.pushNamed(context, CountryProfileScreen.id,
              arguments: item.argument);
          break;

        case "country_profile_list_screen":
          Navigator.pushNamed(context, CountryProfileListScreen.id);
          break;

        default:
          break;
      }
    };
  }
}
