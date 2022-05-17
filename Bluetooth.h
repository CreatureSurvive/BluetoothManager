#import <Foundation/Foundation.h>

@interface BluetoothDevice : NSObject
- (NSString *)description;
- (NSString *)name;
- (NSString *)address;
- (void)disconnect;
- (bool)connected;
@end

@interface BluetoothManager : NSObject
+ (id)sharedInstance;
- (NSMutableArray *)connectedDevices;
- (NSMutableArray *)pairedDevices;
- (void)connectDevice:(id)device;
- (void)disconnectDevice:(id)device;
@end
