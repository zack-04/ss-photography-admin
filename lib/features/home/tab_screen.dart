import 'package:admin_console/core/app_imports.dart';
import 'package:admin_console/core/constants/c.dart';
import 'package:admin_console/my_drawer.dart';
import 'package:admin_console/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

enum TransactionType { all, success, pending }

class _TabScreenState extends State<TabScreen> {
  TransactionType selectedType = TransactionType.all;

  // Dummy data for transactions
  final List<Map<String, String>> allTransactions = [
    {'type': 'Success', 'description': 'Transaction 1'},
    {'type': 'Pending', 'description': 'Transaction 2'},
    {'type': 'Success', 'description': 'Transaction 3'},
    {'type': 'Pending', 'description': 'Transaction 4'},
    {'type': 'Success', 'description': 'Transaction 5'},
  ];
  List<dynamic> l = [
    {
      'title': "All Earnings",
      'icon': Icons.wallet,
      'price': "\$3,020",
      'hike': "30.6%",
      'color': Colors.blue,
      'image': "assets/images/bluebar.png"
    },
    {
      'title': "Page Views",
      'icon': Icons.document_scanner,
      'price': "290k+",
      'hike': "30.6%",
      'color': Colors.orange,
      'image': "assets/images/orangebar.png"
    },
    {
      'title': "Total Tasks",
      'icon': Icons.calendar_month,
      'price': "839",
      'hike': "new",
      'color': Colors.green,
      'image': "assets/images/greenbar.png"
    },
    {
      'title': "Download",
      'icon': Icons.lock_clock,
      'price': "2,067",
      'hike': "30.6%",
      'color': Colors.red,
      'image': "assets/images/redbar.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          SizedBox(
            width: c.w(context) * 0.02,
          ),
          const Icon(Icons.light_mode, color: Color.fromARGB(170, 0, 0, 0)),
          SizedBox(
            width: c.w(context) * 0.02,
          ),
          const Icon(Icons.settings, color: Color.fromARGB(170, 0, 0, 0)),
          SizedBox(
            width: c.w(context) * 0.02,
          ),
          const Icon(Icons.notifications_on,
              color: Color.fromARGB(170, 0, 0, 0)),
          SizedBox(
            width: c.w(context) * 0.02,
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Center(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      // drawer: const MyDrawer(),
      body: Row(
        children: [
          const SizedBox(
            child: VerticalDivider(),
          ),
          _buildRightPanel(),
        ],
      ),
    );
  }

  _buildRightPanel() => Expanded(
        child: Column(
          children: [
            // _buildHeader(),
            _buildBody(),
          ],
        ),
      );

  
  _buildBody() => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(c.w(context) * 0.01),
            child: SizedBox(
              width: c.w(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: c.w(context),
                    child: Image.asset("assets/images/header_image.png"),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    int crossAxisCount = 4;
                    double width = constraints.maxWidth;
                    if (width > 1200) {
                      crossAxisCount = 4;
                    } else if (width < 1000) {
                      crossAxisCount = 2;
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: l.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
            
                        childAspectRatio:
                            2 // Adjust as needed
                      ),
                      itemBuilder: (context, index) {
                        return _buildCard(
                          l[index]['title'],
                          l[index]['icon'],
                          l[index]['price'],
                          l[index]['hike'],
                          l[index]['color'],
                          l[index]['image'],
                        );
                      },
                    );
                  }),
                  SizedBox(
                    width: c.w(context) * 0.01,
                  ),
                  _buildRepeatCustomerrate(),
                  SizedBox(
                    width: c.w(context) * 0.01,
                  ),
                  _buildProjectAblePro(),
                  
