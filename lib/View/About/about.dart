import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../backWidget.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = "/AboutScreen";
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leading: const BackWidget(),
       elevation: 2,
       backgroundColor: const Color(0xFFFFE400),
       centerTitle: true,
       title: Text("About us", style: Theme.of(context).textTheme.headline5,),
     ),
     body: Padding(
       padding: const EdgeInsets.all(20),
       child:SingleChildScrollView(
         child: Column(
             children:  [
                const Text('Coin Market platform for cryptocurrencies',
                 style: TextStyle(
                     color: Colors.black, fontSize: 25)),
                const SizedBox(height: 15,),
               RichText(
                   text: const TextSpan(
                     children: [
                       TextSpan(
                         text: 'B',
                         style: TextStyle(
                           color: Colors.black54, fontSize: 25)),
                        TextSpan(
                         text: 'tcMining provides Bitcoin mining ASIC chips, chip design, software and services for blockchain based applications and transaction processing, Has offering such as BTC Cloud Mining and BTC Wallet for consumers ti mine and store bitcoins.',
                         style: TextStyle(
                           color: Colors.black54, fontSize: 16
                         )
                       )
                     ]
                   )),
               const SizedBox(height: 20,),
               const Text('BTC Mining Overview',
                   style: TextStyle(
                       color: Colors.blue, fontSize: 22)),
               const SizedBox(height: 10,),
               const Row(
                 children: [
                   Text('Founded Year : ',
                       style: TextStyle(
                           color: Colors.black, fontSize: 16,)),
                   Text('2020',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               // const SizedBox(height: 10,),
               const Row(
                 children: [
                   Text('Location : ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                   Text('Stockhoim, Sweden',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               const Row(
                 children: [
                   Text('Company Stage : ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                   Text('Series B',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               const Row(
                 children: [
                   Text('Total Funding : ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                   Text('\$32M',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               const Row(
                 children: [
                   Text('Last Funding Round : ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                   Text('\$2.9M',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               const SizedBox(height: 20,),
               const Text('Since the company operations in 2020, the company investors have obtained more then 100 times the return on investment. ',
                   style: TextStyle(
                       color: Colors.black54, fontSize: 16)),
               const SizedBox(height: 5,),
               const Text('BTC Mining truly single-handedly changed the face of Bitcoin mining',
                   style: TextStyle(
                       color: Colors.black54, fontSize: 16)),
               const SizedBox(height: 30,),
               const Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                  Text('BTC Mining Funding Rounds',
                       style:TextStyle(
                           color: Colors.blue, fontSize: 20)),
                 ],
               ),
               const SizedBox(height: 15,),
               const Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text('Date ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                   Text('Funding\nAmount ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                   Text('Funding\nRound ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                   Text('Investor\nDetails ',
                       style: TextStyle(
                         color: Colors.black, fontSize: 16,)),
                 ],
               ),
               const SizedBox(height: 15,),
               const Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text('Jan\n04\n2021 ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('\$2.95M ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('Series B ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('Accel ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               const SizedBox(height: 10,),
               const Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text('Feb\n03\n2022 ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('\$1.5M ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('Series B ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('Accel\nCreandum,\n2 others',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               const SizedBox(height: 10,),
               const Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text('Sep\n04\n2023 ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('\$1.4M ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('Series A ',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                   Text('Creandum',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 16,)),
                 ],
               ),
               const SizedBox(height: 30,),
               const Text('BTC Mining Investors',
                   style: TextStyle(
                       color: Colors.blue, fontSize: 22)),
               const SizedBox(height: 20,),
               Row(
                 children: [
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset("assets/partners/accels.png")),
                   const SizedBox(width: 10,),
                   const Text('Accel Palo Alto, United States',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 15,)),
                 ],
               ),
               const SizedBox(height: 30,),
               Row(
                 children: [
                   SizedBox(
                       width: 60,
                       height: 60,
                       child: Image.asset("assets/partners/GP.png")),
                   const SizedBox(width: 10,),
                   const Text('GP Bullhound London,\nUnited Kingdom',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 15,)),
                 ],
               ),
               const SizedBox(height: 30,),
               Row(
                 children: [
                   SizedBox(
                       width: 60,
                       height: 60,
                       child: Image.asset("assets/partners/Creandum.png")),
                   const SizedBox(width: 10,),
                   const Text('Creandum Stockholm, Sweden',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 15,)),
                 ],
               ),
               const SizedBox(height: 30,),
               Row(
                 children: [
                   SizedBox(
                       width: 60,
                       height: 60,
                       child: Image.asset("assets/partners/triple.png")),
                   const SizedBox(width: 10,),
                   const Text('TriplePoint Capital Menio Park,\nUnited States',
                       style: TextStyle(
                         color: Colors.black54, fontSize: 15,)),
                 ],
               ),
               const SizedBox(height: 30,),
               const Text('About',
                   style: TextStyle(
                       color: Colors.blue, fontSize: 25)),
               const SizedBox(height: 10,),
               const Text('We bring new Bitcoin miners alive BTC Mining focuses on producing mainers for cryptocurrencies',
                   style: TextStyle(
                       color: Colors.black54, fontSize: 16)),
               const SizedBox(height: 30,),
               const Text('Legal Name BitCoin Mining',
                   style: TextStyle(
                       color: Colors.black54, fontSize: 16)),
               const SizedBox(height: 30,),
               const Text('BTC Mining is headquartered in Stockholm, Sweden and was founded by their own companies ORSoC AB and Kenmar & Cole AB, OR SoC is a professional embedded electronic product designer that can be tested. It focuses on FPGA and ASIC. He has nealy 10 years of experience in integrated design service product electronics development. BTC Mining is more like an excellent talent. In Series B financing. This round of financing was led by Accel Partners, an international venture capital fund. Other Investors include mining companies and Bullhound Creandum. ',
                   style: TextStyle(
                       color: Colors.black54, fontSize: 16)),
               const SizedBox(height: 30,),
               const Text('Welcome everyone to join BTC Mining and use the encrypted digital mining machine produced produced by our company. ',
                   style: TextStyle(
                       color: Colors.black54, fontSize: 16)),
               const SizedBox(height: 60,),
               const Text('',
                   style: TextStyle(
                       color: Colors.black54, fontSize: 16)),
             ],
         ),
       ),
     ),
   );
  }

}