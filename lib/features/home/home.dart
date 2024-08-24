import 'package:admin_console/core/app_imports.dart';
import 'package:admin_console/core/utils/screen_utils.dart';
import 'package:admin_console/widgets/custombutton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum TransactionType { all, success, pending }

class _HomeScreenState extends State<HomeScreen> {
  // Initial state is showing all transactions
  TransactionType selectedType = TransactionType.all;

  // Dummy data for transactions
  final List<Map<String, String>> allTransactions = [
    {'type': 'Success', 'description': 'Transaction 1'},
    {'type': 'Pending', 'description': 'Transaction 2'},
    {'type': 'Success', 'description': 'Transaction 3'},
    {'type': 'Pending', 'description': 'Transaction 4'},
    {'type': 'Success', 'description': 'Transaction 5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: const Icon(Icons.menu),
        actions: [
          const Icon(
            Icons.settings,
            size: 20,
          ),
          CustomSpacers.width14,
          const Icon(
            Icons.notification_add,
            size: 20,
          ),
          CustomSpacers.width6,
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromARGB(255, 240, 240, 240),
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/header_image.png"),
              CustomSpacers.height14,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCard("All Earnings", Icons.wallet, "\$3,020", "30.6%",
                      Colors.blue, "assets/images/bluebar.png"),
                  _buildCard("Page Views", Icons.document_scanner, "290k+",
                      "30.6%", Colors.orange, "assets/images/orangebar.png"),
                  _buildCard("Total Tasks", Icons.calendar_month, "839", "new",
                      Colors.green, "assets/images/greenbar.png"),
                  _buildCard("Download", Icons.lock_clock, "2,067", "30.6%",
                      Colors.red, "assets/images/redbar.png"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CustomSpacers.height8,
                    _buildRepeatCustomerrate(),
                    // CustomSpacers.height8,
                    _buildProjectAblePro(),
                  ],
                ),
              ),
              CustomSpacers.height8,
              Row(
                children: [
                  _buildProjectOverview(),
                  _buildAble(),
                ],
              ),
              CustomSpacers.height8,
              Row(children: [
                _buildTransactions(),
                // CustomSpacers.height8,
                _buildTotalIncome(),
              ])
            ],
          ),
        ),
      ),
    );
  }

  _buildAble() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          width: 80.w,
          height: 180.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: ,
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetwee,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(213, 244, 244, 244),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Center(
                                child: Text(
                              "@",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            ))),
                      ),
                      CustomSpacers.width4,
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Able Pro",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),


                          Text("@ableprodevelop" , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w300 , color: Colors.black87),)
                        ],
                      ),
                      CustomSpacers.width24,
                      const Icon(Icons.more_vert)
                    ],
                  ),
                  CustomSpacers.height30,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    SizedBox(width: 40.w,
                    
                    child: Image.asset("assets/images/image.png"),) ,

                    const CircleAvatar(
                    backgroundColor: Colors.blue,
                      child: Center(child: Icon(Icons.add),),

                    )
                  ],)
                ]),
          )));

  _buildCard(String name, IconData icon, String price, String hike, Color col,
      String images) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 88.w,
        // height: 200.h,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 255, 255, 255)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                            child: Icon(
                              icon,
                              size: 28,
                              color: col,
                            ),
                          ),
                        ),
                        CustomSpacers.width4,
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
              CustomSpacers.height24,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(213, 244, 244, 244)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSpacers.width10,
                      SizedBox(
                          width: 30.w,
                          child: Image.asset(
                            images,
                          )),
                      // CustomSpacers.width32,
                      CustomSpacers.width10,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildProjectAblePro() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: 80.w,
          height: 470.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: ,
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Project - Able Pro",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                CustomSpacers.height30,
                const SizedBox(
                  child: Divider(
                    color: Color.fromARGB(104, 0, 0, 0),
                  ),
                ),
                CustomSpacers.height18,
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Release v1.2.0",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text("70%"),
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
                CustomSpacers.height29,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomButton(
                      col: Colors.blue, rad: 20, title: "Add Tasks"),
                )
              ],
            ),
          ),
        ),
      );

  _buildrowWidget(String t, Color c) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSpacers.width4,
            Icon(
              Icons.circle,
              color: c,
              size: 10,
            ),
            CustomSpacers.width6,
            Text(
              t,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            )
          ],
        ),
      );

  _buildRepeatCustomerrate() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: 280.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: ,
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            "Repeat Customer Rate",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.more_horiz),
                  ],
                ),
                CustomSpacers.height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("5.44%"),
                    CustomSpacers.width8,
                    Container(
                      height: 25.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Center(
                          child: Text(
                            "+2.6%",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomSpacers.height15,
                Image.asset("assets/images/customerrepeat.png")
              ],
            ),
          ),
        ),
      );

  _buildProjectOverview() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Container(
          width: 280.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: ,
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Project Overview",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  CustomSpacers.height38,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Tasks",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "34,686",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      // CustomSpacers.width10,
                      SizedBox(
                          width: 90.w,
                          child: Image.asset(
                            "assets/images/totaltasks.png",
                            fit: BoxFit.cover,
                          )),
                      CustomSpacers.width28,

                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pending Tasks",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "3,786",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      CustomSpacers.width10,
                      SizedBox(
                          width: 90.w,
                          child: Image.asset(
                            "assets/images/pendingtasks.png",
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                  CustomSpacers.height18,
                  CustomSpacers.height28,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.0),
                    child: CustomButton(
                        col: Colors.blue, rad: 20, title: "Add Project"),
                  ),
                  CustomSpacers.height28,
                ]),
          ),
        ),
      );

  _buildTransactions() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Container(
          width: 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: ,
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transactions",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Icon(Icons.more_vert),
                  ],
                ),
                CustomSpacers.height14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTransactionButton(
                      label: 'All Transactions',
                      type: TransactionType.all,
                    ),
                    CustomSpacers.width6,
                    _buildTransactionButton(
                      label: 'Success',
                      type: TransactionType.success,
                    ),
                    CustomSpacers.width6,
                    _buildTransactionButton(
                      label: 'Pending',
                      type: TransactionType.pending,
                    ),
                  ],
                ),
                CustomSpacers.height14,
                getTransactionList(),

                CustomSpacers.height20,
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "View All Transactions History",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                CustomSpacers.height20,
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "Create new Transactions",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
                // CustomButton(col: const Color.fromARGB(255, 241, 241, 241), rad: 20, title: "View All Transactions History")
              ],
            ),
          ),
        ),
      );

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
        padding: const EdgeInsets.all(8.0),
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
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.ac_unit_outlined,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CustomSpacers.width12,
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Apple Inc.",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "#ABLE-PRO-1OO232",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$210,000",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_outward_outlined,
                          color: Colors.green,
                          size: 18,
                        ),
                        Text("10.6%",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.green))
                      ],
                    )
                  ],
                ),
              ],
            ),
            CustomSpacers.height10,
            const SizedBox(
              child: Divider(),
            ),
            // CustomSpacers.height10,
          ],
        ),
      );

  _buildTotalIncome() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Container(
          height: 680.h,
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: ,
            border: Border.all(color: const Color.fromARGB(68, 0, 0, 0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Income",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.more_vert),
                    ],
                  ),
                  CustomSpacers.height18,
                  Center(
                    child: SizedBox(
                        height: 300.h,
                        child: Image.asset("assets/images/totalincome.png")),
                  ),
                  CustomSpacers.height10,
                  _buildTotalIncomeWidget(Colors.blue, "Income"),
                  CustomSpacers.height6,
                  _buildTotalIncomeWidget(Colors.orange, "Rent"),
                  CustomSpacers.height6,
                  _buildTotalIncomeWidget(Colors.green, "Download"),
                  CustomSpacers.height6,
                  _buildTotalIncomeWidget(Colors.grey, "Views"),
                ]),
          ),
        ),
      );

  _buildTotalIncomeWidget(Color c, String name) => Container(
        //  height: 50.h,
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
                    color: c,
                    size: 10,
                  ),
                  CustomSpacers.width4,
                  Text(
                    name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              CustomSpacers.height6,
              Row(
                children: [
                  const Text(
                    "\$23,876",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  CustomSpacers.width4,
                  const Text(
                    "+\$763,43",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
