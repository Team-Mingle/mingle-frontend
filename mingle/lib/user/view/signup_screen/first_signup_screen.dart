import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class FirstSignupScreen extends StatefulWidget {
  const FirstSignupScreen({super.key});

  @override
  State<FirstSignupScreen> createState() => _FirstSignupScreenState();
}

class _FirstSignupScreenState extends State<FirstSignupScreen> {
  final List<String> countryList = [
    '홍콩',
    '싱가포프',
    '영국',
  ];
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage("assets/img/signup_screen/cross_icon.png"),
                color: GRAYSCALE_BLACK,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: SvgPicture.asset(
            "assets/img/signup_screen/first_indicator.svg",
          )),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 32.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "재학 중인 학교가",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "어디에 위치해 있나요?",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text("원활한 앱 이용을 위해 재학 정보가 필요해요",
                      style: TextStyle(
                          color: GRAYSCALE_GRAY_03,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SvgPicture.asset("assets/img/signup_screen/globe_icon.svg"),
          SizedBox(
            height: 8,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              items: countryList
                  .map((String country) => DropdownMenuItem<String>(
                        value: country,
                        child: Text(
                          country,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                      ))
                  .toList(),
              value: selectedCountry,
              onChanged: (String? country) {
                setState(() {
                  selectedCountry = country;
                });
              },
              buttonStyleData: ButtonStyleData(
                height: 44,
                width: 170,
                padding: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: GRAYSCALE_GRAY_03,
                    ),
                    color: Colors.white),
                // elevation: 2,
              ),
              iconStyleData: IconStyleData(
                icon: SvgPicture.asset(
                    "assets/img/signup_screen/dropdown_button_icon.svg"),
                openMenuIcon: null,
                iconSize: 14,
                iconEnabledColor: Colors.yellow,
                iconDisabledColor: Colors.grey,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
