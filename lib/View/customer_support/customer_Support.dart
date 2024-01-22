import 'package:btcmining/View/Widget/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../backWidget.dart';

class CustomerSupport extends StatefulWidget {
  static const routeName = "/CustomerSupport";
  const CustomerSupport({Key? key}) : super(key: key);

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Uri whatsApp = Uri.parse('https://api.whatsapp.com/send?phone=917999372127');
    final Uri telegram = Uri.parse('https://t.me/B_T_C_Mining_Coins');
    final Uri instagram = Uri.parse('https://www.instagram.com/bitcoinmining_2023');
    final Uri email = Uri.parse('mailto:btcbitcoinmining01@gmail.com');
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 1,
        backgroundColor: const Color(0xFFFFE400),
        centerTitle: true,
        title: Text("Helping", style: Theme
            .of(context)
            .textTheme
            .headline5,),
      ),
      body: LoadingManager(
        isLoading:_isLoading,
        child: Container(
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Image.asset("assets/partners/heping.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Contact Information',
                    style: GoogleFonts.notoSerif(
                        color: Colors.black, fontSize: 25)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text("Closed ",
                      style: TextStyle(color: Colors.red, fontSize: 15),),
                    Text("9: 30 AM - 9: 90 PM ", style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(onPressed: () {
                        launchUrl(whatsApp);
                      },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.green)),
                        icon: const Icon(
                          LineAwesomeIcons.what_s_app, color: Colors.white,
                          size: 35,),
                        label: const Text(
                          'Whatsapp', style: TextStyle(fontSize: 15),),),
                      ElevatedButton.icon(onPressed: () {
                        launchUrl(telegram);
                      },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.blue)),
                        icon: const Icon(
                          LineAwesomeIcons.telegram, color: Colors.white,
                          size: 35,),
                        label: const Text(
                          'Telegram ', style: TextStyle(fontSize: 15),),)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(email);
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.redAccent)),
                        icon: const Icon(
                         Icons.forward_to_inbox, color: Colors.white,
                          size: 35,),
                        label: const Text(
                          'Send Email', style: TextStyle(fontSize: 15),),),
                      ElevatedButton.icon(onPressed: () {
                        launchUrl(instagram);
                      },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.pinkAccent)),
                        icon: const Icon(
                          LineAwesomeIcons.instagram, color: Colors.white,
                          size: 35,),
                        label: const Text(
                          'Instagram  ', style: TextStyle(fontSize: 15),),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

