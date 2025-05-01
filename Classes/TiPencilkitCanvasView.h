/**
 * Axway Titanium
 * Copyright (c) 2009-present by Axway Appcelerator. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import <TitaniumKit/TitaniumKit.h>
#import <PencilKit/PencilKit.h>

@interface TiPencilkitCanvasView : TiUIView<PKCanvasViewDelegate, PKToolPickerObserver>

@property(nonatomic, strong) PKCanvasView *canvasView;

@end
