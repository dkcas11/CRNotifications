# CRNotifications
CRNotifications are custom in-app notifications with 3 types of layouts. The notifications will animate in and out. They will hide when they are clicked on or with an automatic dismissal.

### Screenshots
-------


##### Notifications types

| Success | Error  |Info  |
| --- | --- | --- |
| ![alt text](http://i831.photobucket.com/albums/zz237/dkcas11/success.jpg "Success")  | ![alt text](http://i831.photobucket.com/albums/zz237/dkcas11/error.jpg "Error") |  ![alt text](http://i831.photobucket.com/albums/zz237/dkcas11/info.jpg "Info")|



### How to use
-------

Call ``CRNotifications.showNotification`` with a title, message, notification type and a time for how long the notification should appear. Should the notification not disappear automatically use a time of ``0``. You may also pass a completion block that is executed once the notification disappears.

Notification types are :
```.success```
```.error```
```.info```

Example : 

```
CRNotifications.showNotification(type: .success, title: "Success!", message: "You successfully showed this notification.", dismissDelay: 3)
```

### Installation
-------

#### Cocoapods install

##### Swift 4
```
pod 'CRNotifications'
```
##### Swift 3
```
pod 'CRNotifications', :git => 'https://github.com/dkcas11/CRNotifications.git', :branch => 'swift3'
```

#### Manual install
Drag the *CRNotifications* folder into your project and you are good to go.

### Author & Contributors
-------

**Casper Riboe** (Author)
> Facebook : [Casper Riboe](http://facebook.com/dkcas11)<br/>
> Twitter  : [dkcas11](http://twitter.com/dkcas11)<br/>
> Mail     : [casper2602@hotmail.com](mailto:casper260@hotmail.com)

**Herrick Wolber** (Contribution)
> Twitter : [estar2005](http://twitter.com/estar2005) <br/>
> Github  : [Rico237](https://github.com/rico237) <br/>
> Mail    : [wolbereric@yahoo.fr](mailto:wolbereric@yahoo.fr)

