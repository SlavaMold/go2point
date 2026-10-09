import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/editable_event_card.dart';
import '../widgets/editable_route_step_card.dart';
import '../widgets/edited_route_badge.dart';

class EditRoutePage extends StatefulWidget {
  const EditRoutePage({super.key});

  @override
  State<EditRoutePage> createState() => _EditRoutePageState();
}

class _EditRoutePageState extends State<EditRoutePage> {
  // =====================================================
  // ORIGINAL ROUTE DATA
  // =====================================================

  static const double _originalTotal = 477;

  static const String _originalFlightFrom = 'Chisinau';
  static const String _originalFlightTo = 'Budapest';
  static const String _originalFlightDeparture = '13/10/2026';
  static const String _originalFlightArrival = '13/10/2026';
  static const String _originalFlightPrice = '145';

  static const String _originalAirportTransferFrom =
      'Budapest Airport';
  static const String _originalAirportTransferTo =
      'City center';
  static const String _originalAirportTransferPrice = '12';

  static const String _originalHotelName =
      'Central Budapest Hotel';
  static const String _originalHotelCheckIn = '13/10/2026';
  static const String _originalHotelCheckOut = '16/10/2026';
  static const String _originalHotelPrice = '198';

  static const String _originalEventName =
      'Metallica concert';
  static const String _originalEventAddress =
      'Budapest Arena';
  static const String _originalEventDate = '14/10/2026';
  static const String _originalEventPrice = '85';

  static const String _originalLocalTransportFrom =
      'Hotel';
  static const String _originalLocalTransportTo =
      'Budapest Arena';
  static const String _originalLocalTransportPrice = '25';

  static const String _originalReturnFrom =
      'City center';
  static const String _originalReturnTo =
      'Budapest Airport';
  static const String _originalReturnPrice = '12';

  // =====================================================
  // CONTROLLERS — FLIGHT
  // =====================================================

  final TextEditingController _flightFromController =
      TextEditingController(text: _originalFlightFrom);

  final TextEditingController _flightToController =
      TextEditingController(text: _originalFlightTo);

  final TextEditingController _flightDepartureController =
      TextEditingController(text: _originalFlightDeparture);

  final TextEditingController _flightArrivalController =
      TextEditingController(text: _originalFlightArrival);

  final TextEditingController _flightPriceController =
      TextEditingController(text: _originalFlightPrice);

  // =====================================================
  // CONTROLLERS — AIRPORT TRANSFER
  // =====================================================

  final TextEditingController _airportTransferFromController =
      TextEditingController(
    text: _originalAirportTransferFrom,
  );

  final TextEditingController _airportTransferToController =
      TextEditingController(
    text: _originalAirportTransferTo,
  );

  final TextEditingController _airportTransferPriceController =
      TextEditingController(
    text: _originalAirportTransferPrice,
  );

  // =====================================================
  // CONTROLLERS — HOTEL
  // =====================================================

  final TextEditingController _hotelNameController =
      TextEditingController(
    text: _originalHotelName,
  );

  final TextEditingController _hotelCheckInController =
      TextEditingController(
    text: _originalHotelCheckIn,
  );

  final TextEditingController _hotelCheckOutController =
      TextEditingController(
    text: _originalHotelCheckOut,
  );

  final TextEditingController _hotelPriceController =
      TextEditingController(
    text: _originalHotelPrice,
  );

  // =====================================================
  // CONTROLLERS — EVENT
  // =====================================================

  final TextEditingController _eventNameController =
      TextEditingController(
    text: _originalEventName,
  );

  final TextEditingController _eventAddressController =
      TextEditingController(
    text: _originalEventAddress,
  );

  final TextEditingController _eventDateController =
      TextEditingController(
    text: _originalEventDate,
  );

  final TextEditingController _eventPriceController =
      TextEditingController(
    text: _originalEventPrice,
  );

  // =====================================================
  // CONTROLLERS — LOCAL TRANSPORT
  // =====================================================

  final TextEditingController _localTransportFromController =
      TextEditingController(
    text: _originalLocalTransportFrom,
  );

  final TextEditingController _localTransportToController =
      TextEditingController(
    text: _originalLocalTransportTo,
  );

  final TextEditingController _localTransportPriceController =
      TextEditingController(
    text: _originalLocalTransportPrice,
  );

  // =====================================================
  // CONTROLLERS — RETURN TO AIRPORT
  // =====================================================

  final TextEditingController _returnFromController =
      TextEditingController(
    text: _originalReturnFrom,
  );

