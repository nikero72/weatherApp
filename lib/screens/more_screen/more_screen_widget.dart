import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/api_client.dart';
import 'package:weather_app/main.dart';

import '../main_screen/main_screen_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key, required this.detailsWeather, required this.detailsForecast,}) : super(key: key);
  final CurrentWeather detailsWeather;
  final Forecast detailsForecast;
  @override
  State<MoreScreen> createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF312B5B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF312B5B),
        title: const Text('Details'),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),
      ),
      body: Center(
          child: Column(
              children: [
                const SizedBox(height: 20),
                DetailsCityTextWidget(city: widget.detailsWeather.city),
                DetailsWeatherDesctriptionWidget(mainTemp: widget.detailsWeather.mainTemp, description: widget.detailsWeather.description),
                const SizedBox(height: 20),
                const GradientDivider(),
                DetailsScrollViewWidget(detailsWeather: widget.detailsWeather, detailsForecast: widget.detailsForecast)
              ]
          )
      )
    );
  }
}

class DetailsCityTextWidget extends StatelessWidget {
  const DetailsCityTextWidget({Key? key, required this.city}) : super(key: key);
  final String city;
  @override
  Widget build(BuildContext context) {
    return Text(
      city,
      maxLines: 1,
      style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.374,
          color: Colors.white
      ),
    );
  }
}

class DetailsWeatherDesctriptionWidget extends StatelessWidget {
  const DetailsWeatherDesctriptionWidget({Key? key, required this.mainTemp, required this.description}) : super(key: key);
  final double mainTemp;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${mainTemp.round()}° ${description.capitalize()}',
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.38,
          color: Color.fromRGBO(235, 235, 245, 0.6)
      ),
    );
  }
}

class GradientDivider extends StatelessWidget {
  const GradientDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF312B5B),
                Color(0xFF612FAB),
                Color(0xFF612FAB),
                Color(0xFF312B5B),
              ]
          )
      ),
    );
  }
}

class DetailsScrollViewWidget extends StatelessWidget {
  const DetailsScrollViewWidget({Key? key, required this.detailsWeather, required this.detailsForecast}) : super(key: key);
  final CurrentWeather detailsWeather;
  final Forecast detailsForecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 184,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF312B5B),
                          Color(0xFF362A84),
                        ]
                    )
                ),
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        const ForecastButtonsWidget(),
                        const Divider(
                          height: 1,
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                        ),
                        const Divider(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                        ForecastListViewWidget(forecast: detailsForecast),
                        const GradientDivider(),
                        const SizedBox(height: 16),
                        Row(
                            children: [
                              const SizedBox(width: 30),
                              FeelsLikeWidget(feelsLike: detailsWeather.feelsLike),
                              const SizedBox(width: 18),
                              HumidityWidget(humidity: detailsWeather.humidity),
                              const SizedBox(width: 30),
                            ]
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const SizedBox(width: 30),
                            WindWidget(windSpeed: detailsWeather.windSpeed, windDeg: detailsWeather.windDeg),
                            const SizedBox(width: 18),
                            PressureWidget(pressure: detailsWeather.pressure),
                            const SizedBox(width: 30),
                          ],
                        ),
                        const SizedBox(height: 16),
                        /* Row(
                          children: const [
                            SizedBox(width: 30),
                            EmptyWidget(),
                            SizedBox(width: 18),
                            EmptyWidget(),
                            SizedBox(width: 30),
                          ],
                        ), */
                      ],
                    )
                )
            )
        )
    );
  }
}



class FeelsLikeWidget extends StatelessWidget {
  const FeelsLikeWidget({Key? key, required this.feelsLike}) : super(key: key);
  final double feelsLike;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 60 - 18)/2,
      width: (MediaQuery.of(context).size.width - 60 - 18)/2,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1D47),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children:[
          Row(
            children: const [
              Icon(
                Icons.thermostat_outlined,
                size: 20,
                color: Color.fromRGBO(235, 235, 245, 0.6),
              ),
              Text(
                'FEELS LIKE',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.38,
                    color: Color.fromRGBO(235, 235, 245, 0.6)
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                '${feelsLike.round()}°',
                style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.374,
                    color: Colors.white
                ),
              ),
            ],
          ),
          SizedBox(height: (MediaQuery.of(context).size.width - 60 - 18)/2 - 127),
          const Text(
            'Similar to the actual temperature.',
            maxLines: 2,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}

class HumidityWidget extends StatelessWidget {
  const HumidityWidget({Key? key, required this.humidity}) : super(key: key);
  final int humidity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 60 - 18)/2,
      width: (MediaQuery.of(context).size.width - 60 - 18)/2,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1D47),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children:[
          Row(
            children: const [
              Icon(
                Icons.foggy,
                size: 20,
                color: Color.fromRGBO(235, 235, 245, 0.6),
              ),
              SizedBox(width: 5),
              Text(
                'HUMIDITY',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.38,
                    color: Color.fromRGBO(235, 235, 245, 0.6)
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                '$humidity%',
                style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.374,
                    color: Colors.white
                ),
              ),
            ],
          ),
          SizedBox(height: (MediaQuery.of(context).size.width - 60 - 18)/2 - 127),
          const Text(
            'Moisture content in the air',
            maxLines: 2,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}

class WindWidget extends StatelessWidget {
  const WindWidget({Key? key, required this.windSpeed, required this.windDeg}) : super(key: key);
  final double windSpeed;
  final int windDeg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 60 - 18)/2,
      width: (MediaQuery.of(context).size.width - 60 - 18)/2,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1D47),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children:[
          Row(
            children: const [
              Icon(
                Icons.wind_power_outlined,
                size: 20,
                color: Color.fromRGBO(235, 235, 245, 0.6),
              ),
              SizedBox(width: 5),
              Text(
                'WIND',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.38,
                    color: Color.fromRGBO(235, 235, 245, 0.6)
                ),
              )
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Column(
                children: [
                  const Text(
                    'N',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(235, 235, 245, 0.6)
                    ),
                  ),
                  Transform.rotate(
                    angle: (-pi / 2) + (pi / 180 * windDeg),
                    child: const Icon(
                      Icons.arrow_right_alt_outlined,
                      size: 52,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Container(
                height: 78,
                width: 2,
                color: const Color.fromRGBO(235, 235, 245, 0.6),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text(
                    '${windSpeed.round()}',
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.38,
                        color: Colors.white
                    ),
                  ),
                  const Text(
                    'm/s',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(235, 235, 245, 0.6)
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class PressureWidget extends StatelessWidget {
  const PressureWidget({Key? key, required this.pressure}) : super(key: key);
  final int pressure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 60 - 18)/2,
      width: (MediaQuery.of(context).size.width - 60 - 18)/2,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1D47),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children:[
          Row(
            children: const [
              Icon(
                Icons.thermostat_auto_outlined,
                size: 20,
                color: Color.fromRGBO(235, 235, 245, 0.6),
              ),
              SizedBox(width: 5),
              Text(
                'PRESSURE',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.38,
                    color: Color.fromRGBO(235, 235, 245, 0.6)
                ),
              )
            ],
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                '$pressure',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.374,
                    color: Colors.white
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'mmHg',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color.fromRGBO(235, 235, 245, 0.6)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 60 - 18)/2,
      width: (MediaQuery.of(context).size.width - 60 - 18)/2,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1D47),
        borderRadius: BorderRadius.circular(22),
      ),
    );
  }
} */

