import 'package:flutter/material.dart';

class TodoApps extends StatefulWidget {
  const TodoApps({super.key});

  @override
  State<TodoApps> createState() => _TodoAppsState();
}

class _TodoAppsState extends State<TodoApps> {
  List<Map<String, dynamic>> todolist = [];
  var searchController = TextEditingController();
  var additemController = TextEditingController();
  var descController = TextEditingController();
  var typeeController = TextEditingController();
  var tagController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(child: Icon(Icons.man)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'All ToDos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return getTodoItemList(
                    title: todolist[index]['title'],
                    isChecked: todolist[index]['isChecked'],
                    index: index,
                    desc: todolist[index]['desc'],
                    type: todolist[index]['Type'],
                    tag: todolist[index]['Tag'],
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.transparent),
                itemCount: todolist.length,
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 20,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 25,
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: additemController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add a new todo item',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            Divider(),
                            TextField(
                              controller: descController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Desc',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: typeeController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type',
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: tagController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Tag',
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),
                  Card(
                    elevation: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.indigoAccent,
                      ),
                      child: IconButton(
                        onPressed: () {
                          String value = additemController
                              .text; //ES LINE KA UES TEXT ADD KARNE KLY HUA HAI
                          String dss = descController.text;
                          String typpe = typeeController.text;
                          String alltags = tagController.text;

                          Map<String, dynamic> map = {
                            "title": value, // SABKA MAP BANAYE HAI QKI LIST KO MAP CHAIYE
                            "isChecked": false,
                            'desc': dss,
                            'Type': typpe,
                            'Tag': alltags,
                          };
                          todolist.insert(0, map);
                          print(todolist.toString());
                          additemController
                              .clear(); // ES LINE KA USE JAHA SE HUM CUMMENT KARTE HAI USKO REMOVE KARNE KLY KIYA GAYA HAI
                          descController.clear();
                          typeeController.clear();
                          tagController.clear();

                          setState(() {});
                        },
                        icon: Icon(Icons.add, size: 50, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card getTodoItemList({
    required String title,
    required bool isChecked,
    required int index,
    required String desc,
    required String type,
    required String tag,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(18),
        width: double.maxFinite,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          spacing: 10,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                /// update data jab humlog check ko select karte hai to jitna hai o pura value leta ha
                todolist[index] = {
                  "title": title, //
                  "isChecked": value, //
                  'desc': desc, //
                  'Type': type, //
                  'Tag': tag,
                };
                setState(() {});
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    desc,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        type,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          decoration: isChecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        tag,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          decoration: isChecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                print(
                  '$title',
                ); // ES LINE KA USE TITLE PRINT KARNE KLY KIYA HAI
                todolist.removeAt(
                  index,
                ); // YE LINE PURE INDEX KO DELE KARNE KLY HAI
                setState(() {}); // YE LAGA NE YALUUW UPDATE HOTA HAI
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.red,
                ),
                child: Icon(Icons.delete, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
