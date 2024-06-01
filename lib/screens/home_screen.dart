import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:online_news_app/modal/categories_news_modal.dart';
import 'package:online_news_app/modal/news_channel_headlines_modal.dart';
import 'package:online_news_app/repository/news_repository.dart';
import 'package:online_news_app/screens/Categories_screen.dart';
import 'package:online_news_app/screens/news_details_scree.dart';
import 'package:online_news_app/view/news_view_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterdList {
  bbcNews,
  aryNews,
  independent,
  reuters,
  cnn,
  alJazeeera
} // for list of news

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModal newsViewModal = NewsViewModal();
  FilterdList? selectMenu; // selection of news //

  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            'assets/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Center(
          child: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          PopupMenuButton<FilterdList>(
              initialValue: selectMenu,
              icon: Icon(Icons.more_vert, color: Colors.black),
              onSelected: (FilterdList item) {
                if (FilterdList.bbcNews.name == item.name) {
                  name = 'bbc_news';
                }
                if (FilterdList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                if (FilterdList.alJazeeera.name == item.name) {
                  name = ' al-jazeera-english';
                }
                if (FilterdList.cnn.name == item.name) {
                  name = 'cnn';
                }

                setState(() {
                  selectMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterdList>>[
                    PopupMenuItem(
                        value: FilterdList.bbcNews, child: Text('BBC News')),
                    PopupMenuItem(
                        value: FilterdList.aryNews, child: Text('ARY News')),
                    PopupMenuItem(
                        value: FilterdList.alJazeeera,
                        child: Text('Al-Jazeera ')),
                    PopupMenuItem(value: FilterdList.cnn, child: Text('CNN'))
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<NewsChannelHeadlinesModal>(
                  future: newsViewModal.FetchNewsChannelHeadlinesApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          shrinkWrap: true,
                          // for check the lenght of articels
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString()); // convert in date and time formate
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => NewsDetailScreen(
                                              newsImage: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              newsTitle: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              newsDate: snapshot.data!
                                                  .articles![index].publishedAt
                                                  .toString(),
                                              author: snapshot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              content: snapshot.data!
                                                  .articles![index].content
                                                  .toString(),
                                              source: snapshot.data!
                                                  .articles![index].source!.name
                                                  .toString(),
                                            ))));
                              },
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.6,
                                      width: width * .9,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: height * .02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                            imageUrl: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(), // snapshot is use to fetch data
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                  child: spinkit2,
                                                ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                      Icons.error_outline,
                                                      color: Colors.red,
                                                    )),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: EdgeInsets.all(
                                              15), // distane from all edges
                                          height: height * .22,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                // for  showing title
                                                child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: width * 0.7,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // for showing source name
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),

                                                    // for showing date and time
                                                    Text(
                                                      format.format(dateTime),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ),

          //  for lsit of catagories
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<CategoriesNewsModal>(
                  future: newsViewModal.FetchCategoriesNewsApi('General'),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          shrinkWrap: true,
                          // for check the lenght of articels
                          // scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString()); // convert in date and time formate
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(), // snapshot is use to fetch data
                                        fit: BoxFit.cover,
                                        height: height * .18,
                                        width: width * .3,
                                        placeholder: (context, url) =>
                                            Container(
                                                child: Center(
                                              child: SpinKitCircle(
                                                color: Colors.blue,
                                                size: 50,
                                              ),
                                            )),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            )),
                                  ),
                                  Expanded(
                                      child: Container(
                                          height: height * .18,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Column(children: [
                                            Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )
                                          ])))
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitCircle(
  color: Colors.amber,
  size: 50,
);
