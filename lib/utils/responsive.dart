class WeatherModel {
  final DateTime dateTime;
  final double temp; // kelvin
  final String main;
  final int humidity;
  final double wind;
  final int pressure;

  WeatherModel({
    required this.dateTime,
    required this.temp,
    required this.main,
    required this.humidity,
    required this.wind,
    required this.pressure,
  });

  factory WeatherModel.fromListItem(Map<String, dynamic> json) {
    return WeatherModel(
      dateTime: DateTime.parse(json['dt_txt']),
      temp: (json['main']['temp'] as num).toDouble(),
      main: json['weather'][0]['main'],
      humidity: (json['main']['humidity'] as num).toInt(),
      wind: (json['wind']['speed'] as num).toDouble(),
      pressure: (json['main']['pressure'] as num).toInt(),
    );
  }
}
