import 'package:flutter/material.dart';
import 'package:kitx/Utils/Network.dart';
import 'package:kitx/main.dart';

// await Themes.takeMode(null);
// ThemesWidget(),

class Themes
{
  static bool mode = true;
  static const Color mainColor = Color(0xff54A7F0);
  static const Color secondaryColor = Color(0xffB6D9F7);
  static MaterialColor back = lightSwatch;
  static MaterialColor front = darkSwatch;

  static Future<void> changeMode(bool v) async
  {
    mode = await v;
    await storage.write(key: "mode", value: mode ? "light" : "dark");
    main();
  }

  static Future<String?> readMode() async => await storage.read(key: "mode");

  static Future<void> changeModeS(bool S) async
  {
    back = await S ? lightSwatch : darkSwatch;
    front = await S ? darkSwatch : lightSwatch;
  }

  static Future<void> takeMode(BuildContext? context) async
  {
    String? d = await readMode();
    switch (d)
    {
      case "light":
        mode = true;
        break;
      case "dark":
        mode = false;
        break;
      default:
        mode = await context != null ? (MediaQuery.of(context!).platformBrightness == Brightness.light ? true : false) : true;
        break;
    }
    await changeModeS(mode);
  }

  static MaterialColor mainSwatch = MaterialColor(
    mainColor.value,
    const <int, Color>{
      50: mainColor,
      100: mainColor,
      200: mainColor,
      300: mainColor,
      400: mainColor,
      500: mainColor,
      600: mainColor,
      700: mainColor,
      800: mainColor,
      900: mainColor,
    },
  );

  static MaterialColor secondarySwatch = MaterialColor(
    secondaryColor.value,
    const <int, Color>{
      50: secondaryColor,
      100: secondaryColor,
      200: secondaryColor,
      300: secondaryColor,
      400: secondaryColor,
      500: secondaryColor,
      600: secondaryColor,
      700: secondaryColor,
      800: secondaryColor,
      900: secondaryColor,
    },
  );

  static MaterialColor darkSwatch = MaterialColor(
    Colors.black.value,
    <int, Color>{
      100: Colors.black12,
      200: Colors.black26,
      300: Colors.black38,
      400: Colors.black45,
      500: Colors.black54,
      600: Colors.black87,
    },
  );

  static MaterialColor lightSwatch = MaterialColor(
    Colors.white.value,
    <int, Color>{
      100: Colors.white10,
      200: Colors.white12,
      300: Colors.white24,
      400: Colors.white30,
      500: Colors.white38,
      600: Colors.white54,
      700: Colors.white60,
      800: Colors.white70,
    },
  );
}

class ThemesWidget extends StatefulWidget
{
  const ThemesWidget({super.key});

  @override
  State<ThemesWidget> createState() => _ThemesWidgetState();
}

class _ThemesWidgetState extends State<ThemesWidget>
{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            style: TextStyle(
                fontSize: 18, color: Themes.mainColor, fontFamily: "SFUI"),
            "Koyu Mod"),
        Switch(
            hoverColor: Themes.mainColor,
            value: !Themes.mode,
            onChanged: (v) async {
              await Themes.changeMode(!v);
              setState(() {
                Themes.mode;
              });
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => Splash()));
            }),
      ],
    );
  }
}
