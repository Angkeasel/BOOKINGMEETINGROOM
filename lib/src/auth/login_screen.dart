import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFC492),
       title: Image.asset('assets/image/png/KOFI LOGO-01 1.png', height: 100,),
       elevation: 0,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Text("Kofi Room Reservation", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
               const SizedBox(height: 10,),
              TextFormField(
                decoration:  InputDecoration(
                 label: const Text("password"),
                 enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                 focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                 suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.visibility_off_sharp))
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green
                ),
                child: const Center(child: Text("Go", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),)),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}