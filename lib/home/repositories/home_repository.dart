abstract class HomeRepository{
  getListForecast();
  getForecastByName({required String cityName});
  List<String> cities = [];
}