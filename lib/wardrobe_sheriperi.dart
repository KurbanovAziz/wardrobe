// ignore_for_file: use_build_context_synchronously
import 'package:apphud/apphud.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_botom.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_dok.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getClosetMyWardrobeGarderob() async {
  final sohranGarderob = await SharedPreferences.getInstance();
  return sohranGarderob.getBool('closetmywardrobesecretapikeykpop') ?? true;
}

Future<void> setClosetMyWardrobeGarderob() async {
  final sohranGarderob = await SharedPreferences.getInstance();
  sohranGarderob.setBool('closetmywardrobesecretapikeykpop', true);
}

Future<void> restoreClosetMyWardrobe(BuildContext context) async {
  final wewrwe = await Apphud.hasPremiumAccess();
  final wersvve = await Apphud.hasActiveSubscription();
  if (wewrwe || wersvve) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("closetmywardrobesecretapikeykpop", true);
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Success!'),
        content: const Text('Your purchase has been restored!'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const CMWBotomBar(
                    indexScr: 0,
                  ),
                ),
                (route) => false,
              );
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Restore purchase'),
        content: const Text(
            'Your purchase is not found. Write to support: ${CMWDokum.suPorT}'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => {Navigator.of(context).pop()},
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
