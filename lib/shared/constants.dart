
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String URL_BASE = "https://api.openweathermap.org/data/2.5/weather?q=";
List<String> NOMES = ["Juiz de Fora"];
const String KEY = "&appid={PRIVATE_KEY}";

String URL = URL_BASE + NOMES.first + KEY;