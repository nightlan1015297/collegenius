# Collegenius
Collegenius is an application that develop to help student in NCU (National Centeral University 國立中央大學) access school affair or learning related system in school.
Application combined Course Planning System, Eeclass system. Provide an easy way to access course schedual and learning material for students.
We are planning to add Portal system, bus information to the application, stay tuned! and hope you can join us to help us develop brilliant app.

## Quick View

|<img height="500" alt="Home Screen" src="https://i.imgur.com/9cPsYtC.png"> | <img height="500" alt="Course Schedual Screen" src="https://i.imgur.com/UV5j5bb.png">|<img height="500" alt="Eeclass Screen" src="https://i.imgur.com/5jpPMTu.png">|
|:-------------------------:|:-------------------------:|:-------------------------:|
|**Home Screen**|**Course Schedual Screen**|**Eeclass Screen**|

### Eeclass related feature

|<img height="500" alt="Assignment overview" src="https://i.imgur.com/sDLqCrO.png">|<img height="500" alt="Course Information" src="https://i.imgur.com/prcJHSo.png">| <img height="500" alt="Eeclass course bullitin" src="https://i.imgur.com/utg0mLq.png">|<img height="500" alt="Assignment overview" src="https://i.imgur.com/PLBFfD2.png">|
|:----------:|:----------:|:----------:|:----------:|
|Eeclass dashboard|Course Information|Course bullitins|Course assignments overview|
|<img height="500" alt="Assignment overview" src="https://i.imgur.com/jCkuwdo.png">||||
|Course materials203+ overview||||

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

