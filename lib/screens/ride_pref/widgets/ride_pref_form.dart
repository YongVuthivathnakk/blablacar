import 'package:blablacar/screens/ride_pref/widgets/ride_pref_form_input.dart';
import 'package:blablacar/utils/animations_util.dart';
import 'package:blablacar/utils/date_time_util.dart';
import 'package:blablacar/widgets/actions/bla_button.dart';
import 'package:blablacar/widgets/display/bla_divider.dart';
import 'package:blablacar/widgets/inputs/bla_location_picker.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null; // User shall select the departure
      departureDate = DateTime.now(); // Now  by default
      arrival = null; // User shall select the arrival
      requestedSeats = 1; // 1 seat book by default
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onArrivalPressed() async {
    Location? newLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(inittialLocation: arrival),
      ),
    );
    if (newLocation != null) {
      setState(() {
        arrival = newLocation;
      });
    }
  }

  void onDepartuePressed() async {
    Location? newLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(inittialLocation: departure),
      ),
    );

    if (newLocation != null) {
      setState(() {
        departure = newLocation;
      });
    }
  }

  void onPressSwitchLocation() {
    setState(() {
      // Switch if departue and arrival are not null
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving From";

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);

  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showLocationSwitcher => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgetsnull
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Departure
        RidePrefFormInput(
          title: departureLabel,
          leftIcon: Icons.circle_outlined,
          rightIcon: showLocationSwitcher ? Icons.swap_vert : null,
          onPressed: onDepartuePressed,
        ),
        BlaDivider(),

        // Arrival
        RidePrefFormInput(
          title: arrivalLabel,
          leftIcon: Icons.circle_outlined,
          onPressed: onArrivalPressed,
        ),
        BlaDivider(),
        // Date
        RidePrefFormInput(
          title: dateLabel,
          leftIcon: Icons.date_range_outlined,
          onPressed: () {},
        ),
        BlaDivider(),
        // Requested Seats
        RidePrefFormInput(
          title: requestedSeats.toString(),
          leftIcon: Icons.person,
          onPressed: () {},
        ),
        BlaDivider(),
        BlaButton(isTopRadius: false, text: "Search", onPressed: () {}),
      ],
    );
  }
}
