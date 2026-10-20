import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../validation/trip_validators.dart';
import '../validation/money_input_formatter.dart';
import '../models/trip_route.dart';
import '../widgets/app_feedback.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/section_title.dart';

class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  State<TripPlannerPage> createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  final _fromController = TextEditingController();
  final _destinationController = TextEditingController();
  final _eventController = TextEditingController();
  final _eventLocationController = TextEditingController();

  final TextEditingController _eventDateController = TextEditingController();

  final TextEditingController _arrivalDateController = TextEditingController();

  final TextEditingController _departureDateController =
      TextEditingController();

  final TextEditingController _budgetController = TextEditingController();

  int _budgetDeviation = 15;
  DateTime? get _arrivalDate =>
      TripValidators.parseDate(_arrivalDateController.text);
  DateTime? get _departureDate =>
      TripValidators.parseDate(_departureDateController.text);

  @override
  void initState() {
    super.initState();

    _budgetController.addListener(_onBudgetChanged);
  }

  void _onBudgetChanged() => setState(() {});

  @override
  void dispose() {
    _budgetController.removeListener(_onBudgetChanged);
    for (final controller in [
      _fromController,
      _destinationController,
      _eventController,
      _eventLocationController,
      _eventDateController,
      _arrivalDateController,
      _departureDateController,
      _budgetController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(
    TextEditingController controller, {
    DateTime? firstDate,
  }) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final first = firstDate ?? today;
    var initial = TripValidators.parseDate(controller.text) ?? first;
    if (initial.isBefore(first)) initial = first;
    final selected = await showDatePicker(
      context: context,
      firstDate: first,
      initialDate: initial,
      lastDate: DateTime(2100, 12, 31),
    );
    if (!mounted || selected == null) return;
    setState(() {
      controller.text = formatTripDate(selected);
      if (controller == _arrivalDateController &&
          _departureDate != null &&
          _departureDate!.isBefore(selected)) {
        _departureDateController.clear();
      }
    });
  }

  void _submit() {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    showAppMessage(context, 'Trip details are valid. Showing demo routes.');
    context.push('/plan/alternatives');
  }

  // ==============================
  // BUDGET DEVIATION
  // ==============================

  void _increaseDeviation() {
    if (_budgetDeviation < 50) {
      setState(() {
        _budgetDeviation++;
      });
    }
  }

  void _decreaseDeviation() {
    if (_budgetDeviation > 0) {
      setState(() {
        _budgetDeviation--;
      });
    }
  }

  // ==============================
  // BUDGET CALCULATION
  // ==============================

  double get _budget {
    final text = _budgetController.text.replaceAll(',', '.');

    final value = double.tryParse(text);
    return value != null && value.isFinite && value > 0 ? value : 0;
  }

  double get _minimumBudget {
    return 0;
  }

  double get _maximumBudget {
    return _budget * (1 + _budgetDeviation / 100);
  }

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }

    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,

      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,

        title: Text(
          'Plan my trip',
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
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 35),

          child: Form(
            key: _formKey,
            autovalidateMode: _submitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // PAGE HEADER
                // =========================

                Text(
                  'Let’s build your journey',
                  style: GoogleFonts.quicksand(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Tell us where you are going and what brings you there.',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 32),

                // =========================
                // SECTION 1 — JOURNEY
                // =========================
                const SectionTitle(number: '1', title: 'Your journey'),

                const SizedBox(height: 18),

                AppTextField(
                  controller: _fromController,
                  validator: TripValidators.requiredText,
                  label: 'From',
                  hint: 'Chisinau, Moldova',
                  prefixIcon: Icons.flight_takeoff_rounded,
                ),

                const SizedBox(height: 20),

                AppTextField(
                  controller: _destinationController,
                  validator: TripValidators.requiredText,
                  label: 'Destination',
                  hint: 'Budapest, Hungary',
                  prefixIcon: Icons.location_on_outlined,
                ),

                const SizedBox(height: 34),

                // =========================
                // SECTION 2 — EVENT
                // =========================
                const SectionTitle(number: '2', title: 'Your event'),

                const SizedBox(height: 18),

                AppTextField(
                  controller: _eventController,
                  validator: TripValidators.requiredText,
                  label: 'Event',
                  hint: 'Concert, exhibition, theatre...',
                  prefixIcon: Icons.confirmation_number_outlined,
                ),

                const SizedBox(height: 20),

                AppTextField(
                  controller: _eventLocationController,
                  validator: TripValidators.requiredText,
                  label: 'Event location',
                  hint: 'Enter address',
                  prefixIcon: Icons.pin_drop_outlined,
                  suffixIcon: Icons.map_outlined,
                ),

                const SizedBox(height: 14),

                // Пока статическая заглушка карты
                Container(
                  width: double.infinity,
                  height: 150,

                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map_rounded, size: 44, color: scheme.primary),

                      const SizedBox(height: 8),

                      Text(
                        'Map preview',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Interactive map will be added later',
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Event date
                AppTextField(
                  label: 'Event date',
                  hint: 'dd/mm/yyyy',
                  prefixIcon: Icons.event_outlined,
                  suffixIcon: Icons.calendar_month_outlined,
                  controller: _eventDateController,
                  readOnly: true,
                  validator: (value) => TripValidators.date(
                    value,
                    notBefore: _arrivalDate ?? DateTime.now(),
                    notAfter: _departureDate,
                    beforeMessage: 'Event must be during your stay',
                    afterMessage: 'Event must be during your stay',
                  ),
                  onTap: () => _pickDate(_eventDateController),
                ),

                const SizedBox(height: 34),

                // =========================
                // SECTION 3 — STAY
                // =========================
                const SectionTitle(number: '3', title: 'Your stay'),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Arrival',
                        hint: 'dd/mm/yyyy',
                        prefixIcon: Icons.flight_land_rounded,
                        suffixIcon: Icons.calendar_month_outlined,
                        controller: _arrivalDateController,
                        readOnly: true,
                        validator: (value) => TripValidators.date(
                          value,
                          notBefore: DateTime.now(),
                          beforeMessage: 'Arrival cannot be in the past',
                        ),
                        onTap: () => _pickDate(_arrivalDateController),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: AppTextField(
                        label: 'Departure',
                        hint: 'dd/mm/yyyy',
                        prefixIcon: Icons.flight_takeoff_rounded,
                        suffixIcon: Icons.calendar_month_outlined,
                        controller: _departureDateController,

                        readOnly: true,

                        validator: (value) => TripValidators.date(
                          value,
                          notBefore: _arrivalDate ?? DateTime.now(),
                          beforeMessage: 'Departure cannot precede arrival',
                        ),
                        onTap: () => _pickDate(
                          _departureDateController,
                          firstDate: _arrivalDate,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 34),

                // =========================
                // SECTION 4 — BUDGET
                // =========================
                const SectionTitle(number: '4', title: 'Your budget'),

                const SizedBox(height: 18),

                AppTextField(
                  label: 'Budget',
                  hint: '600',
                  prefixText: '€ ',
                  prefixIcon: Icons.account_balance_wallet_outlined,
                  controller: _budgetController,
                  validator: TripValidators.budget,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),

                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                  inputFormatters: [MoneyInputFormatter()],
                ),

                const SizedBox(height: 22),

                Text(
                  'Extra budget allowance',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),

                const SizedBox(height: 10),

                // =========================
                // DEVIATION CONTROL
                // =========================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Row(
                    children: [
                      _DeviationButton(
                        icon: Icons.remove,
                        onPressed: _budgetDeviation > 0
                            ? _decreaseDeviation
                            : null,
                      ),

                      const Spacer(),

                      Text(
                        '$_budgetDeviation%',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),

                      const Spacer(),

                      _DeviationButton(
                        icon: Icons.add,
                        onPressed: _budgetDeviation < 50
                            ? _increaseDeviation
                            : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // =========================
                // CALCULATED BUDGET RANGE
                // =========================
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, color: scheme.primary),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimated budget range',
                              style: GoogleFonts.quicksand(
                                fontSize: 12,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              '€${_formatMoney(_minimumBudget)} — '
                              '€${_formatMoney(_maximumBudget)}',
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: scheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // =========================
                // BUILD ROUTE BUTTON
                // =========================
                AppButton(
                  text: 'Build my route',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: _submit,
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
// PRIVATE WIDGET FOR +/- BUTTONS
// =====================================================

class _DeviationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _DeviationButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      shape: const CircleBorder(),

      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),

        child: SizedBox(
          width: 36,
          height: 36,

          child: Icon(icon, size: 18, color: scheme.primary),
        ),
      ),
    );
  }
}
