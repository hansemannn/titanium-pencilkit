/**
 * Axway Titanium
 * Copyright (c) 2009-present by Axway Appcelerator. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import <TitaniumKit/TitaniumKit.h>

API_AVAILABLE(ios(13.0))
@interface TiPencilkitCanvasViewProxy : TiViewProxy

- (void)setDrawing:(TiBlob *)drawingBlob;

- (void)focus:(id)unused;

- (void)exportDrawingData:(id)callback;

- (void)exportDrawingAsImage:(id)args;

@end
