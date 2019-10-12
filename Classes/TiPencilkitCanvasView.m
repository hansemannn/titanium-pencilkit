/**
 * Axway Titanium
 * Copyright (c) 2009-present by Axway Appcelerator. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiPencilkitCanvasView.h"

@implementation TiPencilkitCanvasView

@synthesize canvasView = _canvasView;

#pragma mark Private API's

- (PKCanvasView *)canvasView
{
  if (_canvasView == nil) {
    _canvasView = [[PKCanvasView alloc] initWithFrame:self.bounds];
    _canvasView.delegate = self;
    _canvasView.alwaysBounceVertical = YES;

    [self addSubview:_canvasView];
    
    PKToolPicker *toolPicker = [PKToolPicker sharedToolPickerForWindow:TiApp.app.controller.view.window];
    [toolPicker setVisible:YES forFirstResponder:_canvasView];
    [toolPicker addObserver:_canvasView];
    [toolPicker addObserver:self];
    
    [self updateLayoutForToolPicker:toolPicker];
  }
  
  return _canvasView;
}

- (void)updateLayoutForToolPicker:(PKToolPicker *)toolPicker
{
  CGRect obscuredFrame = [toolPicker frameObscuredInView:self];
  if (CGRectIsNull(obscuredFrame)) {
    _canvasView.contentInset = UIEdgeInsetsZero;
  } else {
    _canvasView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetMaxX(self.bounds) - CGRectGetMinY(obscuredFrame), 0);
  }
  
  _canvasView.scrollIndicatorInsets = _canvasView.contentInset;
}

#pragma mark Public API's

- (void)setAlwaysBounceVertical:(NSNumber *)alwaysBounceVertical
{
  [[self canvasView] setAlwaysBounceVertical:alwaysBounceVertical.boolValue];
}

- (void)setAllowsFingerDrawing:(NSNumber *)allowsFingerDrawing
{
  [[self canvasView] setAllowsFingerDrawing:allowsFingerDrawing.boolValue];
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
  [TiUtils setView:[self canvasView] positionRect:bounds];
  [super frameSizeChanged:frame bounds:bounds];
}

#pragma mark PKCanvasViewDelegate

- (void)canvasViewDidFinishRendering:(PKCanvasView *)canvasView
{
  [self.proxy fireEvent:@"finishedRendering"];
}

- (void)canvasViewDidBeginUsingTool:(PKCanvasView *)canvasView
{
  [self.proxy fireEvent:@"begin"];
}

- (void)canvasViewDrawingDidChange:(PKCanvasView *)canvasView
{
  [self.proxy fireEvent:@"change"];
}

- (void)canvasViewDidEndUsingTool:(PKCanvasView *)canvasView
{
  [self.proxy fireEvent:@"end"];
}

#pragma mark PKToolPickerObserver

- (void)toolPickerVisibilityDidChange:(PKToolPicker *)toolPicker
{
  [self.proxy fireEvent:@"toolPicker:visibilityDidChange" withObject:@{ @"isVisible": @(toolPicker.isVisible) }];
  [self updateLayoutForToolPicker:toolPicker];
}

- (void)toolPickerSelectedToolDidChange:(PKToolPicker *)toolPicker
{
  [self.proxy fireEvent:@"toolPicker:selectedToolDidChange"];
}

- (void)toolPickerIsRulerActiveDidChange:(PKToolPicker *)toolPicker
{
  [self.proxy fireEvent:@"toolPicker:isRulerActiveDidChange" withObject:@{ @"rulerActive": @(toolPicker.rulerActive) }];
}

- (void)toolPickerFramesObscuredDidChange:(PKToolPicker *)toolPicker
{
  [self.proxy fireEvent:@"toolPicker:framesObscuredDidChange"];
  [self updateLayoutForToolPicker:toolPicker];
}

@end
