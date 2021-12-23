/**
 * Sample React Native App
 *
 * adapted from App.js generated by the following command:
 *
 * react-native init example
 *
 * https://github.com/facebook/react-native
 */

import React, {Component} from 'react';

import {
  Button,
  NativeModules,
  StyleSheet,
  Text,
  View,
} from 'react-native';

export default class App extends Component<{}> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>☆Card91Sdk example☆</Text>
        <Text style={styles.instructions}>STATUS: loaded</Text>
        <Text style={styles.welcome}>☆☆☆</Text>
        {/*
Method Name - navigateToCustomerSDK
 - First Argument need to pass mobile number
 - Second Argument need to pass DeviceID
 - Thrid Argument need to pass one of the following value
   [DEV, DEV_LIVE, UAT, UAT_LIVE, DEMO_LIVE, DEMO_SANDBOX,STAGE_SANDBOX,STAGE_LIVE]

*/}
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
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
