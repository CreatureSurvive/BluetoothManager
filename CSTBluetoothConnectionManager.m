/**
 * @Author: Dana Buehre <creaturesurvive>
 * @Date:   26-09-2017 10:50:05
 * @Email:  dbuehre@me.com
 * @Filename: CSTBluetoothConnectionManager.m
 * @Last modified by:   creaturesurvive
 * @Last modified time: 29-09-2017 11:18:18
 * @Copyright: Copyright © 2014-2017 CreatureSurvive
 */


#import "CSTBluetoothConnectionManager.h"

@implementation CSTBluetoothConnectionManager {
    BluetoothManager *_manager;
}

+ (id)sharedManager {
    static dispatch_once_t once;
    static CSTBluetoothConnectionManager *sharedManager;
    dispatch_once(&once, ^{
        sharedManager = [[CSTBluetoothConnectionManager alloc] init];
        [sharedManager prepair];
    });
    return sharedManager;
}

- (void)prepair {
    _manager = [BluetoothManager sharedInstance];
    [_manager pairedDevices];
    [_manager connectedDevices];
}

- (void)connectDevice:(BluetoothDevice *)device {
    if ([self isDeviceConnected:device]) return;
    [[self manager] connectDevice:device];
}

- (void)disconnectDevice:(BluetoothDevice *)device {
    if ([self isDeviceConnected:device]) {
        
        [device disconnect];
    }
}

- (void)toggleConnectionForDevice:(BluetoothDevice *)device {
    if ([self isDeviceConnected:device]) {
        
        [self disconnectDevice:device];
        
    } else {
        [self connectDevice:device];
    }
}

- (BluetoothDevice *)pairedDeviceForName:(NSString *)name {
    BluetoothDevice *pairedDevice;
    for (BluetoothDevice *device in [self pairedDevices]) {
        
        if ([[device name] isEqualToString:name]) {
            pairedDevice = device;
        }
    }
    return pairedDevice;
}

- (BluetoothDevice *)pairedDeviceForAddress:(NSString *)address {
    BluetoothDevice *pairedDevice;
    for (BluetoothDevice *device in [self pairedDevices]) {
        
        if ([[device address] isEqualToString:address]) {
            pairedDevice = device;
        }
    }
    return pairedDevice;
}

- (BluetoothDevice *)connectedDeviceForName:(NSString *)name {
    BluetoothDevice *connectedDevice;
    for (BluetoothDevice *device in [self connectedDevices]) {
        if ([[device name] isEqualToString:name]) {
            connectedDevice = device;
        }
    }
    return connectedDevice;
}

- (BOOL)isDeviceConnected:(BluetoothDevice *)device {
    return ([[self connectedDevices] containsObject:device]);
}

- (BOOL)isDevicePaired:(BluetoothDevice *)device {
    return ([[self pairedDevices] containsObject:device]);
}

- (NSMutableArray *)connectedDevices {
    return [[self manager] connectedDevices];
}

- (NSMutableArray *)pairedDevices {
    return [[self manager] pairedDevices];
}

- (BluetoothManager *)manager {
    if (!_manager) {
        _manager = [BluetoothManager sharedInstance];
    }
    return _manager;
}

- (NSString *)deviceNameForEvent:(int)event {
    if ([[self pairedDevices] count] > event) {
        return [[[self pairedDevices] objectAtIndex:event] name];
    }

    return @"ERROR - device not found";
}

@end
