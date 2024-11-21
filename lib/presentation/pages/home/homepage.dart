import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.maxFinite,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 32, left: 24, right: 24),
                color: neutralTheme,
                height: double.infinity,
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/Logo_white.png', height: 34),
                      SizedBox(height: 16),
                      Text(
                        'Hi, Satria Abrar 👋',
                        style: TextStyle(
                            fontSize: 28,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Find Your Perfect Look in a Snap!',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(24),
                  height: 480,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
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
                          padding: EdgeInsets.all(8),
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
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://lh5.googleusercontent.com/p/AF1QipMM4gOpnqmBkrFlMo11kk4tCFi_4DVq6nVJ6h9B=w114-h114-n-k-no',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Berkah Barbershop',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: neutralTheme,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
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
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 14),
                        Text('Schedule Your Shave',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: neutralTheme)),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: neutralTheme[100]!),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(children: [
                            Container(
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
                                        'Choose a Date',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: neutralTheme[300]),
                                      ),
                                    ],
                                  ),
                                  Icon(IconsaxOutline.arrow_down_1)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
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
                                      Icon(IconsaxBold.clock),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Choose a Date',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: neutralTheme[300]),
                                      ),
                                    ],
                                  ),
                                  Icon(IconsaxOutline.arrow_down_1)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
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
                                      Icon(IconsaxBold.scissor),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Choose a Date',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: neutralTheme[300]),
                                      ),
                                    ],
                                  ),
                                  Icon(IconsaxOutline.arrow_down_1)
                                ],
                              ),
                            ),
                            SizedBox(
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
        ),
      ),
    );
  }
}
