import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bidding extends StatefulWidget {
  const Bidding({super.key});

  @override
  State<Bidding> createState() => _BiddingState();
}

class _BiddingState extends State<Bidding> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Ongoing Bids',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index){

            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 110,
                          width: 215,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.visible,
                                  'Ancient Wheel egyptian Methedology',
                                  style:
                                  TextStyle(color: Color(0xFF333333), fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.visible,
                                  'Base price : ₹ 45,000 /-',
                                  style:
                                  TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w400),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.perm_identity_rounded,
                                    size: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      "GM Group of companies",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