  final TextEditingController _returnToController =
      TextEditingController(
    text: _originalReturnTo,
  );

  final TextEditingController _returnPriceController =
      TextEditingController(
    text: _originalReturnPrice,
  );

  bool _isEdited = false;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {
    super.initState();

    for (final controller in _allControllers) {
      controller.addListener(_onRouteChanged);
    }
  }

  List<TextEditingController> get _allControllers => [
        _flightFromController,
        _flightToController,
        _flightDepartureController,
        _flightArrivalController,
        _flightPriceController,
        _airportTransferFromController,
        _airportTransferToController,
        _airportTransferPriceController,
        _hotelNameController,
        _hotelCheckInController,
        _hotelCheckOutController,
        _hotelPriceController,
        _eventNameController,
        _eventAddressController,
        _eventDateController,
        _eventPriceController,
        _localTransportFromController,
        _localTransportToController,
        _localTransportPriceController,
        _returnFromController,
        _returnToController,
        _returnPriceController,
      ];

  void _onRouteChanged() {
    if (!mounted) {
      return;
    }

    setState(() {
      _isEdited = _hasChanges;
    });
  }

  // =====================================================
  // CHANGE DETECTION
  // =====================================================

  bool get _hasChanges {
    return _flightFromController.text != _originalFlightFrom ||
        _flightToController.text != _originalFlightTo ||
        _flightDepartureController.text !=
            _originalFlightDeparture ||
        _flightArrivalController.text !=
            _originalFlightArrival ||
        _flightPriceController.text != _originalFlightPrice ||
        _airportTransferFromController.text !=
            _originalAirportTransferFrom ||
        _airportTransferToController.text !=
            _originalAirportTransferTo ||
        _airportTransferPriceController.text !=
            _originalAirportTransferPrice ||
        _hotelNameController.text != _originalHotelName ||
        _hotelCheckInController.text !=
            _originalHotelCheckIn ||
        _hotelCheckOutController.text !=
            _originalHotelCheckOut ||
        _hotelPriceController.text != _originalHotelPrice ||
        _eventNameController.text != _originalEventName ||
        _eventAddressController.text !=
            _originalEventAddress ||
        _eventDateController.text != _originalEventDate ||
        _eventPriceController.text != _originalEventPrice ||
        _localTransportFromController.text !=
            _originalLocalTransportFrom ||
        _localTransportToController.text !=
            _originalLocalTransportTo ||
        _localTransportPriceController.text !=
            _originalLocalTransportPrice ||
        _returnFromController.text != _originalReturnFrom ||
        _returnToController.text != _originalReturnTo ||
        _returnPriceController.text != _originalReturnPrice;
  }

  // =====================================================
  // PRICE CALCULATION
  // =====================================================

  double _parsePrice(TextEditingController controller) {
    final text = controller.text
        .trim()
        .replaceAll(',', '.');

    return double.tryParse(text) ?? 0;
  }

  double get _updatedTotal {
    return _parsePrice(_flightPriceController) +
        _parsePrice(_airportTransferPriceController) +
        _parsePrice(_hotelPriceController) +
        _parsePrice(_eventPriceController) +
        _parsePrice(_localTransportPriceController) +
        _parsePrice(_returnPriceController);
  }

