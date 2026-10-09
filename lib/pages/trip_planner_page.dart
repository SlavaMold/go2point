import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/section_title.dart';

class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  State<TripPlannerPage> createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  final TextEditingController _eventDateController =
      TextEditingController();

  final TextEditingController _arrivalDateController =
      TextEditingController();

  final TextEditingController _departureDateController =
      TextEditingController();

  final TextEditingController _budgetController =
      TextEditingController();

  int _budgetDeviation = 15;
  DateTime? _arrivalDate;
  DateTime? _departureDate;


  @override
  void initState() {
    super.initState();

    // Когда пользователь меняет бюджет,
    // экран автоматически пересчитывает диапазон.
    _budgetController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _eventDateController.dispose();
    _arrivalDateController.dispose();
    _departureDateController.dispose();
    _budgetController.dispose();

    super.dispose();
  }

  // ==============================
  // DATE PICKER
  // ==============================

  Future<DateTime?> _selectDate({
  required DateTime firstDate,
  DateTime? initialDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2035),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
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

    return double.tryParse(text) ?? 0;
  }

  double get _minimumBudget {
    return _budget * (1 - _budgetDeviation / 100);
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
          'Plan my trip',
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
            35,
          ),

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
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Tell us where you are going and what brings you there.',
                style: GoogleFonts.quicksand(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 32),

              // =========================
              // SECTION 1 — JOURNEY
              // =========================

              const SectionTitle(
                number: '1',
                title: 'Your journey',
              ),

              const SizedBox(height: 18),

              const AppTextField(
                label: 'From',
                hint: 'Chisinau, Moldova',
                prefixIcon: Icons.flight_takeoff_rounded,
              ),

              const SizedBox(height: 20),

              const AppTextField(
                label: 'Destination',
                hint: 'Budapest, Hungary',
                prefixIcon: Icons.location_on_outlined,
              ),

              const SizedBox(height: 34),

              // =========================
              // SECTION 2 — EVENT
              // =========================

              const SectionTitle(
                number: '2',
                title: 'Your event',
              ),

              const SizedBox(height: 18),

              const AppTextField(
                label: 'Event',
                hint: 'Concert, exhibition, theatre...',
                prefixIcon: Icons.confirmation_number_outlined,
              ),

              const SizedBox(height: 20),

              const AppTextField(
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
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.map_rounded,
                      size: 44,
                      color: AppColors.purple,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Map preview',
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkText,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Interactive map will be added later',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        color: AppColors.secondaryText,
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
                onTap: () async {
                  final selectedDate = await _selectDate(
                    firstDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    _eventDateController.text = _formatDate(selectedDate);
                  }
                },
              ),

              const SizedBox(height: 34),

              // =========================
              // SECTION 3 — STAY
              // =========================

              const SectionTitle(
                number: '3',
                title: 'Your stay',
              ),

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
                      onTap: () async {
                        final selectedDate = await _selectDate(
                          firstDate: DateTime.now(),
                          initialDate: _arrivalDate,
                        );

                        if (selectedDate != null) {
                          setState(() {
                            _arrivalDate = selectedDate;

                            _arrivalDateController.text =
                                _formatDate(selectedDate);

                            // Если старая дата отъезда теперь раньше
                            // новой даты приезда — сбрасываем её.
                            if (_departureDate != null &&
                                _departureDate!.isBefore(_arrivalDate!)) {
                              _departureDate = null;
                              _departureDateController.clear();
                            }
                          });
                        }
                      },
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

                      // Пока Arrival не выбрана — поле disabled.
                      enabled: _arrivalDate != null,

                      onTap: _arrivalDate == null
                          ? null
                          : () async {
                              final selectedDate = await _selectDate(
                                firstDate: _arrivalDate!,
                                initialDate: _departureDate ?? _arrivalDate!,
                              );

                              if (selectedDate != null) {
                                setState(() {
                                  _departureDate = selectedDate;

                                  _departureDateController.text =
                                      _formatDate(selectedDate);
                                });
                              }
                            },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // =========================
              // SECTION 4 — BUDGET
              // =========================

              const SectionTitle(
                number: '4',
                title: 'Your budget',
              ),

              const SizedBox(height: 18),

              AppTextField(
                label: 'Budget',
                hint: '600',
                prefixText: '€ ',
                prefixIcon: Icons.account_balance_wallet_outlined,
                controller: _budgetController,

                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),

                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*[.,]?\d{0,2}'),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Text(
                'Allowed deviation',
                style: GoogleFonts.quicksand(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
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
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    _DeviationButton(
                      icon: Icons.remove,
                      onPressed: _decreaseDeviation,
                    ),

                    const Spacer(),

                    Text(
                      '$_budgetDeviation%',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkText,
                      ),
                    ),

                    const Spacer(),

                    _DeviationButton(
                      icon: Icons.add,
                      onPressed: _increaseDeviation,
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
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.purple,
                    ),

                    const SizedBox(width: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated budget range',
                          style: GoogleFonts.quicksand(
                            fontSize: 12,
                            color: AppColors.secondaryText,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          '€${_formatMoney(_minimumBudget)} — '
                          '€${_formatMoney(_maximumBudget)}',
                          style: GoogleFonts.quicksand(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkText,
                          ),
                        ),
                      ],
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
// PRIVATE WIDGET FOR +/- BUTTONS
// =====================================================

class _DeviationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _DeviationButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),

      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),

        child: SizedBox(
          width: 36,
          height: 36,

          child: Icon(
            icon,
            size: 18,
            color: AppColors.purple,
          ),
        ),
      ),
    );
  }
}