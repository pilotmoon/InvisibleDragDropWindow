//
//  DragDropWindow.m
//  InvisibleDragDropWindow
//

#import "DragDropWindow.h"

@implementation DragDropWindow

- (id)init
{
    self=[super initWithContentRect:NSMakeRect(0, 0, 200, 200) styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
    if (self) {
        // register for some types just to be able to trigger draggingEntered
        [self registerForDraggedTypes:@[(NSString *)kUTTypeFileURL, (NSString *)kUTTypeUTF8PlainText]];
        
        // set up the window
        [self setBackgroundColor:[NSColor clearColor]];
        [self setOpaque:NO];
        [self setLevel:NSModalPanelWindowLevel];
        
        // host a layer
        CALayer *layer=[[CALayer alloc] init];
        [[self contentView] setLayer:layer];
        [[self contentView] setWantsLayer:YES];
        
        // helper block to draw a plain coloured image
        NSImage *(^colorImage)(NSColor *) = ^(NSColor *color) {
            return [NSImage imageWithSize:layer.frame.size flipped:NO drawingHandler:^BOOL(NSRect dstRect) {
                [color set];
                NSRectFill(dstRect);
                return YES;
            }];
        };

        // start with red background so we can see where the window is
        [layer setContents:colorImage([NSColor redColor])];
        
        // switch to clear background after 3 seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [layer setContents:colorImage([NSColor clearColor])];
        });
    }
    return self;
}

#pragma mark NSWindow override

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSLog(@"Dragging entered!");
    return NSDragOperationNone;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    NSLog(@"Dragging exited!");
}

@end
