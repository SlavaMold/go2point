import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../validation/trip_validators.dart';
import '../validation/money_input_formatter.dart';

import '../data/mock_routes.dart';
import '../models/trip_route.dart';
import 'not_found_page.dart';
import '../theme/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_feedback.dart';
import '../widgets/app_text_field.dart';
import '../widgets/editable_event_card.dart';
import '../widgets/editable_route_step_card.dart';
import '../widgets/edited_route_badge.dart';

class EditRoutePage extends StatefulWidget {
  final int id;

  const EditRoutePage({super.key, required this.id});

  @override
  State<EditRoutePage> createState() => _EditRoutePageState();
}

class _EditRoutePageState extends State<EditRoutePage> {
  // =====================================================
  // ORIGINAL ROUTE DATA
  // =====================================================

  late final TripRoute? _route = findMockRoute(widget.id);

  double get _originalTotal => _route!.totalPrice;
  String get _originalFlightFrom => _route!.outbound.from;
  String get _originalFlightTo => _route!.outbound.to;
  String get _originalFlightDeparture => formatTripDate(_route!.arrivalDate);
  String get _originalFlightArrival => formatTripDate(_route!.arrivalDate);
  String get _originalFlightPrice => formatTripPrice(_route!.outbound.price);
  String get _originalAirportTransferFrom =>
      _route!.stepOfKind(TripStepKind.transfer).from;
  String get _originalAirportTransferTo =>
      _route!.stepOfKind(TripStepKind.transfer).to;
  String get _originalAirportTransferPrice =>
      formatTripPrice(_route!.stepOfKind(TripStepKind.transfer).price);
  String get _originalHotelName => _route!.hotel.from;
  String get _originalHotelCheckIn => formatTripDate(_route!.arrivalDate);
  String get _originalHotelCheckOut => formatTripDate(_route!.departureDate);
  String get _originalHotelPrice => formatTripPrice(_route!.hotel.price);
  String get _originalEventName => _route!.event.from;
  String get _originalEventAddress => _route!.event.to;
  String get _originalEventDate => formatTripDate(_route!.eventDate);
  String get _originalEventPrice => formatTripPrice(_route!.event.price);
  String get _originalLocalTransportFrom =>
      _route!.stepOfKind(TripStepKind.localTransport).from;
  String get _originalLocalTransportTo =>
      _route!.stepOfKind(TripStepKind.localTransport).to;
  String get _originalLocalTransportPrice =>
      formatTripPrice(_route!.stepOfKind(TripStepKind.localTransport).price);
  String get _originalReturnFrom =>
      _route!.stepOfKind(TripStepKind.returnTransfer).from;
  String get _originalReturnTo =>
      _route!.stepOfKind(TripStepKind.returnTransfer).to;
  String get _originalReturnPrice =>
      formatTripPrice(_route!.stepOfKind(TripStepKind.returnTransfer).price);

  // =====================================================
  // CONTROLLERS — FLIGHT
  // =====================================================

  late final TextEditingController _flightFromController =
      TextEditingController(text: _originalFlightFrom);

  late final TextEditingController _flightToController = TextEditingController(
    text: _originalFlightTo,
  );

  late final TextEditingController _flightDepartureController =
      TextEditingController(text: _originalFlightDeparture);

  late final TextEditingController _flightArrivalController =
      TextEditingController(text: _originalFlightArrival);

  late final TextEditingController _flightPriceController =
      TextEditingController(text: _originalFlightPrice);

  // =====================================================
  // CONTROLLERS — AIRPORT TRANSFER
  // =====================================================

  late final TextEditingController _airportTransferFromController =
      TextEditingController(text: _originalAirportTransferFrom);

  late final TextEditingController _airportTransferToController =
      TextEditingController(text: _originalAirportTransferTo);

  late final TextEditingController _airportTransferPriceController =
      TextEditingController(text: _originalAirportTransferPrice);

  // =====================================================
  // CONTROLLERS — HOTEL
  // =====================================================

  late final TextEditingController _hotelNameController = TextEditingController(
    text: _originalHotelName,
  );

  late final TextEditingController _hotelCheckInController =
      TextEditingController(text: _originalHotelCheckIn);

  late final TextEditingController _hotelCheckOutController =
      TextEditingController(text: _originalHotelCheckOut);

  late final TextEditingController _hotelPriceController =
      TextEditingController(text: _originalHotelPrice);

