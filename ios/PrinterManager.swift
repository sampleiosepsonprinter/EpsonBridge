//
//  PrinterManager
//  EpsonBridge
//
//  Created by Aditya Bansal on 11/9/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
@objc(PrinterManager)

class PrinterManager: NSObject {
  let TAG = "Printer"
  
  var printer: Epos2Printer?
  var valuePrinterSeries: Epos2PrinterSeries = EPOS2_TM_M10
  var valuePrinterModel: Epos2ModelLang = EPOS2_MODEL_ANK
  
  @objc func printReceiptV0(_ receipt:  NSDictionary) -> Void {
//    printer = Epos2Printer(printerSeries: valuePrinterSeries.rawValue, lang: valuePrinterModel.rawValue)
    //Connect printer in a sep. function. Ideally when the app is initialzed then. Maintain, and check if its connected here
    

    let printerStatus =  printer?.getStatus()
    if (!isPrintable(status: printerStatus)) {
      //Log error, and callback with error.
      //TODO
    }
    
    
    
  
    //TODO Image creation should be a sep function
    let headerImage: NSString   = receipt.object(forKey:("HeaderImage")) as! NSString;
//    let headerImageData:NSData = NSData(base64Encoded: headerImage as! String, options: NSData.Base64DecodingOptions(rawValue: 0))!
//    let decodedimage:UIImage? = UIImage(data: headerImageData as! Data)
//    printer?.add(decodedimage, x:0, y:0,
//                      width:Int(decodedimage!.size.width),
//                      height:Int(decodedimage!.size.height),
//                      color:EPOS2_PARAM_DEFAULT,
//                      mode:EPOS2_PARAM_DEFAULT,
//                      halftone:EPOS2_PARAM_DEFAULT,
//                      brightness:Double(EPOS2_PARAM_DEFAULT),
//                      compress:EPOS2_PARAM_DEFAULT)
    
 
    let receiptSectionsArray: NSArray   = receipt.object(forKey:("sections")) as! NSArray;
    NSLog(TAG + "This is the section" )
    
    for section in receiptSectionsArray {
      let receipSectionDict : NSDictionary = section as! NSDictionary
      NSLog(TAG + " Section Dict %@ ", receipSectionDict)
      
      let textAlignment : Any = receipSectionDict.object(forKey: "Alignment") as! Any;
      let textFont : Any = receipSectionDict.object(forKey: "Font") as! Any;
      let textLineSpacing : Any = receipSectionDict.object(forKey: "LineSpacing") as! Any;
      
      if (!(textAlignment is NSInteger) || !(textFont is NSInteger) || !(textLineSpacing is NSInteger)) {
        NSLog("Error, something is not passes in correctly")
        continue
      }
      
      let textAlignmentInt : NSInteger = textAlignment as! NSInteger
      let textFontInt : NSInteger = textFont as! NSInteger
      let textLineSpacingInt : NSInteger = textLineSpacing as! NSInteger
      
      NSLog(TAG + " Printer Section Alignemnt, Font, Spacing is %d %d %d", textAlignmentInt , textFontInt, textLineSpacingInt)
      
      printer?.addTextAlign(Int32(truncatingIfNeeded: textAlignmentInt))
      printer?.addTextFont(Int32(truncatingIfNeeded: textFontInt))
      printer?.addLineSpace(Int(Int32(truncatingIfNeeded: textLineSpacingInt)))
    
      //Add all the lines...including newlines
      let linesArray : NSArray = receipSectionDict.object(forKey: "Lines") as! NSArray;
      for lineString in linesArray {
        printer?.addText(String(lineString as! String))
      }
    }
    
    
    //TODO add footer image, in a sep function
    //Create a function that takes an input as a Base64 string, returns a UIImage
    
    
    //TODO call print function.... and return statusCode as a callback
  }
  
  
  
  
  
  //Taken from the EpsonSDK
  func isPrintable(status: Epos2PrinterStatusInfo?) -> Bool {
    if status == nil {
      return false
    }
    
    if status!.connection == EPOS2_FALSE {
      return false
    }
    else if status!.online == EPOS2_FALSE {
      return false
    }
    else {
      // print available
    }
    return true
  }
}
