import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List groups = [
    {
      'title': 'Pet Parents',
      'imageUrl':
          'https://images.unsplash.com/photo-1553322378-eb94e5966b0c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'subtitle': 'Find your perfect pet parent match',
    },
    {
      'title': 'Creatives',
      'imageUrl':
          'https://media.istockphoto.com/photos/cheerful-elderly-woman-freelancer-creative-designer-in-a-red-hat-fun-picture-id1291937104?k=20&m=1291937104&s=612x612&w=0&h=5bf0UeYdW1DMWlN7cbkPtdZeLpJPeCEvZRxIfmeuNDg=',
      'subtitle': 'Match Your Aesthetics'
    },
    {
      'title': 'Bing Watchers',
      'imageUrl':
          'https://media.istockphoto.com/photos/christmas-isnt-complete-without-a-fun-movie-marathon-picture-id1218800128?s=612x612',
      'subtitle': 'Match Your Aesthetics'
    },
    {
      'title': 'Music And Arts',
      'imageUrl':
          'https://media.istockphoto.com/photos/trendy-girl-singing-favorite-song-out-loud-in-phone-as-mic-wearing-picture-id1256944025?k=20&m=1256944025&s=612x612&w=0&h=TEpOhfTQsNOhAlyPxOvQXalaDf1q1DtT9IWvSP3J8_Y=',
      'subtitle': 'Match Your Aesthetics'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Verify(),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('For You',
                    style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                Text('Recommendations based on your interests',
                    style: GoogleFonts.aBeeZee(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 15),
            GridView.builder(
                itemCount: groups.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 8.0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 115,
                            left: 40,
                            bottom: 115,
                            right: 40,
                            child: Container(
                              child: Center(
                                child: Text(
                                  groups[index]['title'],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context).primaryColorDark,
                                    Theme.of(context).primaryColorLight,
                                  ],
                                  stops: [0.0, 0.9],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 39,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 4,
                                      color: Colors.black.withOpacity(0.5),
                                    )
                                  ]),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 18.0, left: 4.0, right: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    groups[index]['subtitle'],
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Interest',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(groups[index]['imageUrl']),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                })
          ])),
    ));
  }
}

class Verify extends StatelessWidget {
  const Verify({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Not yet Verified ?',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'get verified badge now',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        child: Center(
                            child: Text(
                          'Verify',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ]),
              ),
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.darken,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 3),
                      blurRadius: 10),
                ],
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                image: AssetImage('assets/images/man.jpg'), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 65,
          top: 15,
          child: SizedBox(
              height: 70,
              width: 70,
              child: Image.asset('assets/images/verified.png')),
        )
      ],
    );
  }
}
