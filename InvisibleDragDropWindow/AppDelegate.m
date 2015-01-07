//
//  AppDelegate.m
//  InvisibleDragDropWindow
//

#import "AppDelegate.h"
#import "DragDropWindow.h"

@interface AppDelegate ()

@property IBOutlet DragDropWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.window=[[DragDropWindow alloc] init];
    [self.window center];
    [self.window makeKeyAndOrderFront:self];
}

@end
