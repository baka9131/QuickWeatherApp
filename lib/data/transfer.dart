import 'dart:math';

class WeatherMapXY {
  int x;
  int y;

  WeatherMapXY(this.x, this.y);
}

class LamcParameter {
  double re; // 사용할 지구반경 [km]
  double grid; // 격자간격 [km]
  double slat1; // 표준위도 [degree]
  double slat2; // 표준위도 [degree]
  double olon; // 기준점의 경도 [degree]
  double olat; // 기준점의 위도 [degree]
  double xo; // 기준점의 X 좌표 [격자거리]
  double yo; // 기준점의 Y 좌표 [격자거리]

  LamcParameter({
    this.re = 6371.00877, // 지도반경
    this.grid = 5.0, // 격자간격 (km)
    this.slat1 = 30.0, // 표준위도 1
    this.slat2 = 60.0, // 표준위도 2
    this.olon = 126.0, // 기준점 경도
    this.olat = 38.0, // 기준점 위도
    this.xo = 210 / 5.0, // 기준점 X 좌표 (여기서 5.0은 grid 값)
    this.yo = 675 / 5.0, // 기준점 Y 좌표 (여기서 5.0은 grid 값)
  });
}

WeatherMapXY changelaluMap(double longitude, double latitude) {
  const double pi = 3.1415926535897931;
  const double degrad = pi / 180.0;
  double sn, sf, ro, ra, theta;
  LamcParameter map = LamcParameter();

  double re = map.re / map.grid;
  double slat1 = map.slat1 * degrad;
  double slat2 = map.slat2 * degrad;
  double olon = map.olon * degrad;
  double olat = map.olat * degrad;

  sn = tan(pi * 0.25 + slat2 * 0.5) / tan(pi * 0.25 + slat1 * 0.5);
  sn = log(cos(slat1) / cos(slat2)) / log(sn);
  sf = tan(pi * 0.25 + slat1 * 0.5);
  sf = pow(sf, sn) * cos(slat1) / sn;
  ro = tan(pi * 0.25 + olat * 0.5);
  ro = re * sf / pow(ro, sn);

  ra = tan(pi * 0.25 + latitude * degrad * 0.5);
  ra = re * sf / pow(ra, sn);
  theta = longitude * degrad - olon;
  if (theta > pi) theta -= 2.0 * pi;
  if (theta < -pi) theta += 2.0 * pi;
  theta *= sn;

  double x = (ra * sin(theta)) + map.xo;
  double y = (ro - ra * cos(theta)) + map.yo;
  x = x + 1.5;
  y = y + 1.5;

  return WeatherMapXY(x.toInt(), y.toInt());
}
