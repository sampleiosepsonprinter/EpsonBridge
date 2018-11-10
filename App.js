/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View} from 'react-native';
import { Button } from 'react-native';


var React2 = require('react-native');
console.dir(React2.NativeModules.PrinterManager);


var receiptSection = {Lines: ["Line 1" , "Line 2" , "Line3\nLine4"] , Font: 12 , Bold: true , Ital: false, LineSpacing:2 , Alignment: 0}
var receiptSection2 = {Lines: ["Line 5" , "Line 6" , "Line7\nLine8"] , Font: 24,  Bold: true , Ital: false, LineSpacing:3 , Alignment: 2}

console.log(receiptSection)

var receipt = {
  "sections" : [receiptSection, receiptSection2],
  "HeaderImage" : "Base64EncodedStringConvertedFromBitmap",
  "FooterImage" : "Base64EncodedStringConvertedFromBitmap"
} ;


const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};
export default class App extends Component<Props> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>

        <Button
          onPress={onPressReceipt}
          title="Print Sample Receipt!"
          color="#841584"
        />
      </View>
    );
  }
}

var onPressReceipt = function() {
  console.log("Sending Receipt")
  React2.NativeModules.PrinterManager.printReceiptV0(receipt);

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
