/**
 * titanium-pencilkit
 *
 * Created by Your Name
 * Copyright (c) 2019 Your Company. All rights reserved.
 */

#import "TiPencilkitModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiPencilkitModule

#pragma mark Internal

// This is generated for your module, please do not change it
- (id)moduleGUID
{
  return @"297369cd-a62e-4740-8993-8201ec43b5fd";
}

// This is generated for your module, please do not change it
- (NSString *)moduleId
{
  return @"ti.pencilkit";
}

#pragma mark Lifecycle

- (void)startup
{
  // This method is called when the module is first loaded
  // You *must* call the superclass
  [super startup];
  DebugLog(@"[DEBUG] %@ loaded", self);
}

#pragma Public APIs

- (NSString *)example:(id)args
{
  // Example method. 
  // Call with "MyModule.example(args)"
  return @"hello world";
}

- (NSString *)exampleProp
{
  // Example property getter. 
  // Call with "MyModule.exampleProp" or "MyModule.getExampleProp()"
  return @"Titanium rocks!";
}

- (void)setExampleProp:(id)value
{
  // Example property setter. 
  // Call with "MyModule.exampleProp = 'newValue'" or "MyModule.setExampleProp('newValue')"
}

@end
