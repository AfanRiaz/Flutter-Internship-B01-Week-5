import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_basics_app/counter_provider.dart';

void main(){
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_)=>CounterProvider(),
      child: Builder(builder: (BuildContext context){
        final themeChanger=context.watch<CounterProvider>().themeMode;
        return MaterialApp(
          themeMode: Provider.of<CounterProvider>(context).themeMode,
          theme: ThemeData(
            primarySwatch: Colors.blue
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      })

    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final countProvider=context.read<CounterProvider>();
    final themeProvider=context.watch<CounterProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Practice",),
        actions: [
          IconButton(onPressed: (){
            if(themeProvider.themeMode==ThemeMode.light){
              themeProvider.toggleTheme(ThemeMode.dark);
            }
            else if(themeProvider.themeMode==ThemeMode.dark){
              themeProvider.toggleTheme(ThemeMode.light);
            }
          }, icon: themeProvider.themeMode==ThemeMode.light?
          Icon(Icons.light_mode):Icon(Icons.dark_mode))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(builder: (context,value,child){
              return Text(value.count.toString(),style: TextStyle(fontSize: 50),);
            })

          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(onPressed: (){
              countProvider.decrement();
            },
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(onPressed: (){
              countProvider.increment();
            },
            child: Icon(Icons.add),
            ),
          ],
        ),
      ),

    );
  }
}


