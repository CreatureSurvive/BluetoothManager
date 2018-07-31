/**
 * @Author: Dana Buehre <creaturesurvive>
 * @Date:   26-09-2017 11:06:36
 * @Email:  dbuehre@me.com
 * @Filename: CSTBluetoothConnectionManager.h
 * @Last modified by:   creaturesurvive
 * @Last modified time: 29-09-2017 11:16:14
 * @Copyright: Copyright © 2014-2017 CreatureSurvive
 */


#include "Bluetooth.h"

@interface CSTBluetoothConnectionManager : NSObject
+ (id)sharedManager;
- (void)connectDevice:(BluetoothDevice *)device;
- (void)disconnectDevice:(BluetoothDevice *)device;
- (void)toggleConnectionForDevice:(BluetoothDevice *)device;
- (BluetoothDevice *)pairedDeviceForName:(NSString *)name;
- (BluetoothDevice *)connectedDeviceForName:(NSString *)name;
- (BluetoothDevice *)pairedDeviceForAddress:(NSString *)address;
- (BOOL)isDeviceConnected:(BluetoothDevice *)device;
- (BOOL)isDevicePaired:(BluetoothDevice *)device;
- (NSMutableArray *)connectedDevices;
- (NSMutableArray *)pairedDevices;
- (NSString *)deviceNameForEvent:(int)event;
@end
