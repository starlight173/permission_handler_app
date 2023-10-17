import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text("Pick Image From Gallery"),
            ),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: const Text("Pick Image From Camera"),
            ),
            ElevatedButton(
              onPressed: _multiPermissonRequest,
              child: const Text("Multi permission"),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _getImageFromGallery() async {
    try {
      PermissionStatus status = await Permission.storage.request();

      if (status == PermissionStatus.granted) {
        debugPrint("Permission granted");
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
      }

      if (status == PermissionStatus.denied) {
        debugPrint("Permission granted");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }

      if (status == PermissionStatus.limited) {
        debugPrint("Permission limited");
      }

      if (status == PermissionStatus.restricted) {
        debugPrint("Permission restricted");
      }

      if (status == PermissionStatus.permanentlyDenied) {
        debugPrint("Permission permanently denied");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }

      // Pick an image.
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _getImageFromCamera() async {
    try {
      PermissionStatus status = await Permission.camera.request();

      if (status == PermissionStatus.granted) {
        debugPrint("Permission granted");
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
      }

      if (status == PermissionStatus.denied) {
        debugPrint("Permission granted");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }

      if (status == PermissionStatus.limited) {
        debugPrint("Permission limited");
      }

      if (status == PermissionStatus.restricted) {
        debugPrint("Permission restricted");
      }

      if (status == PermissionStatus.permanentlyDenied) {
        debugPrint("Permission permanently denied");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }

      // Pick an image.
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _multiPermissonRequest() async {
    try {
      Map<Permission, PermissionStatus> multipleStatus =
          await [Permission.camera, Permission.storage].request();

      if (multipleStatus[Permission.camera] == PermissionStatus.granted) {
        debugPrint("Camera Permission granted");
      }

      if (multipleStatus[Permission.camera] == PermissionStatus.denied) {
        debugPrint("Permission granted");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }

      if (multipleStatus[Permission.camera] == PermissionStatus.limited) {
        debugPrint("Permission limited");
      }

      if (multipleStatus[Permission.camera] == PermissionStatus.restricted) {
        debugPrint("Permission restricted");
      }

      if (multipleStatus[Permission.camera] ==
          PermissionStatus.permanentlyDenied) {
        debugPrint("Permission permanently denied");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }

      if (multipleStatus[Permission.storage] == PermissionStatus.granted) {
        debugPrint("Permission granted");
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
      }

      if (multipleStatus[Permission.storage] == PermissionStatus.denied) {
        debugPrint("Permission granted");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }

      if (multipleStatus[Permission.storage] == PermissionStatus.limited) {
        debugPrint("Permission limited");
      }

      if (multipleStatus[Permission.storage] == PermissionStatus.restricted) {
        debugPrint("Permission restricted");
      }

      if (multipleStatus[Permission.storage] ==
          PermissionStatus.permanentlyDenied) {
        debugPrint("Permission permanently denied");
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      }
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        // ignore: use_build_context_synchronously
        showAlertDialog(context,
            title: "Permission Denied",
            description: "Please grant permission to access photos",
            okText: 'Open Settings',
            okPressed: () => openAppSettings());
      } else {
        print("Exception occurred");
      }
    }
  }
}

Widget adaptiveAction(
    {required BuildContext context,
    required VoidCallback onPressed,
    required Widget child}) {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return TextButton(onPressed: onPressed, child: child);
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return CupertinoDialogAction(onPressed: onPressed, child: child);
  }
}

void showAlertDialog(
  BuildContext context, {
  String title = '',
  String description = '',
  String okText = 'OK',
  String cancelText = 'Cancel',
  VoidCallback? okPressed,
  VoidCallback? cancelPressed,
}) {
  if (!context.mounted) return;

  showAdaptiveDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog.adaptive(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        adaptiveAction(
          context: context,
          onPressed: () {
            cancelPressed?.call();
            Navigator.pop(context, 'Cancel');
          },
          child: Text(cancelText),
        ),
        adaptiveAction(
          context: context,
          onPressed: () {
            Navigator.pop(context, 'OK');
            okPressed?.call();
          },
          child: Text(okText),
        ),
      ],
    ),
  );
}
