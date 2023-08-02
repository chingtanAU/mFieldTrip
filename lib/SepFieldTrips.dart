import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mfieldtrip/utils/app_layout.dart';

class SepFieldTrips extends StatelessWidget {
  
  final DocumentSnapshot documentSnapshot;
  const SepFieldTrips({Key? key, required this.documentSnapshot}) : super(key: key);
  _getApplicablePeriod(List visitingPeriod) {
    String period;
    int fallCount=0;
    int springCount=0;
    int summerCount=0;
    int  winterCount=0;
    int l=visitingPeriod.length;
    for(int i=0;i<visitingPeriod.length;i++){
    if((l==2 && visitingPeriod[i]=='Spring' && visitingPeriod[i+1]=='Summer')|| (l==2 && visitingPeriod[i]=='Summer' && visitingPeriod[i+1]=='Spring')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/spring_summer.png"), fit: BoxFit.fill,);
    }
    else if((l==2 && visitingPeriod[i]=='Fall' && visitingPeriod[i+1]=='Winter')|| (l==2 && visitingPeriod[i]=='Winter' && visitingPeriod[i+1]=='Fall')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/winter_fall.png"), fit: BoxFit.fill,);
    }
    else if((l==2 && visitingPeriod[i]=='Spring' && visitingPeriod[i+1]=='Fall')|| (l==2 && visitingPeriod[i]=='Fall' && visitingPeriod[i+1]=='Spring')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/spring_fall.png"),fit: BoxFit.fill,);
    }
    else if((l==2 && visitingPeriod[i]=='Spring' && visitingPeriod[i+1]=='Winter')|| (l==2 && visitingPeriod[i]=='Winter' && visitingPeriod[i+1]=='Spring')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/spring_winter.png"), fit: BoxFit.fill,);
    }
    else if((l==2 && visitingPeriod[i]=='Fall' && visitingPeriod[i+1]=='Summer')|| (l==2 && visitingPeriod[i]=='Summer' && visitingPeriod[i+1]=='Fall')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/summer_fall.png"), fit: BoxFit.fill,);
    }
    else if((l==2 && visitingPeriod[i]=='Winter' && visitingPeriod[i+1]=='Summer')|| (l==2 && visitingPeriod[i]=='Summer' && visitingPeriod[i+1]=='Winter')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/summer_winter.png"),  fit: BoxFit.fill,);
    }
    else if((l==1 && visitingPeriod[i]=='Spring')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/spring.png"), fit: BoxFit.fill,);
    }
    else if((l==1 && visitingPeriod[i]=='Summer')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/summer.png"),  fit: BoxFit.fill,);
    }
    else if((l==1 && visitingPeriod[i]=='Winter')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/winter.png"), fit: BoxFit.fill,);
    }
    else if((l==1 && visitingPeriod[i]=='Fall')){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/fall.png"),  fit: BoxFit.fill,);
    }
    else if((l==3 && visitingPeriod[i]!='Fall')){
      fallCount++;
    }
    else if((l==3 && visitingPeriod[i]!='Winter')){
      winterCount++;
    }
    else if((l==3 && visitingPeriod[i]!='Summer')){
      summerCount++;
    }
    else if((l==3 && visitingPeriod[i]!='Spring')){
      springCount++;
    }
    else{
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/all_year.png"),  fit: BoxFit.fill,);
    }
    }
    if(springCount==3){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/no_spring.png"),  fit: BoxFit.fill,);
    }
    if(summerCount==3){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/no_summer.png"), fit: BoxFit.fill,);
    }
    if(fallCount==3){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/no_fall.png"),  fit: BoxFit.fill,);
    }
    if(winterCount==3){
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/no_winter.png"),  fit: BoxFit.fill,);
    }
    else{
      return const Image(image: AssetImage("images/mfieldtrip_icons_images/all_year.png"),  fit: BoxFit.fill,);

    }
  }
    _getApplicableDuration(String duration) {
    switch (duration) {
      case "one day or less":
        return const Image(image: AssetImage('images/mfieldtrip_icons_images/duration_one.png'), fit: BoxFit.fill,);
      case "two to four days":
        return const Image(image: AssetImage('images/mfieldtrip_icons_images/duration_two.png'),  fit: BoxFit.fill,);
      default:
        return const Image(image: AssetImage('images/mfieldtrip_icons_images/duration_four.png'), fit: BoxFit.fill,);
    }
  }

_getImages(List images){
  return CarouselSlider.builder(
    options: CarouselOptions(height: 400),
    itemCount: images.length,
    itemBuilder: (context,index,realIndex){
      final image=images[index];
      return buildImages(image,index);
    });
}

