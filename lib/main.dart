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
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
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
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
