
# Introduction
This app is for [Getir](https://www.getir.com/) coding challenge  
You can work with app using [online iOS simulator **Appetize.io**](https://appetize.io/app/egd3zzxyj76z19f7vj1az4tbw8?device=iphone6s&scale=75&orientation=portrait&osVersion=13.3)

## Project limitations
Mentioned limitations:  
- Swift
- CoreData/Realm

I've choosed `CoreData` instead of `Realm` because It is apple known framework and also have benefits:
- use `static dispatch` instead of  `dynamic dispatch` 
- faster than `Realm`

## Installation requirements
- iOS 13.0
>  If we use **RxSwift** instead of **Combine**  then we will fully compatible with **Swift** version **iOS 10+**
- Xcode 11.3 
- macOS Catalina

## Project overview
- Design pattern: **Modular**
- Architecture pattern: **MVVM**
- Control application flow: **Coordinator**
- Observation: **Combine Framework**
- Database manager: **CoreData Framework** 

## Third-party libraries
I've just used a multi tab style pageViewController: [SwipeMenuViewController](https://github.com/yysskk/SwipeMenuViewController)  
If we ignore that, every line of this project was written by myself without copy paste.

