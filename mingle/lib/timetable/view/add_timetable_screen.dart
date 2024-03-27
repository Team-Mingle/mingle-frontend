import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/search_course_modal.dart';
import 'package:mingle/timetable/model/class_model.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';
import 'package:mingle/timetable/view/self_add_timetable_screen.dart';
import 'package:mingle/timetable/components/timetable_grid.dart';

class AddTimeTableScreen extends StatefulWidget {
  final Function addClass;
  final List<Widget> addedClasses;
  const AddTimeTableScreen(
      {super.key, required this.addClass, required this.addedClasses});

  @override
  State<AddTimeTableScreen> createState() => _AddTimeTableScreenState();
}

class _AddTimeTableScreenState extends State<AddTimeTableScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 650)).then((_) {
      showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return const SearchCourseModalWidget();
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void addClassesAtAddTimeTableScreen(ClassModel classModel) {
      setState(() {
        widget.addedClasses.addAll(classModel.generateClases());
      });
    }

    // print(t);
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SvgPicture.asset(
                      "assets/img/post_screen/cross_icon.svg",
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                const Text(
                  " 강의 추가하기",
                  style: TextStyle(
                      color: GRAYSCALE_GRAY_03,
                      fontSize: 14.0,
                      letterSpacing: -0.01,
                      height: 1.4,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      "직접 추가",
                      style: TextStyle(
                          color: PRIMARY_COLOR_ORANGE_01,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddDirectTimeTableScreen(
                            addClass: widget.addClass,
                            addClassesAtAddTimeTableScreen:
                                addClassesAtAddTimeTableScreen,
                          ))),
                ),
              ],
            ),
            centerTitle: false, // Set centerTitle to false
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 11.0,
                ),
                TimeTableGrid(
                  addedClasses: widget.addedClasses,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
