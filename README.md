# react-native-card91-sdk

## Getting started

`$ npm install https://github.com/saisuresh-banc91/react-native-card91-sdk.git --save`

### Mostly automatic installation

`$ react-native link react-native-card91-sdk`

## Usage
```javascript

import {
  Button,
  NativeModules,
  StyleSheet,
  Text,
  View,
} from 'react-native';

 /*
Method Name - navigateToCustomerSDK
 - First Argument need to pass mobile number
 - Second Argument need to pass DeviceID
 - Thrid Argument need to pass one of the following value
   [DEV, DEV_LIVE, UAT, UAT_LIVE, DEMO_LIVE, DEMO_SANDBOX,STAGE_SANDBOX,STAGE_LIVE]

*/
        <Button
          onPress={() => {
            try {
              console.log('started here!!!!');
              NativeModules.ActivityStarter.navigateToCustomerSDK(
                '919876543213',
                'abvdmdsfbmasdvfbmmfv',
                'DEV',
              );
            } catch (error) {
              console.log(error);
            }
          }}
          title="Open SDK"
        />
```
# Add the following in root android folder *
## AndroidManifest.xml
```javascript
<activity
    ...
     android:exported="true">
...
</activity>
```
## build.gradle 
```javascript
buildscript {
    ext {
        buildToolsVersion = "30.0.2"
        minSdkVersion = 24
        compileSdkVersion = 31
        targetSdkVersion = 31
        ndkVersion = "21.4.7075529"
    }
dependencies {
        classpath("com.android.tools.build:gradle:7.0.3")
        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
```
## gradle-wrapper.properties
```javascript
distributionUrl=https\://services.gradle.org/distributions/gradle-7.0.2-all.zip
```
# Follow steps if Apk is not working on Mobile Device
 1. Go to your project directory and check if this folder exists android/app/src/main/assets
    i) If it exists then delete two files viz index.android.bundle and index.android.bundle.meta
    ii) If the folder assets don’t exist then create the assets directory there.
2. From your root project directory do
      ```javascript
      cd android
      ./gradlew clean
      ```
3. Finally, navigate back to the root directory and check
    If there is only one file i.e. index.js then run following command
    ```javascript
    react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res
    ```
