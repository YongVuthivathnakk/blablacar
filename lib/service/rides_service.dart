import 'package:flutter/material.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(Location departure) {
    const List<Ride> result = [];

    for (var ride in availableRides) {
      if (ride.departureLocation == departure) {
        result.add(ride);
      }
    }

    return result;
  }

  //
  //  filter the rides starting for the given requested number of seats
  //
  static List<Ride> _filterBySeatRequested(int requestedSeat) {
    const List<Ride> result = [];

    for (var ride in availableRides) {
      if (ride.availableSeats > requestedSeat) {
        result.add(ride);
      }
    }
    return result;
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    const List<Ride> result = [];

    for (var ride in availableRides) {
      if (ride.departureLocation != departure) continue;
      if (ride.availableSeats < seatRequested!) continue;

      result.add(ride);
    }

    return result;
  }
}
