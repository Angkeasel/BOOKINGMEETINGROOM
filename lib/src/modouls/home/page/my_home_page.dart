import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color(0xffFFC492),
        title: Image.asset(
          'assets/image/png/KOFI LOGO-01 1.png',
          height: 100,
        ),
        elevation: 0,
      ),
      body: const Center(child: Text('test')),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "Abhishek Mishra",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("abhishekm977@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' My Course '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Go Premium '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Saved Videos '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ), //Drawer
    );
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const Text(
    //         "Kofi Room Reservation",
    //         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
    //       ),
    //       const SizedBox(
    //         height: 50,
    //       ),
    //       TextFormField(
    //         decoration: InputDecoration(
    //             label: const Text("password"),
    //             enabledBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             suffixIcon: IconButton(
    //                 onPressed: () {},
    //                 icon: const Icon(Icons.visibility_off_sharp))),
    //       ),
    //       const SizedBox(
    //         height: 10,
    //       ),
    //       GestureDetector(
    //         onTap: () {
    //           // Navigator.push(context, MaterialPageRoute(builder: (context){
    //           //   return const ListingRoom();

    //           // }));
    //           //GoRouter.of(context).go('/rooms');
    //           // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           //   return const TestingScreen();
    //           // }));
    //         },
    //         child: Container(
    //           height: 50,
    //           padding: const EdgeInsets.all(10),
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(5),
    //               color: Colors.green),
    //           child: const Center(
    //               child: Text(
    //             "Go",
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w600),
    //           )),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // )
  }
}
