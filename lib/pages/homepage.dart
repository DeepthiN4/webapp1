import 'package:flutter/material.dart';
import 'package:webapp/Helper functions/helper_functions.dart';
import 'package:webapp/services/database.dart';
import 'package:webapp/widget/widget.dart';
class Home extends StatefulWidget {
  String username;
  final String userEmail;
  Home({required this.username, required this.userEmail});

  @override
  _HomeState createState() => _HomeState();
}

String uId = "Sx6ctwSww7WqK89ckWDOnFKwPJW2";

class _HomeState extends State<Home> {

  Stream? taskStream;

  DatabaseServices databaseServices = new DatabaseServices();

  String date= "";
  TextEditingController taskEdittingControler = new TextEditingController();

  @override
  void initState() {

    var now = DateTime.now();
    date = "${HelperFunctions.getWeek(now.weekday)} ${HelperFunctions.getYear(now.month)} ${now.day}";

    databaseServices.getTasks(uId).then((val){

      taskStream = val;
      setState(() {});

    });

    super.initState();
  }

  Widget taskList(){

    return StreamBuilder(
      stream: taskStream,
      builder: (context, snapshot){
        return snapshot.hasData ?
        ListView.builder(
          padding: EdgeInsets.only(top: 16),
          itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return TaskTile(
                snapshot.data.documents[index].data["isCompleted"],
                snapshot.data.documents[index].data["task"],
                snapshot.data.documents[index].documentID,
              );
            }) : Container();
      },
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: Widgets().mainAppar(),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 32),
            width: 600,
            child: Column(
              children: [
              Text("My Notes", style: TextStyle(
                fontSize: 18,
              ),),
              Text("$date"),
                Row(
                  children: [
                  Expanded(
                    child: TextField(
                      controller: taskEdittingControler,
                      decoration: InputDecoration(
                        hintText: "Add Note"
                      ),
                      onChanged: (val){
                       // taskEdittingControler.text = val;
                        setState(() {

                        });
                      },
                    ),
                  ),
                  SizedBox(width: 6,),
                  taskEdittingControler.text.isNotEmpty ?
                  GestureDetector(
                    onTap: (){

                      Map<String, dynamic> taskMap = {
                        "task" : taskEdittingControler.text,
                        "isCompleted" : false
                      };

                      databaseServices.createTask(uId,taskMap);
                      taskEdittingControler.text = "";
                    },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xffff59464),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          
                          child: Text("ADD",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                          ))) : Container()
                
                ],),

                taskList()
            ],),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String documentId;
  TaskTile(this.isCompleted, this.task, this.documentId);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: (){

              Map<String,dynamic> taskMap = {
                "isCompleted" : !widget.isCompleted
              };

              DatabaseServices().updateTask(uId, taskMap, widget.documentId);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 1),
                borderRadius: BorderRadius.circular(30)
              ),
              child:
              widget.isCompleted ?
              Icon(Icons.check, color: Colors.green,) : Container(),
            ),
          ),

          SizedBox(width: 8,),
          Text(
            widget.task,
            style: TextStyle(
              color: widget.isCompleted ? Colors.black87 :
                  Colors.black87.withOpacity(0.7) ,
              fontSize: 17,
              decoration: widget.isCompleted ?
                  TextDecoration.lineThrough :
                  TextDecoration.none
            ),
          ),

          Spacer(),

          GestureDetector(
            onTap: (){
              DatabaseServices().deleteTask(uId, widget.documentId);
            },
            child: Icon(
              Icons.close, size: 13, color: Colors.black87.withOpacity(0.7)
            ),
          )
        ],
      ),
    );
  }
}