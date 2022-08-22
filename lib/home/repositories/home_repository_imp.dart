import 'package:aurora/home/repositories/home_repository.dart';
import 'package:aurora/shared/constants.dart';
import 'package:aurora/shared/models/Forecast.dart';
import 'package:dio/dio.dart';

class HomeRepositoryImp implements HomeRepository{

  @override
  Future<Forecast> getForecastByName({required String cityName}) async{

    var response = await Dio().get(URL_BASE + cityName + KEY);
    Forecast forecast = Forecast.fromJson(response.data);

    return forecast;
  }
  
  @override
  List<Forecast> getListForecast() {

    List<Forecast> forecastList = [];

    // ignore: avoid_function_literals_in_foreach_calls
    cities.forEach(
      (element) {
        getForecastByName(cityName: element)
          .then((value) => value.printForecast());
        },
    );
    return forecastList;
  }
  
  @override
  List<String> cities = ["Juiz de Fora", "Bicas"];

}