class ReservationModel {
  String reservation_id = '';
  DateTime pickupdate = DateTime.now();
  DateTime returndate = DateTime.now();
  int week = 0;
  int day = 0;
  String discount = '';

  ReservationModel({required this.reservation_id, required this.pickupdate, required this.returndate, required this.week,required this.day,required this.discount});
}