  double get _priceDifference {
    return _updatedTotal - _originalTotal;
  }

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }

    return value.toStringAsFixed(2);
  }

  String get _differenceText {
    final difference = _priceDifference;

    if (difference > 0) {
      return '+€${_formatMoney(difference)}';
    }

    if (difference < 0) {
      return '-€${_formatMoney(difference.abs())}';
    }

    return '€0';
  }

  // =====================================================
  // DATE PICKER
  // =====================================================

  Future<void> _selectDate(
    TextEditingController controller,
  ) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );

    if (selectedDate != null) {
      controller.text = _formatDate(selectedDate);
    }
  }

  String _formatDate(DateTime date) {
    final day =
        date.day.toString().padLeft(2, '0');

    final month =
        date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  // =====================================================
  // RESET
  // =====================================================

  void _resetChanges() {
    _flightFromController.text = _originalFlightFrom;
    _flightToController.text = _originalFlightTo;

    _flightDepartureController.text =
        _originalFlightDeparture;

    _flightArrivalController.text =
        _originalFlightArrival;

    _flightPriceController.text =
        _originalFlightPrice;

    _airportTransferFromController.text =
        _originalAirportTransferFrom;

    _airportTransferToController.text =
        _originalAirportTransferTo;

    _airportTransferPriceController.text =
        _originalAirportTransferPrice;

    _hotelNameController.text =
        _originalHotelName;

    _hotelCheckInController.text =
        _originalHotelCheckIn;

    _hotelCheckOutController.text =
        _originalHotelCheckOut;

    _hotelPriceController.text =
        _originalHotelPrice;

    _eventNameController.text =
        _originalEventName;

    _eventAddressController.text =
        _originalEventAddress;

    _eventDateController.text =
        _originalEventDate;

    _eventPriceController.text =
        _originalEventPrice;

    _localTransportFromController.text =
        _originalLocalTransportFrom;

    _localTransportToController.text =
        _originalLocalTransportTo;

    _localTransportPriceController.text =
        _originalLocalTransportPrice;

    _returnFromController.text =
        _originalReturnFrom;

    _returnToController.text =
        _originalReturnTo;

    _returnPriceController.text =
        _originalReturnPrice;

    setState(() {
      _isEdited = false;
    });
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    for (final controller in _allControllers) {
      controller.removeListener(_onRouteChanged);
      controller.dispose();
    }

    super.dispose();
  }

  // =====================================================
  // UI
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText,
          ),
        ),

        title: Text(
          'Edit route',
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            40,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // HEADER
              // =================================================

              Text(
                'Adjust your journey',
                style: GoogleFonts.quicksand(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'You can manually change route details, dates and prices.',
                style: GoogleFonts.quicksand(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                  height: 1.4,
                ),
              ),

              if (_isEdited) ...[
                const SizedBox(height: 16),
                const EditedRouteBadge(),
              ],

              const SizedBox(height: 32),

              // =================================================
              // FLIGHT
              // =================================================

              _SectionHeader(
                number: '1',
                title: 'Transport to destination',
              ),

              const SizedBox(height: 18),

              EditableRouteStepCard(
                icon: Icons.flight_takeoff_rounded,
                title: 'Flight',
                fromController: _flightFromController,
                toController: _flightToController,
                departureDateController:
                    _flightDepartureController,
                arrivalDateController:
                    _flightArrivalController,
                priceController: _flightPriceController,
                onDepartureDateTap: () {
                  _selectDate(
                    _flightDepartureController,
                  );
                },
                onArrivalDateTap: () {
                  _selectDate(
                    _flightArrivalController,
                  );
                },
              ),

              const SizedBox(height: 16),

              EditableRouteStepCard(
                icon: Icons.airport_shuttle_outlined,
                title: 'Airport transfer',
                fromController:
                    _airportTransferFromController,
                toController:
                    _airportTransferToController,
                priceController:
                    _airportTransferPriceController,
              ),

              const SizedBox(height: 34),

              // =================================================
              // HOTEL
              // =================================================

              _SectionHeader(
                number: '2',
                title: 'Stay',
              ),

              const SizedBox(height: 18),

              _EditableHotelCard(
                nameController: _hotelNameController,
                checkInController:
                    _hotelCheckInController,
                checkOutController:
                    _hotelCheckOutController,
                priceController:
                    _hotelPriceController,
                onCheckInTap: () {
                  _selectDate(
                    _hotelCheckInController,
                  );
                },
                onCheckOutTap: () {
                  _selectDate(
                    _hotelCheckOutController,
                  );
                },
              ),

              const SizedBox(height: 34),

              // =================================================
              // EVENT
              // =================================================

              _SectionHeader(
                number: '3',
                title: 'Event',
              ),

              const SizedBox(height: 18),

              EditableEventCard(
                nameController:
                    _eventNameController,
                addressController:
                    _eventAddressController,
                dateController:
                    _eventDateController,
                priceController:
                    _eventPriceController,
                onDateTap: () {
                  _selectDate(
                    _eventDateController,
                  );
                },
              ),

              const SizedBox(height: 34),

              // =================================================
              // LOCAL TRANSPORT
              // =================================================

              _SectionHeader(
                number: '4',
                title: 'Local transport',
              ),

              const SizedBox(height: 18),

              EditableRouteStepCard(
                icon: Icons.directions_subway_outlined,
                title: 'Event transport',
                fromController:
                    _localTransportFromController,
                toController:
                    _localTransportToController,
                priceController:
                    _localTransportPriceController,
              ),

              const SizedBox(height: 16),

              EditableRouteStepCard(
                icon: Icons.airport_shuttle_outlined,
                title: 'Return to airport',
                fromController:
                    _returnFromController,
                toController:
                    _returnToController,
                priceController:
                    _returnPriceController,
              ),

              const SizedBox(height: 34),

              // =================================================
              // PRICE SUMMARY
              // =================================================

              _SectionHeader(
                number: '5',
                title: 'Updated price',
              ),

              const SizedBox(height: 18),

              _PriceComparisonCard(
                originalTotal: _originalTotal,
                updatedTotal: _updatedTotal,
                differenceText: _differenceText,
                difference: _priceDifference,
              ),

              const SizedBox(height: 32),

              // =================================================
              // ACTIONS
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 56,

                child: OutlinedButton.icon(
                  onPressed:
                      _isEdited ? _resetChanges : null,

                  icon: const Icon(
                    Icons.restart_alt_rounded,
                  ),

                  label: Text(
                    'Reset changes',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        AppColors.purple,

                    side: const BorderSide(
                      color: AppColors.purple,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              AppButton(
                text: 'Save changes',
                icon: Icons.check_rounded,

                // L3:
                // validation
                // ↓
                // update route
                // ↓
                // RouteDetailsPage
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// SECTION HEADER
// =====================================================

class _SectionHeader extends StatelessWidget {
  final String number;
  final String title;

  const _SectionHeader({
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,

          alignment: Alignment.center,

          decoration: const BoxDecoration(
            color: AppColors.lightPurple,
            shape: BoxShape.circle,
          ),

          child: Text(
            number,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w800,
              color: AppColors.purple,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }
}

// =====================================================
// HOTEL
// =====================================================

class _EditableHotelCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController checkInController;
  final TextEditingController checkOutController;
  final TextEditingController priceController;

  final VoidCallback onCheckInTap;
  final VoidCallback onCheckOutTap;

  const _EditableHotelCard({
    required this.nameController,
    required this.checkInController,
    required this.checkOutController,
    required this.priceController,
    required this.onCheckInTap,
    required this.onCheckOutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,

                decoration: const BoxDecoration(
                  color: AppColors.lightPurple,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.hotel_outlined,
                  color: AppColors.purple,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  'Hotel',
                  style: GoogleFonts.quicksand(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkText,
                  ),
                ),
              ),

              const Icon(
                Icons.edit_outlined,
                size: 20,
                color: AppColors.secondaryText,
              ),
            ],
          ),

          const SizedBox(height: 22),

          AppTextField(
            label: 'Hotel',
            hint: 'Hotel name',
            prefixIcon: Icons.hotel_outlined,
            controller: nameController,
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Check-in',
                  hint: 'dd/mm/yyyy',
                  prefixIcon:
                      Icons.calendar_month_outlined,
                  controller:
                      checkInController,
                  readOnly: true,
                  onTap: onCheckInTap,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AppTextField(
                  label: 'Check-out',
                  hint: 'dd/mm/yyyy',
                  prefixIcon:
                      Icons.calendar_month_outlined,
                  controller:
                      checkOutController,
                  readOnly: true,
                  onTap: onCheckOutTap,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          AppTextField(
            label: 'Price',
            hint: '0',
            prefixText: '€ ',
            prefixIcon: Icons.payments_outlined,
            controller: priceController,

            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),

            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*[.,]?\d{0,2}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================
// PRICE COMPARISON
// =====================================================

class _PriceComparisonCard extends StatelessWidget {
  final double originalTotal;
  final double updatedTotal;
  final double difference;
  final String differenceText;

  const _PriceComparisonCard({
    required this.originalTotal,
    required this.updatedTotal,
    required this.difference,
    required this.differenceText,
  });

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }

    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final bool increased = difference > 0;
    final bool decreased = difference < 0;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _PriceValue(
                  label: 'Original',
                  value:
                      '€${_formatMoney(originalTotal)}',
                ),
              ),

              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.secondaryText,
              ),

              Expanded(
                child: _PriceValue(
                  label: 'Updated',
                  value:
                      '€${_formatMoney(updatedTotal)}',
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),

            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  increased
                      ? Icons.trending_up_rounded
                      : decreased
                          ? Icons.trending_down_rounded
                          : Icons.remove_rounded,

                  color: increased
                      ? Colors.redAccent
                      : decreased
                          ? Colors.green
                          : AppColors.secondaryText,
                ),

                const SizedBox(width: 8),

                Text(
                  differenceText,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,

                    color: increased
                        ? Colors.redAccent
                        : decreased
                            ? Colors.green
                            : AppColors.darkText,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  'difference',
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceValue extends StatelessWidget {
  final String label;
  final String value;

  const _PriceValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: GoogleFonts.quicksand(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }
}