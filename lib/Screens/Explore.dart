import 'package:flutter/material.dart';
class Explore extends StatelessWidget {
  final dynamic universityData;

  Explore({required this.universityData});

  @override
  Widget build(BuildContext context) {
    print(universityData['name']);
    return Scaffold(
      appBar: AppBar(
        title:const Align (
            child: Text('University Details'),
            alignment: Alignment.centerLeft
        ),
        backgroundColor: Colors.blueAccent,
      ),
        body: Padding(
          padding:EdgeInsets.all(16.0),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Color(0xFF57B3FC),
                        borderRadius: BorderRadius.all( Radius.circular(30))
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        universityData['name'],
                        style:const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),

                    ),
                  )
                  ,Container(
                    width: 500,
                    height: 400,
                    padding: new EdgeInsets.all(10.0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xFF57B3FC),
                        elevation: 10,
                        child: Center(
                          child: Column(
                            children: [
                              ListTile(
                                title:const Text(
                                  'University Name :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle: Text(universityData['name']??'Sorry, No info in database'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child:const Text(
                                              "State :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),),
                                          ),
                                          Container(
                                            child: Text(universityData['state-province']??'Sorry, No info in database'),
                                          )
                                        ],
                                      )
                                  ),
                                  Container(
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child:const Text("Country :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),),
                                        ),
                                        Container(
                                          child: Text(universityData['country']??'Sorry, No info in database'),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              ListTile(
                                title:const Text(
                                  'Domains :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                                subtitle: Text(universityData['domains'][0]??'Sorry, No info in database'),
                              ),
                              ListTile(
                                title:const Text(
                                  'Alpha two code :', style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                                subtitle: Text(universityData['alpha_two_code']??'Sorry, No info in database'),
                              ),
                              ListTile(
                                title:const Text(
                                  'Website :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle: Text(universityData['web_pages'][0]??'Sorry, No info in database'),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              )
          ),
        )

    );
  }
}
