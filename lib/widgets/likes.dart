import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiki/pages/tabs/likedDetailsPage.dart';

class Likes extends StatelessWidget {
  const Likes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Upgrade to Premium to see the full list of everyone that liked you.',
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('likeduser')
                  .where('likedUserEmail',
                      isEqualTo: FirebaseAuth.instance.currentUser!.email)
                  .where('matched', isEqualTo: false)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    'No one liked you recently',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ));
                }
                return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  addAutomaticKeepAlives: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 7 / 10,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => LikedDetailsPage(
                                        matched: snapshot.data!.docs[index]
                                            ['matched'],
                                        docid: snapshot.data!.docs[index].id,
                                        liedUserImageUrls: snapshot
                                            .data!.docs[index]['imageUrl'],
                                        likedJob: snapshot.data!.docs[index]
                                            ['address'],
                                        likedUserName: snapshot
                                            .data!.docs[index]['username'],
                                        likedUserage: snapshot.data!.docs[index]
                                            ['age'],
                                        likedUserinterests: snapshot
                                            .data!.docs[index]['interest'],
                                      )));
                        },
                        child: Container(
                            height: 180,
                            width: 100,
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['username'],
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data!.docs[index]['age'],
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Expires in: ' '1 day',
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshot.data!.docs[index]
                                      ['imageUrl'][1])),
                              borderRadius: BorderRadius.circular(3),
                            )),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
