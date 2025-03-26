import 'package:flutter/material.dart';

class ShowEventDetailsWidget extends StatelessWidget {
  const ShowEventDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        width: 402,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(19, 19, 19, 1),
            borderRadius: BorderRadius.circular(10)),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      size: 20,
                    ),
                    Icon(
                      Icons.copy,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      size: 15,
                    ),
                    Icon(
                      Icons.close,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      size: 20,
                    ),
                  ],
                )
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Container(
                  height:48 ,
                  width: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: const Color.fromRGBO(87, 148, 221, 1)
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meeting with Alex',
                      style: TextStyle(
                          color:  Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),),
                    Text('Thursday 3, 2025',
                      style: TextStyle(
                          color:  Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),)
                  ],
                )
              ],
            ),
            const Row(
              spacing: 5,
              children: [
                Icon(Icons.location_on_outlined,
                  size: 17,
                  color: Color.fromRGBO(145, 145, 145, 1),),
                Text('Location: ',
                  style: TextStyle(
                    color: Color.fromRGBO(145, 145, 145, 1),
                  ),),
                Text('House XXL',
                  style: TextStyle(
                    color: Color.fromRGBO(255,255,255, 1),
                  ),)
              ],
            ),
            const Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.note_alt_outlined,
                  size: 17,
                  color: Color.fromRGBO(145, 145, 145, 1),),
                Text('Notes:  ',
                  style: TextStyle(
                    color: Color.fromRGBO(145, 145, 145, 1),
                  ),),
                Expanded(
                  child: Text('Lorem Ipsum, lorem ipsum dolor sit ametorem Ipsum, lorem ipsum dolor sit amet',
                    style: TextStyle(
                      color: Color.fromRGBO(255,255,255, 1),
                    ),
                    textAlign: TextAlign.left,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