  // =====================================================
  // CONTROLLERS — EVENT
  // =====================================================

  late final TextEditingController _eventNameController = TextEditingController(
    text: _originalEventName,
  );

  late final TextEditingController _eventAddressController =
      TextEditingController(text: _originalEventAddress);

  late final TextEditingController _eventDateController = TextEditingController(
    text: _originalEventDate,
  );

  late final TextEditingController _eventPriceController =
      TextEditingController(text: _originalEventPrice);

  // =====================================================
  // CONTROLLERS — LOCAL TRANSPORT
  // =====================================================

  late final TextEditingController _localTransportFromController =
      TextEditingController(text: _originalLocalTransportFrom);

  late final TextEditingController _localTransportToController =
      TextEditingController(text: _originalLocalTransportTo);

  late final TextEditingController _localTransportPriceController =
      TextEditingController(text: _originalLocalTransportPrice);

  // =====================================================
  // CONTROLLERS — RETURN TO AIRPORT
  // =====================================================

  late final TextEditingController _returnFromController =
      TextEditingController(text: _originalReturnFrom);

  late final TextEditingController _returnToController = TextEditingController(
    text: _originalReturnTo,
  );

  late final TextEditingController _returnPriceController =
      TextEditingController(text: _originalReturnPrice);

  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  bool _isEdited = false;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {
    super.initState();
    if (_route == null) return;

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
        _flightDepartureController.text != _originalFlightDeparture ||
        _flightArrivalController.text != _originalFlightArrival ||
        _flightPriceController.text != _originalFlightPrice ||
        _airportTransferFromController.text != _originalAirportTransferFrom ||
        _airportTransferToController.text != _originalAirportTransferTo ||
        _airportTransferPriceController.text != _originalAirportTransferPrice ||
        _hotelNameController.text != _originalHotelName ||
        _hotelCheckInController.text != _originalHotelCheckIn ||
        _hotelCheckOutController.text != _originalHotelCheckOut ||
        _hotelPriceController.text != _originalHotelPrice ||
        _eventNameController.text != _originalEventName ||
        _eventAddressController.text != _originalEventAddress ||
        _eventDateController.text != _originalEventDate ||
        _eventPriceController.text != _originalEventPrice ||
        _localTransportFromController.text != _originalLocalTransportFrom ||
        _localTransportToController.text != _originalLocalTransportTo ||
        _localTransportPriceController.text != _originalLocalTransportPrice ||
        _returnFromController.text != _originalReturnFrom ||
        _returnToController.text != _originalReturnTo ||
        _returnPriceController.text != _originalReturnPrice;
  }

  // =====================================================
  // PRICE CALCULATION
  // =====================================================

  double _parsePrice(TextEditingController controller) {
    final text = controller.text.trim().replaceAll(',', '.');

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

  Future<void> _selectDate(TextEditingController controller) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: TripValidators.parseDate(controller.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100, 12, 31),
    );