                  _buildProjectOverview(),
                  // SizedBox(
                  //   height: c.w(context) * 0.01,
                  // ),
                  _buildAble(),
                  SizedBox(
                    height: c.w(context) * 0.01,
                  ),
                  _buildTransactions(),
                  // CustomSpacers.height8,
                  _buildTotalIncome()
                ],
              ),
            ),
          ),
        ),
      );

  _buildCard(String name, IconData icon, String price, String hike, Color col,
      String images) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: c.w(context) * 0.006, vertical: c.h(context) * 0.01),
      child: Container(
        // height: c.h(context) * 0.2,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 255, 255, 255)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: c.w(context) * 0.005, vertical: c.h(context) * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(213, 244, 244, 244),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            icon,
                            size: c.w(context) * 0.02,
                            color: col,
                          ),
                        ),
                      ),
                      SizedBox(width: c.w(context) * 0.01),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: c.h(context) * 0.02,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                   Icon(Icons.more_vert , size: c.w(context) * 0.03),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: c.w(context) * 0.002),
                child: AspectRatio(
                  aspectRatio: 4,
                  child: Container(
                    height: c.h(context) * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(213, 244, 244, 244)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 2,
                          child: SizedBox(
                            width: c.w(context) * 0.08,
                            child: Image.asset(
                              images,
                            ),
                          ),
                        ),
                        SizedBox(width: c.w(context) * 0.01),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              price,
                              style: TextStyle(
                                  fontSize: c.h(context) * 0.02,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_outward_outlined,
                                  color: col,
                                ),
                                Text(
                                  hike,
                                  style: TextStyle(
                                      color: col,
                                      fontSize: c.h(context) * 0.02,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildRepeatCustomerrate() => Padding(
    padding: EdgeInsets.symmetric(vertical: c.h(context) * 0.01),
    child: Container(
      // height: c.h(context) * 0.5,
      // width: c.w(context) * 0.58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: c.w(context) * 0.02,
            vertical: c.w(context) * 0.01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text(
                        "Repeat Customer Rate",
                        style: TextStyle(
                            fontSize: c.h(context) * 0.024,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
            SizedBox(
              height: c.h(context) * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("5.44%"),
                SizedBox(
                  width: c.w(context) * 0.01,
                ),
                Container(
                  height: 20,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "+2.6%",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: c.h(context) * 0.015,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: c.h(context) * 0.015),
            Image.asset("assets/images/customerrepeat.png")
          ],
        ),
      ),
    ),
  );

  _buildProjectAblePro() => Padding(
        padding: EdgeInsets.symmetric(vertical: c.h(context) * 0.01),
        child: Container(
          // width: c.w(context) * 0.2,
          // height: c.h(context) * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: c.w(context) * 0.01, vertical: c.h(context) * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: c.w(context) * 0.01),
                  child: Text(
                    "Project - Able Pro",
                    style: TextStyle(
                        fontSize: c.h(context) * 0.02,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: c.h(context) * 0.02,
                ),
                const SizedBox(
                  child: Divider(
                    color: Color.fromARGB(104, 0, 0, 0),
                  ),
                ),
                SizedBox(
                  height: c.h(context) * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: c.w(context) * 0.01,
                      vertical: c.h(context) * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Release v1.2.0",
                        style: TextStyle(
                          fontSize: c.h(context) * 0.02,
                        ),
                      ),
                      const Text("70%"),
                    ],
                  ),
                ),
                Slider(
                  inactiveColor: Colors.grey,
                  activeColor: Colors.blue,
                  value: 0.7,
                  onChanged: (v) {},
                ),
                _buildrowWidget("Horizontal Layout", Colors.orange),
                _buildrowWidget("Invoice Generator", Colors.orange),
                _buildrowWidget("Package Upgrades", Colors.orange),
                _buildrowWidget("Figma Auto Layout", Colors.green),
                SizedBox(height: c.h(context) * 0.025),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: c.h(context) * 0.01),
                  child: const CustomButton(
                      col: Colors.blue, rad: 20, title: "Add Tasks"),
                ),
              ],
            ),
          ),
        ),
      );

  _buildrowWidget(String t, Color col) => Padding(
        padding: EdgeInsets.all(c.h(context) * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: c.w(context) * 0.01),
            Icon(
              Icons.circle,
              color: col,
              size: 10,
            ),
            SizedBox(width: c.w(context) * 0.01),
            Text(
              t,
              style: TextStyle(
                  fontSize: c.h(context) * 0.02, fontWeight: FontWeight.w400),
            )
          ],
        ),
      );

  _buildProjectOverview() => Padding(
    padding: EdgeInsets.symmetric(vertical: c.w(context) * 0.01),
    child: Container(
      // width: c.w(context) * 0.58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: c.w(context) * 0.01,
            vertical: c.h(context) * 0.01),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Project Overview",
                    style: TextStyle(
                        fontSize: c.h(context) * 0.024,
                        fontWeight: FontWeight.w500),
                  ),
                  const Icon(Icons.more_horiz),
                ],
              ),
              SizedBox(
                height: c.h(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Tasks",
                        style: TextStyle(
                            fontSize: c.h(context) * 0.024,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "34,686",
                        style: TextStyle(
                            fontSize: c.h(context) * 0.02,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    width: c.w(context) * 0.001,
                  ),
                  SizedBox(
                      width: c.w(context) * 0.15,
                      child: Image.asset(
                        "assets/images/totaltasks.png",
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    width: c.w(context) * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending Tasks",
                        style: TextStyle(
                            fontSize: c.h(context) * 0.024,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "3,786",
                        style: TextStyle(
                            fontSize: c.h(context) * 0.02,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    width: c.w(context) * 0.001,
                  ),
                  SizedBox(
                      width: c.w(context) * 0.15,
                      child: Image.asset(
                        "assets/images/pendingtasks.png",
                        fit: BoxFit.cover,
                      )),
                ],
              ),
              SizedBox(
                height: c.h(context) * 0.04,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: c.w(context) * 0.1),
                child: const CustomButton(
                    col: Colors.blue, rad: 20, title: "Add Project"),
              ),
              SizedBox(
                height: c.h(context) * 0.04,
              ),
            ]),
      ),
    ),
  );

  _buildAble() => Padding(
      padding: EdgeInsets.symmetric(vertical: c.h(context) * 0.002),
      child: Container(
          // width: c.w(context) * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: c.w(context) * 0.01, vertical: c.h(context) * 0.01),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(213, 244, 244, 244),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Center(
                                      child: Text(
                                    "@",
                                    style: TextStyle(
                                        fontSize: c.h(context) * 0.02,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                                  ))),
                            ),
                            SizedBox(
                              width: c.w(context) * 0.007,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Able Pro",
                                    style: TextStyle(
                                        fontSize: c.h(context) * 0.024,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  "@ableprodevelop",
                                  style: TextStyle(
                                      fontSize: c.h(context) * 0.016,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black87),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_vert)
                    ],
                  ),
                  SizedBox(
                    height: c.h(context) * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: c.w(context) * 0.16,
                        child: Image.asset("assets/images/image.png"),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Center(
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  )
                ]),
          )));

  _buildTransactions() => Container(
    // width: c.w(context) * 0.39,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
    ),
    child: Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: TextStyle(
                    fontSize: c.h(context) * 0.024,
                    fontWeight: FontWeight.w500),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          SizedBox(
            height: c.h(context) * 0.03,
          ),
    
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildTransactionButton(
                label: 'All Transactions',
                type: TransactionType.all,
              ),
              SizedBox(
                width: c.w(context) * 0.01,
              ),
              // CustomSpacers.width6,
              _buildTransactionButton(
                label: 'Success',
                type: TransactionType.success,
              ),
              SizedBox(
                width: c.w(context) * 0.01,
              ),
    
              _buildTransactionButton(
                label: 'Pending',
                type: TransactionType.pending,
              ),
            ],
          ),
          SizedBox(
            height: c.h(context) * 0.03,
          ),
    
          getTransactionList(),
          SizedBox(
            height: c.h(context) * 0.03,
          ),
    
          MouseRegion(
            onEnter: (_) => _onHover1(true),
            onExit: (_) => _onHover1(false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: c.h(context) * 0.05,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
                color:
                    isHovered1 ? Colors.grey[300] : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  "View All Transactions History",
                  style: TextStyle(fontSize: c.h(context) * 0.02),
                ),
              ),
            ),
          ),
          SizedBox(height: c.h(context) * 0.01),
          MouseRegion(
            onEnter: (_) => _onHover2(true),
            onExit: (_) => _onHover2(false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: c.h(context) * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isHovered2 ? Colors.blue[800] : Colors.blue,
              ),
              child: Center(
                child: Text(
                  "Create new Transactions",
                  style: TextStyle(
                    fontSize: c.h(context) * 0.02,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // CustomButton(col: const Color.fromARGB(255, 241, 241, 241), rad: 20, title: "View All Transactions History")
        ],
      ),
    ),
  );

  bool isHovered1 = false;
  bool isHovered2 = false;

  void _onHover1(bool isHovering) {
    setState(() {
      isHovered1 = isHovering;
    });
  }

  void _onHover2(bool isHovering) {
    setState(() {
      isHovered2 = isHovering;
    });
  }

  Widget _buildTransactionButton(
      {required String label, required TransactionType type}) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedType = type;
        });
      },
      style: TextButton.styleFrom(
        foregroundColor: selectedType == type ? Colors.white : Colors.black,
        backgroundColor: selectedType == type ? Colors.blue : Colors.grey[200],
      ),
      child: Text(label),
    );
  }

  Widget getTransactionList() {
    List<Map<String, String>> filteredTransactions;
    // switch (selectedType) {
    //   case TransactionType.success:
    //     filteredTransactions = allTransactions
    //         .where((transaction) => transaction['type'] == 'Success')
    //         .toList();
    //     break;
    //   case TransactionType.pending:
    //     filteredTransactions = allTransactions
    //         .where((transaction) => transaction['type'] == 'Pending')
    //         .toList();
    //     break;
    //   case TransactionType.all:
    //   default:
    //     filteredTransactions = allTransactions;
    // }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return buildTransactionColumn();
      },
    );
  }

  buildTransactionColumn() => Padding(
        padding: EdgeInsets.all(c.h(context) * 0.01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(213, 244, 244, 244),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(c.h(context) * 0.007),
                        child: const Icon(
                          Icons.ac_unit_outlined,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: c.w(context) * 0.015,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Apple Inc.",
                          style: TextStyle(
                              fontSize: c.h(context) * 0.019,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "#ABLE-PRO-1OO232",
                          style: TextStyle(
                              fontSize: c.h(context) * 0.017,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$210,000",
                      style: TextStyle(
                          fontSize: c.h(context) * 0.019,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_outward_outlined,
                          color: Colors.green,
                          size: 18,
                        ),
                        Text("10.6%",
                            style: TextStyle(
                                fontSize: c.h(context) * 0.017,
                                fontWeight: FontWeight.w300,
                                color: Colors.green))
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: c.h(context) * 0.01,
            ),
            const SizedBox(
              child: Divider(),
            ),
          ],
        ),
      );

  _buildTotalIncome() => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: c.w(context) * 0.002, vertical: c.h(context) * 0.014),
        child: Container(
          // height: c.h(context) * 0.89,
          // width: c.w(context) * 0.37,
          // height: 680.h,
          // width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: ,
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: c.w(context) * 0.014,
                vertical: c.h(context) * 0.01),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Income",
                        style: TextStyle(
                            fontSize: c.h(context) * 0.024,
                            fontWeight: FontWeight.w500),
                      ),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                  SizedBox(
                    height: c.h(context) * 0.02,
                  ),
                  SizedBox(
                    height: c.h(context) * 0.011,
                  ),
                  Center(
                    child: SizedBox(
                        height: c.h(context) * 0.51,
                        child: Image.asset("assets/images/totalincome.png")),
                  ),
                  SizedBox(
                    height: c.h(context) * 0.015,
                  ),
                  SizedBox(
                    height: c.h(context) * 0.011,
                  ),
                  Row(
                    children: [
                      _buildTotalIncomeWidget(Colors.blue, "Income"),
                      SizedBox(
                        height: c.h(context) * 0.011,
                      ),
                      _buildTotalIncomeWidget(Colors.orange, "Rent"),
                    ],
                  ),
                  SizedBox(
                    height: c.h(context) * 0.011,
                  ),
                  Row(
                    children: [
                      _buildTotalIncomeWidget(Colors.green, "Download"),
                      SizedBox(
                        height: c.h(context) * 0.011,
                      ),
                      _buildTotalIncomeWidget(Colors.grey, "Views"),
                    ],
                  ),
                  SizedBox(
                    height: c.h(context) * 0.011,
                  ),
                  SizedBox(
                    height: c.h(context) * 0.011,
                  ),
                  SizedBox(
                    height: c.h(context) * 0.011,
                  ),
                  SizedBox(
                    height: c.h(context) * 0.011,
                  ),
                ]),
          ),
        ),
      );

  _buildTotalIncomeWidget(Color col, String name) => Padding(
        padding: EdgeInsets.all(c.h(context) * 0.004),
        child: Container(
          width: c.w(context) * 0.46,
          height: c.h(context) * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(213, 244, 244, 244)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: col,
                      size: 10,
                    ),
                    SizedBox(
                      width: c.w(context) * 0.01,
                    ),

                    // CustomSpacers.width4,
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: c.h(context) * 0.02,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(
                  height: c.h(context) * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      "\$23,876",
                      style: TextStyle(
                          fontSize: c.h(context) * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: c.w(context) * 0.01,
                    ),

                    // CustomSpacers.width4,
                    Text(
                      "+\$763,43",
                      style: TextStyle(
                          fontSize: c.h(context) * 0.017,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
