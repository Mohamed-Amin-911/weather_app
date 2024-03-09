import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/controller/image_controller.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/model/image_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/city_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<WeatherModel>? _getWeather;
  Future<ImageModel>? _getImage;
  TextEditingController cityController = TextEditingController();
  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  getWeather() {
    WeatherController weatherController = WeatherController();
    _getWeather = weatherController.getWeather(cityController.text);
  }

  getImage() {
    ImageController image = ImageController();
    _getImage = image.fetchPhotos(cityController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            FutureBuilder(
              future: _getImage,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Image.network(
                      width: 1000,
                      height: 1000,
                      fit: BoxFit.fitHeight,
                      // scale: 1,
                      "${snapshot.data?.image}");
                } else {
                  return Center(
                      child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color.fromARGB(255, 0, 93, 151),
                    child: const Center(
                      child: Text(
                        "No city yet",
                        style: TextStyle(
                            fontSize: 50,
                            color: Color.fromARGB(130, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ));
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 300),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 54, 55, 149),
                Color.fromARGB(255, 54, 55, 149),
                Color.fromARGB(0, 0, 93, 151)
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimSearchBar(
                      boxShadow: true,
                      textFieldColor: const Color.fromARGB(146, 54, 55, 149),
                      textFieldIconColor: Colors.white,
                      helpText: "search for city",
                      style: const TextStyle(color: Colors.white),
                      suffixIcon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      color: const Color.fromARGB(255, 54, 55, 149),
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          Provider.of<CityProvider>(context, listen: false)
                              .setCity = cityController.text;
                          getWeather();
                          getImage();
                        });
                      },
                      width: 400,
                      textController: cityController,
                      onSuffixTap: () {
                        setState(() {
                          cityController.clear();
                        });
                      }),
                  const SizedBox(height: 500),
                  FutureBuilder(
                    future: _getWeather,
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.done) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                    " ${Provider.of<CityProvider>(context).getCity}",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            // const SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${asyncSnapshot.data?.temp ?? ""} °C",
                                        style: const TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        )),
                                    Text(
                                        // asyncSnapshot.data!.conditionText,
                                        asyncSnapshot.data?.conditionText ?? "",
                                        style: const TextStyle(
                                          fontSize: 40,
                                          height: 0.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        )),
                                  ],
                                ),
                                const Spacer(),
                                Image.network(
                                  "${asyncSnapshot.data?.icon}",
                                  // "${asyncSnapshot.data?.icon}",
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.fill,
                                )
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                            child: Text(
                          "",
                        ));
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
