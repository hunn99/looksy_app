import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/data/datasources/remote_datasources/service_remote_datasources.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';

//widget utama
class ServiceSelectionWidget extends StatefulWidget {
  const ServiceSelectionWidget({super.key});

  @override
  ServiceSelectionWidgetState createState() => ServiceSelectionWidgetState();
}

class ServiceSelectionWidgetState extends State<ServiceSelectionWidget> {
  final ServiceServices _serviceServices = ServiceServices();
  List<Map<String, dynamic>> services = [];
  List<Map<String, dynamic>> pickedServices = [];
  double totalPayment = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

// Mengambil data layanan dari ServiceServices menggunakan API.
  Future<void> _loadServices() async {
    try {
      final fetchedServices = await _serviceServices.fetchServices();
      setState(() {
        services = fetchedServices;
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

// Menghitung total pembayaran dari layanan yang dipilih.
  void _calculateTotalPayment() {
    setState(() {
      totalPayment = services
          .where((service) => service["selected"])
          .fold<double>(0, (sum, item) => sum + (item["price"] as int));
    });
  }

  String _getPickedServicesText() {
    if (pickedServices.isEmpty) {
      return 'Choose a Service';
    }
    return pickedServices.map((service) => service["name"]).join(', ');
  }

// Menampilkan dialog untuk memilih layanan.
  void _openServiceSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ServiceSelectionDialog(
          services: services,
          onSelectionChanged: (updatedServices) {
            setState(() {
              services = updatedServices;
              pickedServices =
                  services.where((service) => service["selected"]).toList();
              _calculateTotalPayment();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openServiceSelection(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: neutralTheme[100]!),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(IconsaxBold.scissor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        _getPickedServicesText(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: pickedServices.isEmpty
                              ? neutralTheme[300]!
                              : neutralTheme,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(IconsaxOutline.arrow_down_1),
          ],
        ),
      ),
    );
  }
}

//Menampilkan daftar layanan dalam bentuk checklist.
class ServiceSelectionDialog extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final ValueChanged<List<Map<String, dynamic>>> onSelectionChanged;

  const ServiceSelectionDialog({
    required this.services,
    required this.onSelectionChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 500,
        child: StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Service",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: services.map((service) {
                      return ServiceRow(
                        service: service,
                        onChanged: (selected) {
                          setModalState(() {
                            service["selected"] = selected;
                          });
                          onSelectionChanged(services);
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                TotalPaymentSection(
                  totalPayment: services
                      .where((service) => service["selected"])
                      .fold<double>(
                          0, (sum, item) => sum + (item["price"] as int)),
                ),
                const SizedBox(height: 16),
                LargeFillButton(
                  label: 'Done',
                  onPressed: () => Navigator.pop(context),
                  isDisabled: false,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

//Widget untuk menampilkan setiap layanan dalam list. Memiliki nama, harga, dan checkbox untuk memilih layanan.
class ServiceRow extends StatelessWidget {
  final Map<String, dynamic> service;
  final ValueChanged<bool> onChanged;

  const ServiceRow({required this.service, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: service["selected"],
          onChanged: (bool? value) {
            onChanged(value ?? false);
          },
        ),
        Expanded(
          child: Text(
            service["name"],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Text(
          "Rp. ${service["price"]}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Menampilkan total pembayaran di bagian bawah dialog.
class TotalPaymentSection extends StatelessWidget {
  final double totalPayment;

  const TotalPaymentSection({required this.totalPayment, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Total Payment",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Rp. $totalPayment",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
