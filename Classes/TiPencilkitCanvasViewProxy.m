/**
 * Axway Titanium
 * Copyright (c) 2009-present by Axway Appcelerator. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiPencilkitCanvasView.h"
#import "TiPencilkitCanvasViewProxy.h"
#import <PencilKit/PencilKit.h>

@implementation TiPencilkitCanvasViewProxy

#pragma mark Private API's

- (TiPencilkitCanvasView *)canvasView
{
  return (TiPencilkitCanvasView *) self.view;
}

#pragma mark Public API's

- (void)setDrawing:(TiBlob *)drawingBlob
{
  if (drawingBlob == nil) {
    [[[self canvasView] canvasView] setDrawing:[PKDrawing new]];
    return;
  }

  NSError *error = nil;
  PKDrawing *drawing = [[PKDrawing alloc] initWithData:drawingBlob.data error:&error];
  
  if (error != nil) {
    NSLog(@"[ERROR] Cannot import drawing: %@", error.localizedDescription);
    return;
  }
  
  [[[self canvasView] canvasView] setDrawing:drawing];
}

- (void)focus:(id)unused
{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [[[self canvasView] canvasView] becomeFirstResponder];
  });
}

- (void)exportDrawingData:(id)callback
{
  ENSURE_SINGLE_ARG(callback, KrollCallback);
  
  PKDrawing *drawing = [[[self canvasView] canvasView] drawing];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSData *dataRepresentation = [drawing dataRepresentation];

    dispatch_async(dispatch_get_main_queue(), ^(){
      [callback call:@[@{ @"data": [[TiBlob alloc] initWithData:dataRepresentation mimetype:(NSString *) PKAppleDrawingTypeIdentifier] }] thisObject:self];
    });
  });
}

- (void)exportDrawingAsImage:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);
  
  KrollCallback *callback = (KrollCallback *)args[@"callback"];
  PKDrawing *drawing = [[[self canvasView] canvasView] drawing];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [drawing imageFromRect:drawing.bounds scale:UIScreen.mainScreen.scale];

    dispatch_async(dispatch_get_main_queue(), ^(){
      [callback call:@[@{ @"image": [[TiBlob alloc] initWithImage:image] }] thisObject:self];
    });
  });
}

@end