    if (!mounted) return;
    if (selectedDate != null) {
      controller.text = _formatDate(selectedDate);
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');

    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  // =====================================================
  // RESET
  // =====================================================

  void _saveChanges() {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    showAppMessage(context, 'Route changes are valid. Demo data is unchanged.');
    context.pop();
  }

  Future<void> _confirmReset() async {
    final ok = await confirmAction(
      context,
      title: 'Reset changes?',
      message: 'Restore the original route details?',
      confirmLabel: 'Reset',
    );
    if (!mounted || !ok) return;
    _resetChanges();
    _formKey.currentState?.clearError();
    showAppMessage(context, 'Changes reset.');
  }

  void _resetChanges() {
    _flightFromController.text = _originalFlightFrom;
    _flightToController.text = _originalFlightTo;

    _flightDepartureController.text = _originalFlightDeparture;

    _flightArrivalController.text = _originalFlightArrival;

    _flightPriceController.text = _originalFlightPrice;

    _airportTransferFromController.text = _originalAirportTransferFrom;

    _airportTransferToController.text = _originalAirportTransferTo;

    _airportTransferPriceController.text = _originalAirportTransferPrice;

    _hotelNameController.text = _originalHotelName;

    _hotelCheckInController.text = _originalHotelCheckIn;

    _hotelCheckOutController.text = _originalHotelCheckOut;

    _hotelPriceController.text = _originalHotelPrice;

    _eventNameController.text = _originalEventName;

    _eventAddressController.text = _originalEventAddress;

    _eventDateController.text = _originalEventDate;

    _eventPriceController.text = _originalEventPrice;

    _localTransportFromController.text = _originalLocalTransportFrom;

    _localTransportToController.text = _originalLocalTransportTo;

    _localTransportPriceController.text = _originalLocalTransportPrice;

    _returnFromController.text = _originalReturnFrom;

    _returnToController.text = _originalReturnTo;

    _returnPriceController.text = _originalReturnPrice;

    setState(() {
      _isEdited = false;
      _submitted = false;
    });
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    if (_route == null) {
      super.dispose();
      return;
    }
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
    if (_route == null) {
      return NotFoundPage(message: 'Trip ${widget.id} was not found.');
    }
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,

      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,

        title: Text(
          'Edit route',
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),

          child: Form(
            key: _formKey,
            autovalidateMode: _submitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
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
                    color: scheme.onSurface,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'You can manually change route details, dates and prices.',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurfaceVariant,
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
                _SectionHeader(number: '1', title: 'Transport to destination'),

                const SizedBox(height: 18),

                EditableRouteStepCard(
                  icon: _route.outbound.kind == TripStepKind.train
                      ? Icons.train_outlined
                      : Icons.flight_takeoff_rounded,
                  title: _route.outbound.title,
                  fromController: _flightFromController,
                  toController: _flightToController,
                  departureDateController: _flightDepartureController,
                  arrivalDateController: _flightArrivalController,
                  priceController: _flightPriceController,
                  departureDateValidator: (value) => TripValidators.date(
                    value,
                    notAfter: TripValidators.parseDate(
                      _flightArrivalController.text,
                    ),
                    afterMessage: 'Departure cannot follow arrival',
                  ),
                  arrivalDateValidator: (value) => TripValidators.date(
                    value,
                    notBefore: TripValidators.parseDate(
                      _flightDepartureController.text,
                    ),
                    beforeMessage: 'Arrival cannot precede departure',
                  ),
                  onDepartureDateTap: () {
                    _selectDate(_flightDepartureController);
                  },
                  onArrivalDateTap: () {
                    _selectDate(_flightArrivalController);
                  },
                ),

                const SizedBox(height: 16),

                EditableRouteStepCard(
                  icon: Icons.airport_shuttle_outlined,
                  title: _route.stepOfKind(TripStepKind.transfer).title,
                  fromController: _airportTransferFromController,
                  toController: _airportTransferToController,
                  priceController: _airportTransferPriceController,
                ),

                const SizedBox(height: 34),

                // =================================================
                // HOTEL
                // =================================================
                _SectionHeader(number: '2', title: 'Stay'),

                const SizedBox(height: 18),

                _EditableHotelCard(
                  nameController: _hotelNameController,
                  checkInController: _hotelCheckInController,
                  checkOutController: _hotelCheckOutController,
                  priceController: _hotelPriceController,
                  checkInValidator: (value) => TripValidators.date(
                    value,
                    notBefore: TripValidators.parseDate(
                      _flightArrivalController.text,
                    ),
                    beforeMessage: 'Check-in cannot precede arrival',
                  ),
                  checkOutValidator: (value) => TripValidators.date(
                    value,
                    notBefore: TripValidators.parseDate(
                      _hotelCheckInController.text,
                    ),
                    beforeMessage: 'Check-out cannot precede check-in',
                  ),
                  onCheckInTap: () {
                    _selectDate(_hotelCheckInController);
                  },
                  onCheckOutTap: () {
                    _selectDate(_hotelCheckOutController);
                  },
                ),

                const SizedBox(height: 34),

                // =================================================
                // EVENT
                // =================================================
                _SectionHeader(number: '3', title: 'Event'),

                const SizedBox(height: 18),

                EditableEventCard(
                  nameController: _eventNameController,
                  addressController: _eventAddressController,
                  dateController: _eventDateController,
                  priceController: _eventPriceController,
                  dateValidator: (value) => TripValidators.date(
                    value,
                    notBefore: TripValidators.parseDate(
                      _hotelCheckInController.text,
                    ),
                    notAfter: TripValidators.parseDate(
                      _hotelCheckOutController.text,
                    ),
                    beforeMessage: 'Event must be during your stay',
                    afterMessage: 'Event must be during your stay',
                  ),
                  onDateTap: () {
                    _selectDate(_eventDateController);
                  },
                ),

                const SizedBox(height: 34),

                // =================================================
                // LOCAL TRANSPORT
                // =================================================
                _SectionHeader(number: '4', title: 'Local transport'),

                const SizedBox(height: 18),

                EditableRouteStepCard(
                  icon: Icons.directions_subway_outlined,
                  title: 'Event transport',
                  fromController: _localTransportFromController,
                  toController: _localTransportToController,
                  priceController: _localTransportPriceController,
                ),

                const SizedBox(height: 16),

                EditableRouteStepCard(
                  icon: Icons.airport_shuttle_outlined,
                  title: _route.stepOfKind(TripStepKind.returnTransfer).title,
                  fromController: _returnFromController,
                  toController: _returnToController,
                  priceController: _returnPriceController,
                  onPriceSubmitted: (_) => _saveChanges(),
                ),

                const SizedBox(height: 34),

                // =================================================
                // PRICE SUMMARY
                // =================================================
                _SectionHeader(number: '5', title: 'Updated price'),

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
                    onPressed: _isEdited ? _confirmReset : null,

                    icon: const Icon(Icons.restart_alt_rounded),

                    label: Text(
                      'Reset changes',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    style: OutlinedButton.styleFrom(
                      foregroundColor: scheme.primary,

                      side: BorderSide(color: scheme.primary),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                AppButton(
                  text: 'Save changes',
                  icon: Icons.check_rounded,

                  onPressed: _saveChanges,
                ),
              ],
            ),
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

  const _SectionHeader({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            shape: BoxShape.circle,
          ),

          child: Text(
            number,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w800,
              color: scheme.primary,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
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

  final FormFieldValidator<String> checkInValidator;
  final FormFieldValidator<String> checkOutValidator;
  final VoidCallback onCheckInTap;
  final VoidCallback onCheckOutTap;

  const _EditableHotelCard({
    required this.nameController,
    required this.checkInController,
    required this.checkOutController,
    required this.priceController,
    required this.checkInValidator,
    required this.checkOutValidator,
    required this.onCheckInTap,
    required this.onCheckOutTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
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

                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  shape: BoxShape.circle,
                ),

                child: Icon(Icons.hotel_outlined, color: scheme.primary),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  'Hotel',
                  style: GoogleFonts.quicksand(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ),

              Icon(
                Icons.edit_outlined,
                size: 20,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),

          const SizedBox(height: 22),

          AppTextField(
            label: 'Hotel',
            hint: 'Hotel name',
            prefixIcon: Icons.hotel_outlined,
            controller: nameController,
            validator: TripValidators.requiredText,
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Check-in',
                  hint: 'dd/mm/yyyy',
                  prefixIcon: Icons.calendar_month_outlined,
                  controller: checkInController,
                  validator: checkInValidator,
                  readOnly: true,
                  onTap: onCheckInTap,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AppTextField(
                  label: 'Check-out',
                  hint: 'dd/mm/yyyy',
                  prefixIcon: Icons.calendar_month_outlined,
                  controller: checkOutController,
                  validator: checkOutValidator,
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
            validator: TripValidators.price,

            keyboardType: const TextInputType.numberWithOptions(decimal: true),

            inputFormatters: [MoneyInputFormatter()],
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
    final scheme = Theme.of(context).colorScheme;
    final statuses = Theme.of(context).extension<AppStatusColors>()!;
    final bool increased = difference > 0;
    final bool decreased = difference < 0;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _PriceValue(
                  label: 'Original',
                  value: '€${_formatMoney(originalTotal)}',
                ),
              ),

              Icon(Icons.arrow_forward_rounded, color: scheme.onSurfaceVariant),

              Expanded(
                child: _PriceValue(
                  label: 'Updated',
                  value: '€${_formatMoney(updatedTotal)}',
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  increased
                      ? Icons.trending_up_rounded
                      : decreased
                      ? Icons.trending_down_rounded
                      : Icons.remove_rounded,

                  color: increased
                      ? scheme.error
                      : decreased
                      ? statuses.success
                      : scheme.onSurfaceVariant,
                ),

                const SizedBox(width: 8),

                Text(
                  differenceText,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,

                    color: increased
                        ? scheme.error
                        : decreased
                        ? statuses.success
                        : scheme.onSurface,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  'difference',
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
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

  const _PriceValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 12,
            color: scheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: GoogleFonts.quicksand(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: scheme.onSurface,
          ),
        ),
      ],
    );
  }
}
