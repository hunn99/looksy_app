import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/data/dto/requests/order_dto.dart';
import 'package:looksy_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:looksy_app/presentation/bloc/order/order_bloc.dart';
import 'package:looksy_app/presentation/pages/navigation/navigation.dart';
import 'package:looksy_app/presentation/utils/methods.dart';
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
                              BlocConsumer<OrderBloc, OrderState>(
                                listener: (context, state) {
                                  if (state is OrderLoading) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  if (state is OrderSuccess) {
                                    // Menutup dialog loading sebelum navigasi
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NavigationPage(
                                                initialIndex: 2),
                                      ),
                                    );
                                  }

                                  if (state is OrderFailed) {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(); // Menutup dialog

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Failed to create order: ${state.errorMessage}'),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.only(
                                          bottom:
                                              80, // Pastikan margin bawah tidak menabrak FAB
                                          left: 16, 
                                          right: 16,
                                        ),
                                        backgroundColor: Colors.red[
                                            600], // Warna latar belakang untuk visibilitas
                                        duration: const Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  final GlobalKey<DatePickerWidgetState>
                                      datePickerKey = GlobalKey();
                                  final GlobalKey<TimePickerWidgetState>
                                      timePickerKey = GlobalKey();
                                  final GlobalKey<ServiceSelectionWidgetState>
                                      serviceSelectionKey = GlobalKey();

                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: neutralTheme[100]!),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(children: [
                                      DatePickerWidget(key: datePickerKey),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      TimePickerWidget(key: timePickerKey),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      ServiceSelectionWidget(
                                          key: serviceSelectionKey),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      LargeFillButton(
                                        label: 'Book Now',
                                        onPressed: () {
                                          final selectedDate = datePickerKey
                                              .currentState?.selectedDate;
                                          final selectedTime = timePickerKey
                                              .currentState?.selectedTime;
                                          final pickedServices =
                                              serviceSelectionKey
                                                  .currentState?.pickedServices;
                                          final totalPayment =
                                              serviceSelectionKey
                                                  .currentState?.totalPayment;

                                          if (selectedDate == null ||
                                              selectedTime == null ||
                                              pickedServices == null ||
                                              pickedServices.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Please complete all fields')),
                                            );
                                            return;
                                          }

                                          final formattedDate =
                                              '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
                                          final formattedTime =
                                              selectedTime.format(context);
                                          context.read<OrderBloc>().add(
                                                OrderOrderEvent(
                                                  params: OrderDto(
                                                    date: convertDateFormat(
                                                        formattedDate),
                                                    time: formattedTime,
                                                    totalPayment: totalPayment!,
                                                    pickedServices:
                                                        pickedServices
                                                            .map((e) => e['id']
                                                                as int) // Extract 'id' from each map
                                                            .toList(),
                                                  ),
                                                ),
                                              );
                                        },
                                        isDisabled: false,
                                      )
                                    ]),
                                  );
                                },
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
