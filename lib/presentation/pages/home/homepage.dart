import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/widgets/form/date_field.dart';
import 'package:looksy_app/presentation/widgets/form/hour_field.dart';
import 'package:looksy_app/presentation/widgets/form/service_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isBarberShopOpen() {
  final now = DateTime.now();
  final start = TimeOfDay(hour: 9, minute: 0); // Jam buka
  final end = TimeOfDay(hour: 21, minute: 59); // Jam tutup

  // Konversi waktu ke menit sejak tengah malam
  int nowMinutes = now.hour * 60 + now.minute;
  int startMinutes = start.hour * 60 + start.minute;
  int endMinutes = end.hour * 60 + end.minute;

  return nowMinutes >= startMinutes && nowMinutes <= endMinutes;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bool isOpen = isBarberShopOpen();

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return SizedBox(
                height: double.infinity,
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      color: neutralTheme,
                      height: double.infinity,
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/logos/Logo_white.png',
                              height: 34),
                          const SizedBox(height: 12),
                          Text('Hi, ${state.user.username} 👋',
                              style: heading2White),
                          const SizedBox(height: 2),
                          Text('Find Your Perfect Look in a Snap!',
                              style: bodyWhite1),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: height * 0.65,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                height: 112,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: neutralTheme[100]!),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: double.infinity,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                            'https://lh5.googleusercontent.com/p/AF1QipMM4gOpnqmBkrFlMo11kk4tCFi_4DVq6nVJ6h9B=w114-h114-n-k-no',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Berkah Barbershop',
                                            style: heading4Black,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Jl. Danau Toba No.6, Malang',
                                            style: bodyGrey1,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: isOpen
                                                      ? greenTheme[100]
                                                      : redTheme[100],
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Text(
                                                  isOpen ? 'Open' : 'Close',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: isOpen
                                                        ? greenTheme[600]
                                                        : redTheme[600],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                height: 4,
                                                width: 4,
                                                decoration: BoxDecoration(
                                                  color: neutralTheme[100],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                isOpen
                                                    ? 'Closes 22:00'
                                                    : 'Opens at 09:00',
                                                style: bodyGrey2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Schedule Your Shave',
                                style: heading3Black,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: neutralTheme[100]!),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(children: [
                                  const DatePickerWidget(),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const TimePickerWidget(),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const ServiceSelectionWidget(),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  LargeFillButton(
                                    label: 'Book Now',
                                    onPressed: () {
                                      context.push('/history');
                                    },
                                    isDisabled: false,
                                  )
                                ]),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
