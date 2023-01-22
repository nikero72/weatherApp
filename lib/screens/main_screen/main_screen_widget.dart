import 'package:flutter/material.dart';
import 'package:weather_app/api_client.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/more_screen/more_screen_widget.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  CurrentWeather currentWeather = CurrentWeather(main: 'Clouds', description: 'Нет данных', mainTemp: 0, feelsLike: 0, pressure: 0, humidity: 0, windSpeed: 0, windDeg: 0, city: 'Нет данных');
  Forecast forecast = Forecast(mainTemp: [0, 0, 0, 0, 0, 0, 0, 0], weatherMain: ['Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud'], time: ['00:00', '00:00','00:00', '00:00','00:00', '00:00','00:00', '00:00']);

  @override
  void initState() {
    super.initState();
    setCurrentWeather();
  }

  Future<CurrentWeather> _getCurrentWeather() async {
    CurrentWeather currentWeather = CurrentWeather(main: 'Clouds', description: 'Нет данных', mainTemp: 0, feelsLike: 0, pressure: 0, humidity: 0, windSpeed: 0, windDeg: 0, city: 'Нет данных');
    CurrentWeather? checkWeather;
    checkWeather = await ApiClient().getCurrentWeather();
    if (checkWeather != null) {
      currentWeather = checkWeather;
      return currentWeather;
    } return currentWeather;
  }

  Future<Forecast> _getForecast() async {
    Forecast forecast = Forecast(mainTemp: [0, 0, 0, 0, 0, 0, 0, 0], weatherMain: ['Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud', 'Cloud'], time: ['00:00', '00:00','00:00', '00:00','00:00', '00:00','00:00', '00:00']);
    Forecast? checkForecast;
    checkForecast = await ApiClient().getForecast();
    if (checkForecast != null) {
      forecast = checkForecast;
      return forecast;
    } return forecast;
  }

  void setCurrentWeather() async {
    currentWeather = await _getCurrentWeather();
    forecast = await _getForecast();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const BackgroundImageWidget(),
            const BackgroundHouseImageWidget(),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  MainCityTextWidget(city: currentWeather.city),
                  MainTemperatureWidget(mainTemp: currentWeather.mainTemp),
                  MainWeatherDescriptionWidget(description: currentWeather.description),
                ],
              ),
            ),
            ForecastWidget(currentWeather: currentWeather, forecast: forecast)
          ]
      ),
    );
  }
}


class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Image(
        image: AssetImage('assets/images/background.png'),
        fit: BoxFit.fill,
      ),
    );
  }
}

class BackgroundHouseImageWidget extends StatelessWidget {
  const BackgroundHouseImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: const Image(
          image: AssetImage('assets/images/backgroundHouse.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class MainCityTextWidget extends StatelessWidget {
  const MainCityTextWidget({Key? key, required this.city}) : super(key: key);
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

class MainTemperatureWidget extends StatelessWidget {
  const MainTemperatureWidget({Key? key, required this.mainTemp}) : super(key: key);
  final double mainTemp;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${mainTemp.round()}°',
      maxLines: 1,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 96,
          fontWeight: FontWeight.w200
      ),
    );
  }
}

class MainWeatherDescriptionWidget extends StatelessWidget {
  const MainWeatherDescriptionWidget({Key? key, required this.description}) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description.capitalize(),
      maxLines: 1,
      style: const TextStyle(
          color: Color.fromRGBO(235, 235, 245, 0.6),
          fontSize: 20,
          fontWeight: FontWeight.w600
      ),
    );
  }
}

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({Key? key, required this.currentWeather, required this.forecast}) : super(key: key);
  final CurrentWeather currentWeather;
  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: 231,
      bottom: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(44),
            topRight: Radius.circular(44)
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xF2312B5B),
          ),
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
              ForecastListViewWidget(forecast: forecast),
              DetailsButtonWidget(currentWeather: currentWeather, forecast: forecast)
            ],
          ),
        ),
      ),
    );
  }
}

class ForecastButtonsWidget extends StatelessWidget {
  const ForecastButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(12, 15, 12, 10),
          child: Text(
            '3-hourly Forecast',
            style: TextStyle(
                color: Color.fromRGBO(235, 235, 245, 0.6),
                fontSize: 15,
                fontWeight: FontWeight.w600
            ),
          ),
        )
        /* TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(12, 15, 12, 10),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            child: const Text(
              'Hourly Forecast',
              style: TextStyle(
                  color: Color.fromRGBO(235, 235, 245, 0.6),
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),
            )
        ),
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(12, 15, 12, 10),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            child: const Text(
              'Weekly Forecast',
              style: TextStyle(
                  color: Color.fromRGBO(235, 235, 245, 0.6),
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),
            )
        ), */
      ],
    );
  }
}

class ForecastListViewWidget extends StatelessWidget {
  const ForecastListViewWidget({Key? key, required this.forecast}) : super(key: key);
  final Forecast forecast;

  Image iconChoice(String weather, String time) {
    int intTime = int.parse(time.substring(0,2));
    if (intTime > 5 && intTime < 20) {
      if (weather == 'Extreme') {
        return Image.asset('assets/icons/smallsunliven.png');
      } else {
        return Image.asset('assets/icons/smallsunrain.png');
      }
    } else {
      if (weather == 'Rain') {
        return Image.asset('assets/icons/smallmoonrain.png');
      } else {
        return Image.asset('assets/icons/smallmoonwind.png');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 156,
        child: ListView.builder(
            itemCount: 8,
            itemExtent: 80,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child:  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(72, 49, 157, 0.5),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 1.0,
                              color: Color.fromRGBO(255, 255, 255, 0.2)
                          ),
                          BoxShadow(
                              spreadRadius: 1.0,
                              blurRadius: 1.0,
                              offset: Offset(2, 2),
                              color: Color.fromRGBO(0, 0, 0, 0.25)
                          )
                        ]
                    ),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                forecast.time[index],
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    letterSpacing: -0.5,
                                    color: Colors.white
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              iconChoice(forecast.weatherMain[index], forecast.time[index]),
                              const Text(
                                '30%',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    letterSpacing: -0.08,
                                    color: Color.fromRGBO(64, 203, 215, 1)
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${forecast.mainTemp[index].round()}°',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    letterSpacing: 0.38,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                ),
              );
            }
        )
    );
  }
}

class DetailsButtonWidget extends StatelessWidget {
  const DetailsButtonWidget({Key? key, required this.currentWeather, required this.forecast}) : super(key: key);
  final CurrentWeather currentWeather;
  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          // Navigator.of(context).pushNamed('/more');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoreScreen(detailsWeather: currentWeather, detailsForecast: forecast),
            ),
          );
        },
        icon: const Icon(
          Icons.arrow_drop_up,
          color: Colors.white,
          size: 30,
        ),
        padding: const EdgeInsets.all(0),
        constraints: const BoxConstraints(),
      ),
    );
  }
}


