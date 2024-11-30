import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_first_app/providers/counter_provider.dart';
import 'package:provider_first_app/providers/theme_provider.dart';
import 'package:provider_first_app/theme/custom_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  RootApp({super.key});
  CustomTheme myThemes = CustomTheme();

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: myThemes.lightTheme,
      darkTheme: myThemes.darkTheme,
      themeMode: themeManager.mode,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.all(12),
            child: IconButton(
                onPressed: counterProvider.increment, icon: Icon(Icons.add)),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: IconButton(
                onPressed: counterProvider.decrement, icon: Icon(Icons.delete)),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: IconButton(
                onPressed: counterProvider.reset, icon: Icon(Icons.restore)),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    _key.currentState?.closeDrawer();
                  },
                  icon: Icon(Icons.delete_forever))
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: themeProvider.mode == ThemeMode.dark,
              onChanged: (newVal) {
                themeProvider.changeThemeMode(newVal);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("theme changed"),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
              },
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counterProvider.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterProvider.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
