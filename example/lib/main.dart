import 'package:flutter/material.dart';
import 'package:flutter_step_container/flutter_step_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Step-Container'),
      ),
      body: StepContainer(
        finishCallBack: (val) {
          print('back====$val');
        },
        finishView: Center(
          child: ListView(
            children: List<Widget>.generate(100, (index) => Text('Hi,I\'m Giff $index')),
            shrinkWrap: true,
          ),
        ),
        models: <StepModel>[
          StepModel(
              title: Text('Page one'),
              content: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  )
              ),
          ),
          StepModel(
              title: Text('Page two'),
              content: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.sports),
                    hintText: 'What do people call you before?',
                    labelText: 'I don\'t know',
                  )
              )
          ),
          StepModel(
              title: Text('Page three'),
              content: Center(
                child: Icon(Icons.accessibility_new_sharp,color: Colors.blue,size: 48.0,),
              )
          ),
          StepModel(
              title: Text('Page four'),
              content: Center(
                child: Icon(Icons.done,color: Colors.redAccent,size: 96.0,),
              )
          )
        ],
      ),
    );
  }
}
