import 'package:btcmining/Login_Pages/auth/firebase_consts.dart';
import 'package:btcmining/Login_Pages/auth/login.dart';
import 'package:btcmining/Profile/profile_data.dart';
import 'package:btcmining/Profile/update_profile_screen.dart';
import 'package:btcmining/View/Widget/loading_manager.dart';
import 'package:btcmining/constants/colors.dart';
import 'package:btcmining/constants/sizes.dart';
import 'package:btcmining/constants/text_strings.dart';
import 'package:btcmining/services/global_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Login_Pages/auth/forget_password.dart';
import '../View/Components/text_widget.dart';
import '../View/Refer/ReferEarn.dart';
import '../View/Tasks/task_Screen.dart';
import '../View/Withdrwal/withdrawal_screen.dart';
import '../View/backWidget.dart';
import '../View/customer_support/customer_Support.dart';
import '../View/orders/orders_screen.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _email;
  String? _name;
  String? profile;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState(){
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if(user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if(userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        profile = userDoc.get('profile').toString();

      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      //****************************** AppBar Code *******************************************
      // appBar: AppBar(
      //   leading: const BackWidget(),
      //   elevation: 2,
      //   backgroundColor: const Color(0xFFFFE400),
      //   title: Text(tProfile, style: Theme.of(context).textTheme.headline5),
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(isDark? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
      //   ],
      // ),
      //****************************** End Code! *******************************************
      body:LoadingManager(
            isLoading: _isLoading,
            child: SingleChildScrollView(
              child: Container(
                padding:  const EdgeInsets.all(tDefaultSize),
                child: Column(
                  children:  [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.yellow, width: 5)
                      ),
                      child: _isLoading ?
                      const Center(child: CircularProgressIndicator(color: Color(0xffFBC700),),
                      ) :Stack(
                            children: [
                              SizedBox(
                                width: 120, height: 120,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FancyShimmerImage(
                                      imageUrl: profile!,
                                      boxFit: BoxFit.fill,
                                    )
                                    // Image.network(profile!
                                    //   ,loadingBuilder: (context, child, loadingProgress){
                                    //   if(loadingProgress == null) return child;
                                    //   return Center(child: CircularProgressIndicator());
                                    // },fit: BoxFit.fill,)
                                )
                              ),
                            ],
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(_name == null ? 'name' : _name!, style: Theme.of(context).textTheme.headline5,),
                    Text(_email == null ? 'email' : _email!, style: Theme.of(context).textTheme.bodyText2,),
                    const SizedBox(height: 20,),
                    SizedBox(width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const UpdateProfileScreen()));
                            },
                            // => Get.to(() => const UpdateProfileScreen()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                          child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
                        )),
                      const SizedBox(height: 30,),
                    const Divider(),
                    const SizedBox(height: 10,),

                  //  MENU
                    ProfileMenuWidget(title: "My Investment", icon: LineAwesomeIcons.coins, onPress: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const OrdersScreen()));
                    },),
                    ProfileMenuWidget(title: "My Tasks", icon: LineAwesomeIcons.tasks, onPress: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const TasksScreen()));
                    },),
                    ProfileMenuWidget(title: "Withdrawal", icon: LineAwesomeIcons.wallet, onPress: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const WithdrawalScreen()));
                    },),
                    ProfileMenuWidget(title: "Reset Password", icon: LineAwesomeIcons.lock, onPress: (){
                      GlobalMethods.navigateTo(ctx: context, routeName: ForgetPasswordScreen.routeName);
                    },),
                    ProfileMenuWidget(title: "Refer & Earn", icon: LineAwesomeIcons.share, onPress: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const ReferEarn()));
                    }),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10),
                    ProfileMenuWidget(title: "Customer Support", icon: LineAwesomeIcons.info, onPress: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const CustomerSupport()));
                    },),
                    ProfileMenuWidget(
                      title: user == null ? 'Login' : 'Logout',
                      icon: user == null ? IconlyLight.login : IconlyLight.logout,
                      textColor: Colors.red, endIcon: false, onPress: (){
                      if (user == null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen(),
                        ),
                        );
                        return;
                      }
                      GlobalMethods.warningDialog(title: 'Sign out', subtitle: 'Do you wanna sign out?', fct: () async{
                        await authInstance.signOut();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                        // authInstance.signOut();
                      }, context: context);
                    },),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: tAccentColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: tAccentColor),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon? Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: Colors.grey,)) : null,

    );
  }
}