import 'package:flutter/material.dart';

class CharacterCountTextField extends StatefulWidget {
  final int maxCharacterCount;
  final String hint;

  const CharacterCountTextField(
      {super.key, this.maxCharacterCount = 10, this.hint = ''});

  @override
  _CharacterCountTextFieldState createState() =>
      _CharacterCountTextFieldState();
}

class _CharacterCountTextFieldState extends State<CharacterCountTextField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(updateCharacterCount);
  }

  void updateCharacterCount() {
    setState(() {
      int currentCharacterCount = _textEditingController.text.length;

      if (currentCharacterCount > widget.maxCharacterCount) {
        _textEditingController.text =
            _textEditingController.text.substring(0, widget.maxCharacterCount);
        currentCharacterCount = widget.maxCharacterCount;
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.removeListener(updateCharacterCount);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
                hintText: widget.hint,
                border: InputBorder.none,
                counterText: ''),
            maxLength: widget.maxCharacterCount,
          ),
        ),
        Text(
            '${_textEditingController.text.length}/${widget.maxCharacterCount}'),
      ],
    );
  }
}
