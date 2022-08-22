import 'package:aurora/home/repositories/home_repository_imp.dart';
import 'package:aurora/shared/models/Forecast.dart';
import 'package:aurora/shared/themes/AppColors.dart';
import 'package:aurora/shared/themes/AppTextStyles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String cityName = "Juiz de Fora";

class _HomePageState extends State<HomePage> {
  final repository = HomeRepositoryImp();

  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.primary,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        backgroundColor: AppColors.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(18))),
      ),
      body: FutureBuilder(
        future: repository.getForecastByName(cityName: cityName),
        builder: (((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Aconteceu uma coisa chata :("),
            );
          }
          else if (snapshot.hasData) {

            final Forecast forecast = snapshot.data as Forecast;

            controller.text = forecast.name!;

            DateTime timeSunrise = DateTime.fromMillisecondsSinceEpoch(
                forecast.sys!.sunrise! * 1000);
                
            DateTime timeSunset = DateTime.fromMillisecondsSinceEpoch(
                forecast.sys!.sunset! * 1000);

            return Scaffold(
              backgroundColor: AppColors.primary,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 64.0, horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child:  TextField(
                                  controller: controller,
                                  onSubmitted: (value) => {
                                    setState((){
                                      cityName = value;
                                    })
                                  },
                                  style: AppTextStyles.city,
                                ),
                                )
                              ],
                            ),
                                                        
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: (forecast.main!.temp! - 273)
                                          .toStringAsPrecision(3),
                                      style: AppTextStyles.temperature,
                                    ),
                                    const TextSpan(
                                        text: "  ºC",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                                  ]),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      forecast.weather!.first.description!,
                                      style: AppTextStyles.description,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Image.asset(
                                          "assets/images/${forecast.weather!.first.icon!}.png"),
                                    ),
                                  ],
                                ),

//
                              ],
                            ),
                          ),
                          
                          SizedBox(
                            height: 350,
                            child: ListView(
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    Icons.wind_power,
                                    color: Colors.white,
                                  ),
                                  title: const Text(
                                    "Wind speed",
                                    style: AppTextStyles.titleList,
                                  ),
                                  trailing: Text(
                                    forecast.wind!.speed!.toString(),
                                    style: AppTextStyles.valueList,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.cloud,
                                    color: Colors.white,
                                  ),
                                  title: const Text(
                                    "Clouds",
                                    style: AppTextStyles.titleList,
                                  ),
                                  trailing: Text(
                                    forecast.clouds!.all.toString(),
                                    style: AppTextStyles.valueList,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.water,
                                    color: Colors.white,
                                  ),
                                  title: const Text(
                                    "Humidity",
                                    style: AppTextStyles.titleList,
                                  ),
                                  trailing: Text(
                                    "${forecast.main!.humidity}%",
                                    style: AppTextStyles.valueList,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.sunny,
                                    color: Colors.white,
                                  ),
                                  title: const Text(
                                    "Sunrise",
                                    style: AppTextStyles.titleList,
                                  ),
                                  trailing: Text(
                                    "${timeSunrise.hour}:${timeSunrise.minute}",
                                    style: AppTextStyles.valueList,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.wb_twilight_rounded,
                                    color: Colors.white,
                                  ),
                                  title: const Text(
                                    "Sunset",
                                    style: AppTextStyles.titleList,
                                  ),
                                  trailing: Text(
                                    "${timeSunset.hour}:${timeSunset.minute}",
                                    style: AppTextStyles.valueList,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
        })),
      ),
    );
  }
}
