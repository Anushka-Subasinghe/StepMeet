import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField reusableTextField(String text,IconData icon,bool isPasswordType,
    TextEditingController controller){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Color(0xff414644),
    style: TextStyle(color:Color(0xff181717).withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Color(0xff36423f),),
      labelText: text,
      labelStyle: TextStyle(color:Color(0xff1e413a).withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Color(0xff92c5b6).withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width:0,style:BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        :TextInputType.emailAddress,
  );
}

Container signInSignUpButton(BuildContext context,bool isLogin, Function onTap){
  return Container(width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0,10,0,20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Text(
          isLogin ? 'Log In':'Sign Up',
          style: const TextStyle(
              color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 16)
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Color(0xffade0d2);
        }),
        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
      ),
    ),
  );
}
