import 'package:flutter/material.dart';

const Color kColorAppbar = Color(0xFFFF6900);
const Color kOTTAAOrangeNew = Color(0xFFFF6900);
const Color kPrimaryBG = Color(0xff040811);
const Color kPrimaryFont = Colors.white;
const Color kBorderColor = Colors.pink;
const Color kButtonColor = Color(0xff1E1E1E);

const kKeyboardLayouts = {
  'QWERTY': 'Layout based on the QWERTY keyboard, the most common keyboard layout in the world.',
  'ABC': 'Layout based on the alphabet. The letters are arranged in alphabetical order.',
  'Keypad': 'Layout based on old phones. The letters are grouped on groups of 3 and are arranged in aplhabetical order.',
};

const String isLoggedInString = 'is_logged_in';

const String kServerUrl = "https://us-central1-keyboard-98820.cloudfunctions.net/viterbi";

const kLanguages = [
  {
    "name": "English",
    "code": "en",
  },
  {
    "name": "Español",
    "code": "es",
  }
];

const List<String> kQWERTYLayout = [
  'q',
  'w',
  'e',
  'r',
  't',
  'y',
  'u',
  'i',
  'o',
  'p',
  'a',
  's',
  'd',
  'f',
  'g',
  'h',
  'j',
  'k',
  'l',
  'ñ',
  'z',
  'x',
  'c',
  'v',
  'b',
  'n',
  'm',
  '.',
  ',',
  '?',
];

const List<String> kNumeric = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
  '-',
  '/',
  ':',
  ';',
  '(',
  ')',
  '\$',
  '&',
  '@',
  '"',
  ',',
  '.',
  '?',
  '!',
  '\'',
  '#',
  '*',
  '+',
  '=',
  '_',
];

const List<String> kABCLayout = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'ñ',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z',
  '.',
  ',',
  '?',
];
