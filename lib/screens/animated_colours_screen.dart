import 'package:flutter/material.dart';

import '../widgets/elevatedbutton_widget.dart';
import '../widgets/popup_menu_widget.dart';
import '../widgets/textformfield_widget.dart';

class AnimatedColoursScreen extends StatefulWidget {
  static const routeName = 'animated-colours';
  const AnimatedColoursScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedColoursScreen> createState() => _AnimatedColoursScreenState();
}

class _AnimatedColoursScreenState extends State<AnimatedColoursScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  Duration? animationDuration = const Duration(seconds: 4);

  final _form = GlobalKey<FormState>();
  String? text = '';
  Color firstGradientColour = const Color.fromRGBO(255, 255, 255, 1);
  Color secondGradientColour = const Color.fromRGBO(123, 132, 122, 1);
  Color decorationColour = Colors.black;

  TextEditingController rController = TextEditingController();
  TextEditingController gController = TextEditingController();
  TextEditingController bController = TextEditingController();
  TextEditingController secondRController = TextEditingController();
  TextEditingController secondGController = TextEditingController();
  TextEditingController secondBController = TextEditingController();

  String? formValidator(String? text) {
    if(text == null || int.tryParse(text) == null) {
      return 'The field cannot be empty';
    }
    if (int.tryParse(text)! > 256) {
      return 'The value should be less than 256';
    }
    return null;
  }

  void showMyColour() {
    if (_form.currentState!.validate()) {
      setState(() {
        firstGradientColour = Color.fromRGBO(
          int.parse(rController.text),
          int.parse(gController.text),
          int.parse(bController.text),
          1,
        );
        secondGradientColour = Color.fromRGBO(
          int.parse(secondRController.text),
          int.parse(secondGController.text),
          int.parse(secondBController.text),
          1,
        );
        decorationColour = getTextColorForBackground(firstGradientColour);
      });
    }
  }

  Color getTextColorForBackground(Color backgroundColour) {
    if (ThemeData.estimateBrightnessForColor(backgroundColour) ==
        Brightness.dark) {
      return Colors.white;
    }
    return Colors.black;
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: animationDuration);
    _topAlignmentAnimation = TweenSequence([
      TweenSequenceItem(
        tween:
            Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      )
    ]).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween:
            Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
    ]).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            icon: Icon(
              Icons.home,
              color: decorationColour,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuWidget(color: decorationColour),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  firstGradientColour,
                  secondGradientColour,
                ],
                begin: _topAlignmentAnimation.value,
                end: _bottomAlignmentAnimation.value,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _form,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormFieldWidget(
                                validator: formValidator,
                                labelText: 'R',
                                fieldController: rController,
                                decorationColour: decorationColour,
                                onChanged: (text) {}),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormFieldWidget(
                              validator: formValidator,
                              labelText: 'G',
                              fieldController: gController,
                              decorationColour: decorationColour,
                              onChanged: (text) {},
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormFieldWidget(
                              validator: formValidator,
                              labelText: 'B',
                              fieldController: bController,
                              decorationColour: decorationColour,
                              onChanged: (text) {},
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButtonWidget(
                            text: 'Animate',
                            onPressed: rController.text.isNotEmpty &&
                                    secondRController.text.isNotEmpty &&
                                    secondGController.text.isNotEmpty &&
                                    secondBController.text.isNotEmpty &&
                                    gController.text.isNotEmpty &&
                                    bController.text.isNotEmpty
                                ? showMyColour
                                : null,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormFieldWidget(
                                validator: formValidator,
                                labelText: 'R',
                                fieldController: secondRController,
                                decorationColour: decorationColour,
                                onChanged: (text) {}),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormFieldWidget(
                                validator: formValidator,
                                labelText: 'G',
                                fieldController: secondGController,
                                decorationColour: decorationColour,
                                onChanged: (text) {}),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormFieldWidget(
                                validator: formValidator,
                                labelText: 'B',
                                fieldController: secondBController,
                                decorationColour: decorationColour,
                                onChanged: (text) {}),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
