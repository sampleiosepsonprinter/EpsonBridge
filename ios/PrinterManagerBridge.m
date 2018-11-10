//
//  PrinterManagerBridge.m
//  EpsonBridge
//
//  Created by Aditya Bansal on 11/9/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

// PrinterManagerBridge.m
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(PrinterManager, NSObject)

RCT_EXTERN_METHOD(printReceiptV0:(NSDictionary *)receipt);

@end
