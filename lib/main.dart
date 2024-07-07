import 'package:apphud/apphud.dart';
import 'package:closet_my_wardrobe_40_a/closet/models/brindi_enum.dart';
import 'package:closet_my_wardrobe_40_a/closet/models/garderob_model.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_botom.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_dok.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(BrindiTypeAdapter());
  Hive.registerAdapter(WhereToWearAdapter());
  Hive.registerAdapter(GarderobStyleAdapter());
  Hive.registerAdapter(GarderobCategoryAdapter());
  Hive.registerAdapter(GarderobModelAdapter());

  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  await Hive.openBox<GarderobModel>('garderobModel');
  runApp(const MyApp());

  await Apphud.start(apiKey: CMWDokum.aPpHadK);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Сloset My wardrobe',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: CMWColor.white,
          ),
          scaffoldBackgroundColor: CMWColor.white,
          fontFamily: 'Inter',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        home: const SplashScreen(
          seconds: 3,
          navigateAfterSeconds: CMWBotomBar(),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Widget navigateAfterSeconds;

  const SplashScreen({
    super.key,
    required this.seconds,
    required this.navigateAfterSeconds,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: widget.seconds), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => widget.navigateAfterSeconds),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CMWColor.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 53.w),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
