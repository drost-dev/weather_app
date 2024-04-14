class WeatherForecastData {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentUnits? currentUnits;
  Current? current;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;
  DailyUnits? dailyUnits;
  Daily? daily;

  WeatherForecastData(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.currentUnits,
      this.current,
      this.hourlyUnits,
      this.hourly,
      this.dailyUnits,
      this.daily});

  WeatherForecastData.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    currentUnits = json['current_units'] != null
        ? new CurrentUnits.fromJson(json['current_units'])
        : null;
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    hourlyUnits = json['hourly_units'] != null
        ? new HourlyUnits.fromJson(json['hourly_units'])
        : null;
    hourly =
        json['hourly'] != null ? new Hourly.fromJson(json['hourly']) : null;
    dailyUnits = json['daily_units'] != null
        ? new DailyUnits.fromJson(json['daily_units'])
        : null;
    daily = json['daily'] != null ? new Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['generationtime_ms'] = this.generationtimeMs;
    data['utc_offset_seconds'] = this.utcOffsetSeconds;
    data['timezone'] = this.timezone;
    data['timezone_abbreviation'] = this.timezoneAbbreviation;
    data['elevation'] = this.elevation;
    if (this.currentUnits != null) {
      data['current_units'] = this.currentUnits!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.hourlyUnits != null) {
      data['hourly_units'] = this.hourlyUnits!.toJson();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.toJson();
    }
    if (this.dailyUnits != null) {
      data['daily_units'] = this.dailyUnits!.toJson();
    }
    if (this.daily != null) {
      data['daily'] = this.daily!.toJson();
    }
    return data;
  }
}

class CurrentUnits {
  String? time;
  String? interval;
  String? temperature2m;
  String? apparentTemperature;
  String? weatherCode;
  String? windSpeed10m;
  String? windDirection10m;

  CurrentUnits(
      {this.time,
      this.interval,
      this.temperature2m,
      this.apparentTemperature,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m});

  CurrentUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    apparentTemperature = json['apparent_temperature'];
    weatherCode = json['weather_code'];
    windSpeed10m = json['wind_speed_10m'];
    windDirection10m = json['wind_direction_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['interval'] = this.interval;
    data['temperature_2m'] = this.temperature2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['weather_code'] = this.weatherCode;
    data['wind_speed_10m'] = this.windSpeed10m;
    data['wind_direction_10m'] = this.windDirection10m;
    return data;
  }
}

class Current {
  String? time;
  int? interval;
  double? temperature2m;
  double? apparentTemperature;
  int? weatherCode;
  double? windSpeed10m;
  int? windDirection10m;

  Current(
      {this.time,
      this.interval,
      this.temperature2m,
      this.apparentTemperature,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m});

  Current.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    apparentTemperature = json['apparent_temperature'];
    weatherCode = json['weather_code'];
    windSpeed10m = json['wind_speed_10m'];
    windDirection10m = json['wind_direction_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['interval'] = this.interval;
    data['temperature_2m'] = this.temperature2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['weather_code'] = this.weatherCode;
    data['wind_speed_10m'] = this.windSpeed10m;
    data['wind_direction_10m'] = this.windDirection10m;
    return data;
  }
}

class HourlyUnits {
  String? time;
  String? temperature2m;
  String? apparentTemperature;
  String? precipitationProbability;
  String? weatherCode;
  String? windSpeed10m;
  String? windDirection10m;

  HourlyUnits(
      {this.time,
      this.temperature2m,
      this.apparentTemperature,
      this.precipitationProbability,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    temperature2m = json['temperature_2m'];
    apparentTemperature = json['apparent_temperature'];
    precipitationProbability = json['precipitation_probability'];
    weatherCode = json['weather_code'];
    windSpeed10m = json['wind_speed_10m'];
    windDirection10m = json['wind_direction_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['temperature_2m'] = this.temperature2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['precipitation_probability'] = this.precipitationProbability;
    data['weather_code'] = this.weatherCode;
    data['wind_speed_10m'] = this.windSpeed10m;
    data['wind_direction_10m'] = this.windDirection10m;
    return data;
  }
}

class Hourly {
  List<String>? time;
  List<double>? temperature2m;
  List<double>? apparentTemperature;
  List<int>? precipitationProbability;
  List<int>? weatherCode;
  List<double>? windSpeed10m;
  List<int>? windDirection10m;

  Hourly(
      {this.time,
      this.temperature2m,
      this.apparentTemperature,
      this.precipitationProbability,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    temperature2m = json['temperature_2m'].cast<double>();
    apparentTemperature = json['apparent_temperature'].cast<double>();
    precipitationProbability = json['precipitation_probability'].cast<int>();
    weatherCode = json['weather_code'].cast<int>();
    windSpeed10m = json['wind_speed_10m'].cast<double>();
    windDirection10m = json['wind_direction_10m'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['temperature_2m'] = this.temperature2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['precipitation_probability'] = this.precipitationProbability;
    data['weather_code'] = this.weatherCode;
    data['wind_speed_10m'] = this.windSpeed10m;
    data['wind_direction_10m'] = this.windDirection10m;
    return data;
  }
}

class DailyUnits {
  String? time;
  String? sunrise;
  String? sunset;

  DailyUnits({this.time, this.sunrise, this.sunset});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

class Daily {
  List<String>? time;
  List<String>? sunrise;
  List<String>? sunset;

  Daily({this.time, this.sunrise, this.sunset});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    sunrise = json['sunrise'].cast<String>();
    sunset = json['sunset'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}