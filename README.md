# Collegenius
Collegenius is an application that develop to help student in NCU (National Centeral University 國立中央大學) access school affair or learning related system in school.
Application combined Course Planning System, Eeclass system. Provide an easy way to access course schedual and learning material for students.
We are planning to add Portal system, bus information to the application, stay tuned! and hope you can join us to help us develop brilliant app.

## Quick View
|<img width="1604" alt="Home Screen" src="https://i.imgur.com/9cPsYtC.png">**Home Screen**| <img width="1604" alt="Course Schedual Screen" src="https://i.imgur.com/UV5j5bb.png">**Course schedual**|<img width="1604" alt="Eeclass Screen" src="https://i.imgur.com/5jpPMTu.png">**Eeclass**|
|:-------------------------:|:-------------------------:|:-------------------------:|

## Project Structure
```js
lib
├──constants        
│  ├──Constants     /// Barrel file for constant, import this if you need access to any constant
│  ├──enums         /// All enum const storages at here
│  ├──extensions    /// All extension storages at here
│  ├──lists         /// All list const storages at here
│  ├──maps          /// All map const storages at here
│  └──others        /// If the type of constant can't classify to above category put it here
├──l10n
│  ├──app_en.arb        /// Translate template
│  ├──app_zh_TW.arb     /// Translate data for zh_TW
│  └──app_zh.arb        /// Translate date for zh
├──logic
│  ├──bloc
│  │  ├──       
│  └──cubic
├──models
├──repositories
├──routes
├──ui
├──utilties
│
```
