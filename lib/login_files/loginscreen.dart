
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:satyameds/mainscreen/navigation_menu.dart';
import '../signup/signup_files/signup.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/helperfunctions.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/text_sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/constants/validators.dart';
import 'forgotpassword.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(LoginController());
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
    //  key: controller.loginFormkey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TextSizes.appbarheight,
            bottom: TextSizes.defaultSpace,
            right: TextSizes.defaultSpace,
            left: TextSizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                height: 150,
                image: AssetImage(dark ? TImages.loginlogo : TImages.loginlogo),
              ),
              Text(
                TText.logintitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TextSizes.sm),
              Text(
                TText.loginsubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: TextSizes.spacebtwSections),
                  child: Column(
                    children: [
                      TextFormField(
                        //controller: controller.emailin,
                        validator: (value)=>TValidator.validateEmail(value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: TText.email,
                        ),
                      ),
                      const SizedBox(height: TextSizes.spaceBtwInputfeilds),
                      TextFormField(
                         // controller: controller.password,
                          validator: (value) => TValidator.validateEmptyText('Password',value),
                          expands: false,
                          //obscureText: controller.hidepassword.value,
                          decoration:  InputDecoration(
                            labelText: TText.password,
                            prefixIcon: Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                              onPressed: (){},
                                //onPressed:()=> controller.hidepassword.value=!controller.hidepassword.value ,
                                //icon:  Icon(controller.hidepassword.value?Iconsax.eye_slash:Iconsax.eye)),
                              icon: const Icon(Iconsax.eye_slash)),
                          ),
                        ),

                      const SizedBox(height: TextSizes.spaceBtwInputfeilds / 2),
                      // Remember me and forgot password
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              //Obx(()=> Checkbox(value:controller.remeberMe.value, onChanged: (value)=>controller.remeberMe.value=!controller.remeberMe.value)),
                              const Text(TText.remember),
                            ],
                          ),
                          TextButton(onPressed: ()=>Get.to(()=>const ForgotPassword()), child: const Text(TText.forget)),
                        ],
                      ),
                      const SizedBox(height: TextSizes.spacebtwSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ()=>Get.to(()=> const Navigationmenu()),
                          //onPressed: () => controller.emailandPasswordSignIn(),
                          child: const Text(TText.signin),
                        ),
                      ),

                      const SizedBox(height: TextSizes.spacebtwSections),
                      const SizedBox(height: TextSizes.spaceBtwItems,),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Get.to(()=> const SignupScreen()),
                          child: const Text(TText.createAccount),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Flexible(child: Divider(color: dark?TColors.darkgrey:TColors.lightgrey,thickness: 0.5,indent: 60,endIndent: 5,)),
                  Text(TText.signinwith,style: Theme.of(context).textTheme.labelMedium,),
                  Flexible(child: Divider(color: dark?TColors.darkgrey:TColors.lightgrey,thickness: 0.5,indent: 5,endIndent: 60,)),
                ],
              ),
              const SizedBox(width: TextSizes.spaceBtwItems,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(decoration: BoxDecoration(border:Border.all(color:TColors.containerDark),borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {}
                        //onPressed: ()=> controller.googleSignIn()
                        ,icon:
                      const Image(
                        width: TextSizes.iconmd,
                        height: TextSizes.iconmd,
                        image: AssetImage(TImages.google),
                      )
                        ,)
                  ),
                  const SizedBox(width: TextSizes.spaceBtwItems,),
                  Container(decoration: BoxDecoration(border:Border.all(color:TColors.containerDark),borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: (){},icon:
                      const Image(
                        width: TextSizes.iconmd,
                        height: TextSizes.iconmd,
                        image: AssetImage(TImages.facebook),
                      )
                        ,)
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
