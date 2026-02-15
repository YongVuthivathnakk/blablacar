import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/service/locations_service.dart';
import 'package:blablacar/theme/theme.dart';
import 'package:blablacar/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? inittialLocation;
  const BlaLocationPicker({super.key, required this.inittialLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String currentSearchText = '';

  void onTap(Location location) {
    Navigator.pop<Location>(context, location);
  }

  void onBackTap() {
    Navigator.pop<Location>(context);
  }

  void onSearchChanged(String search) {
    setState(() {
      currentSearchText = search;
    });
  }

  List<Location> get filteredLocation {
    if (currentSearchText.length < 2) {
      return [];
    }
    return LocationsService.availableLocations
        .where(
          (location) => location.name.toUpperCase().contains(
            currentSearchText.toUpperCase(),
          ),
        )
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.inittialLocation != null) {
      setState(() {
        currentSearchText = widget.inittialLocation!.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            LocationSearchBar(
              onNavigateBack: onBackTap,
              initSearch: currentSearchText,
              onSearchChanged: onSearchChanged,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocation.length,
                itemBuilder: (context, index) => LocationTile(
                  location: filteredLocation[index],
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======== LOCATION TILE ========

class LocationTile extends StatelessWidget {
  final Location location;
  final ValueChanged<Location> onTap;
  const LocationTile({super.key, required this.onTap, required this.location});

  String get title => location.name;
  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(location),
          title: Text(location.name),
          subtitle: Text(
            subTitle,
            style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
          ),
          leading: Icon(Icons.location_on),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: BlaColors.iconLight,
            size: 16,
          ),
        ),
        BlaDivider(),
      ],
    );
  }
}

// ======== Location Bar ========

class LocationSearchBar extends StatefulWidget {
  final VoidCallback onNavigateBack;
  final String initSearch;
  final ValueChanged<String> onSearchChanged;
  const LocationSearchBar({
    super.key,
    required this.onNavigateBack,
    required this.initSearch,
    required this.onSearchChanged,
  });

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchInputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void onClearTap() {
    _searchInputController.clear();
  }

  bool get isSearchNotEmpty => _searchInputController.text.isNotEmpty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchInputController.text = widget.initSearch;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchInputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: widget.onNavigateBack,
          icon: Icon(
            Icons.arrow_back_ios,
            color: BlaColors.iconLight,
            size: 16,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _searchInputController,
            onChanged: widget.onSearchChanged,
            focusNode: _focusNode,
          ),
        ),
        isSearchNotEmpty
            ? IconButton(
                onPressed: onClearTap,
                icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
