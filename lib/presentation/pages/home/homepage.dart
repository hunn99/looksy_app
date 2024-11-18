import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:looksy_app/presentation/services/auth_services.dart';
import 'package:looksy_app/presentation/services/order_services.dart';
import 'package:looksy_app/presentation/services/service_services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<Map<String, dynamic>> pickedServices = [];
  final ServiceServices _serviceServices = ServiceServices();
  final OrderServices _orderServices = OrderServices();
  List<Map<String, dynamic>> services = []; // Layanan akan dimuat dari database
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    _getUsername();
    _loadUsername();
    _loadServices();
    _bookNow();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      // Jika token tidak ada, arahkan ke halaman login
      context.go('/login');
    }
  }

  Future<void> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        username = storedUsername;
      });
    } else {
      // If username is not found, redirect to login
      context.go('/login');
    }
  }

  // Ambil username dari SharedPreferences dan ubah huruf pertama menjadi kapital
  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username') ?? 'user'; // Default 'user' jika tidak ada
    setState(() {
      // Ubah huruf pertama menjadi kapital
      username = _capitalizeFirstLetter(storedUsername);
    });
  }

  // Fungsi untuk mengubah huruf pertama menjadi kapital
  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _loadServices() async {
    try {
      final fetchedServices = await _serviceServices.fetchServices();
      setState(() {
        services = fetchedServices ?? [];
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching services: $error');
      setState(() {
        services = [];
        isLoading = false;
      });
    }
  }

  double totalPayment = 0;

  void _openServiceSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                padding: const EdgeInsets.all(16),
                height: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Service",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: services.map((service) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: service["selected"],
                                onChanged: (bool? value) {
                                  setModalState(() {
                                    service["selected"] = value!;
                                    if (value) {
                                      pickedServices.add(service);
                                    } else {
                                      pickedServices.removeWhere((item) => item["id"] == service["id"]);
                                    }
                                    _calculateTotalPayment();
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  service["name"],
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                "Rp. ${service["price"]}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Payment",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rp. $totalPayment",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        // Simpan layanan yang dipilih ke dalam pickedServices
                        pickedServices = services
                            .where((service) => service["selected"])
                            .toList();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: neutralTheme,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _getPickedServicesText() {
    if (pickedServices.isEmpty) {
      return 'Choose service';
    }
    return pickedServices.map((service) => service["name"]).join(', ');
  }

  void _calculateTotalPayment() {
    setState(() {
      totalPayment = services
          .where((service) => service["selected"])
          .fold<double>(0, (sum, item) => sum + (item["price"] as int));
    });
  }

  void _bookNow() async {
    try {
      // Pastikan date dan time sudah dipilih
      if (selectedDate == null || selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Harap pilih tanggal dan waktu')),
        );
        return;
      }

      // Format date dan time ke string
      final formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
      final formattedTime = "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}";

      // Panggil fungsi createOrder dengan parameter pickedServices
      await _orderServices.createOrder(
        date: formattedDate, // Kirim date sebagai string
        time: formattedTime, // Kirim time sebagai string
        totalPayment: totalPayment, // Ambil nilai total pembayaran
        pickedServices: pickedServices, // Kirim layanan yang dipilih
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking berhasil!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuat booking: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.maxFinite,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
                color: neutralTheme,
                height: double.infinity,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/Logo_white.png', height: 34),
                    const SizedBox(height: 16),
                    Text(
                      'Hi, $username 👋',
                      style: TextStyle(
                          fontSize: 28,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Find Your Perfect Look in a Snap!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  height: height * 0.62,
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
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Berkah Barbershop',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: neutralTheme,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Jl. Danau Toba No.6, Malang',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: neutralTheme[300],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Schedule Your Shave',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: neutralTheme),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: neutralTheme[100]!),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(children: [
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: neutralTheme[100]!),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(IconsaxBold.calendar),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          selectedDate != null
                                              ? DateFormat('yMMMMd')
                                                  .format(selectedDate!)
                                              : 'Choose a Date',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: selectedDate != null
                                                ? neutralTheme
                                                : neutralTheme[300],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(IconsaxOutline.arrow_down_1)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: neutralTheme[100]!),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _selectTime(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(IconsaxBold.clock),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              selectedTime != null
                                                  ? selectedTime!
                                                      .format(context)
                                                  : 'Choose Hour',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: selectedTime != null
                                                    ? neutralTheme
                                                    : neutralTheme[300],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Icon(IconsaxOutline.arrow_down_1)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: neutralTheme[100]!),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _openServiceSelection(context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(IconsaxBold.scissor),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              _getPickedServicesText(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: pickedServices.isEmpty
                                                      ? neutralTheme[300]
                                                      : neutralTheme),
                                            ),
                                          ],
                                        ),
                                        const Icon(IconsaxOutline.arrow_down_1)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Button(
                              label: 'Book Now',
                              onTap: () {
                                _bookNow();
                              },
                              isDisabled: false,
                              colorBackground: neutralTheme,
                              colorText: Colors.white,
                            )
                          ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}