    Widget buildImages(String image,int index)=>Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(image,fit: BoxFit.cover,),
    );

  @override
  Widget build(BuildContext context) {
      final size=AppLayout.getSize(context);
    return Scaffold(
     
      backgroundColor: Colors.lime[100],
      appBar:
      AppBar(
        toolbarHeight: 150,
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          title:
          ListTile(
            title:
            Text(documentSnapshot['title'], style: const TextStyle(color:Colors.white, fontSize: 25)),
            subtitle:
            Text(documentSnapshot['trip offered by'], style: const TextStyle(color:Colors.white)),
          )
      ),

      body:Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(documentSnapshot['description'],),
                    ],
                    ),
                  ),
                ),
                ),
                documentSnapshot['need author display']? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Author", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(documentSnapshot['author'],),
                        ],
                      ),
                    ),
                  ),
                ): const Gap(3),
                Card(
                 
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: _getImages(documentSnapshot['images']),
                      // Image(image: NetworkImage(documentSnapshot['images'][0]), fit: BoxFit.fill,),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         SizedBox(width: size.width*0.14, child: _getApplicableDuration(documentSnapshot['duration']),),
                          SizedBox(width: size.width*0.14, child: _getApplicablePeriod(documentSnapshot['visiting period']),),
                          SizedBox(
                            width: size.width*0.14,
                            child: documentSnapshot['is access limited']==true ?  const Image(image: AssetImage('images/mfieldtrip_icons_images/limited_access.png'), fit: BoxFit.fill,) : const Image(image: AssetImage('images/mfieldtrip_icons_images/limited_access.png'), colorBlendMode: BlendMode.darken,  fit: BoxFit.fill,)),
                           SizedBox(
                            width: size.width*0.14,
                            child:documentSnapshot['park or protected area']==true ? const Image(image: AssetImage('images/mfieldtrip_icons_images/park.png'), fit: BoxFit.fill,) : const Image(image: AssetImage('images/mfieldtrip_icons_images/park.png'), colorBlendMode: BlendMode.darken,  fit: BoxFit.fill,),),
                           SizedBox(
                            width: size.width*0.14,
                            child:documentSnapshot['any fees']==true ?  const Image(image: AssetImage('images/mfieldtrip_icons_images/fees.png'), fit: BoxFit.fill,) : const Image(image: AssetImage('images/mfieldtrip_icons_images/fees.png'), colorBlendMode: BlendMode.darken,  fit: BoxFit.fill,),),
                          SizedBox(
                           width: size.width*0.14,
                            child: Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Image(image: AssetImage('images/mfieldtrip_icons_images/distance.png'), fit: BoxFit.fill,),),
        Container(
            alignment: Alignment.center,
            child: Text(
              documentSnapshot['distance']+' KM',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),],),
                          ),
                      ],
                      ),
                  ),
                ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Level", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(documentSnapshot['level'],),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(documentSnapshot['category'],),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Duration", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(documentSnapshot['duration'],),
                        ],
                      ),
                    ),
                  ),
                ),

    ],
            ),
          ),
        ),
      ),
    );
  }
}
