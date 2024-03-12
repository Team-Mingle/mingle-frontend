import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';

class AddFriendDialog extends StatefulWidget {
  const AddFriendDialog({super.key});

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  String currentNickname = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 32.0, right: 20.0, left: 20.0, bottom: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "해당 사용자를 친구로 등록하시려면\n           닉네임을 붙여 주세요.",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "친구 목록에 내가 작성한 닉네임으로 표시됩니다.",
                    style: TextStyle(color: GRAYSCALE_GRAY_04),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          currentNickname = value;
                        });
                      },
                      decoration: InputDecoration(
                          counterText: "",
                          isCollapsed: true,
                          hintText: "닉네임을 적어 주세요.",
                          helperStyle: const TextStyle(
                              color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                          suffix: Text("${currentNickname.length}/10"),
                          hintStyle: const TextStyle(color: GRAYSCALE_GRAY_02),
                          border: InputBorder.none),
                      maxLength: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 40.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              color: GRAYSCALE_GRAY_01_5,
                              border: Border.all(color: GRAYSCALE_GRAY_01_5),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "취소하기",
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_04,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              color: PRIMARY_COLOR_ORANGE_02,
                              border:
                                  Border.all(color: PRIMARY_COLOR_ORANGE_02),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "친구 추가하기",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
