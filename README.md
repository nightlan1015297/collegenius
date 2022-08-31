# Collegenius
Collegenius is an application that develop to help student in NCU (National Centeral University 國立中央大學) access school affair or learning related system in school.
Application combined Course Planning System, Eeclass system. Provide an easy way to access course schedual and learning material for students.
We are planning to add Portal system, bus information to the application, stay tuned! and hope you can join us to help us develop brilliant app.

## Quick View
|<img width="1604" alt="Home Screen" src="https://i.imgur.com/9cPsYtC.png">**Home Screen**| <img width="1604" alt="Course Schedual Screen" src="https://i.imgur.com/UV5j5bb.png">**Course schedual**|<img width="1604" alt="Eeclass Screen" src="https://i.imgur.com/5jpPMTu.png">**Eeclass**|
|:-------------------------:|:-------------------------:|:-------------------------:|

## How to start
1. Create a Firebase Project and run 'flutterfire configure', to configure firebase.

2. Go to main and find :

```dart
await Firebase.initializeApp(
    /// If IOS please comment following:
    /// name: "dev project",
    options: DefaultFirebaseOptions.currentPlatform,
  );
```

For android: please makesure `name: "dev project",` is uncomment.

For IOS: please comment this to avoid unneccesary error

3. (For IOS developer) please configure flutter_downloader package :
See following: https://pub.dev/packages/flutter_downloader

