//
//  AMKeychainManager.m
//  Created by Joan Martin.
//  Take a look to my repos at http://github.com/vilanovi
//

#import "AMKeychainManager.h"

@implementation AMKeychainManager

#pragma mark Static Methods

+ (AMKeychainManager*)defaultManagerForService:(NSString*)service
{
    __strong static NSMutableDictionary *_managers = nil;
    if (!_managers)
        _managers = [NSMutableDictionary dictionary];
    
    id sharedObject = nil;
    
    @synchronized(self)
    {
        sharedObject = [_managers valueForKey:service];
        
        if (!sharedObject)
        {
            sharedObject = [[AMKeychainManager alloc] initWithService:service];
            [_managers setValue:sharedObject forKey:service];
        }
    }
    
    return sharedObject;
}

+ (AMKeychainManager*)defaultManager
{
    AMKeychainManager *manager = [self defaultManagerForService:[[NSBundle mainBundle] bundleIdentifier]];
    return manager;
}

#pragma mark Initializers

- (id)initWithService:(NSString*)service
{
    self = [super init];
    if (self)
    {
        _service = service;
    }
    return self;
}

#pragma mark Public Methods

- (NSData*)keychainDataForKey:(NSString*)key
{
    return [self _retrieveFromKeychainDataForKey:key];
}

- (void)setKeychainData:(NSData*)data forKey:(NSString*)key
{
    [self _storeInKeychainData:data forKey:key];
}

- (NSString*)keychainValueForKey:(NSString*)key
{
    NSData *data = [self keychainDataForKey:key];
    
    if (data)
    {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    }
    
    return nil;
}

- (void)setKeychainValue:(NSString*)value forKey:(NSString*)key
{
    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
    [self setKeychainData:data forKey:key];
}

- (void)removeKeychainEntryForKey:(NSString*)key;
{
    [self _removeFromKeychainDataForKey:key];
}

#pragma mark Private Methods

- (void)_storeInKeychainData:(NSData*)data forKey:(NSString*)key
{    
    if (data == nil)
    {
        [self _removeFromKeychainDataForKey:key];
        return;
    }
    
    // Build the keychain query
    NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          (__bridge_transfer NSString *)kSecClassGenericPassword, (__bridge_transfer NSString *)kSecClass,
                                          _service, kSecAttrService,
                                          key, kSecAttrAccount,
                                          kCFBooleanTrue, kSecReturnAttributes,
                                          nil];
    
    CFDictionaryRef query = (__bridge_retained CFDictionaryRef) keychainQuery;
    
    // Delete an existing entry first:
    SecItemDelete(query);
    
    // Add the accounts query to the keychain query:
    [keychainQuery setObject:data forKey:(__bridge_transfer NSString *)kSecValueData];
    
    // Add the token data to the keychain
    // Even if we never use resData, replacing with NULL in the call throws EXC_BAD_ACCESS
    CFTypeRef resData = NULL;
    SecItemAdd(query, (CFTypeRef *) &resData);
    
    CFRelease(query);
}

- (NSData*)_retrieveFromKeychainDataForKey:(NSString*)key
{
    NSData *data = nil;
    
    // Build the keychain query
    NSDictionary *keychainQuery = [NSDictionary dictionaryWithObjectsAndKeys:
                                   (__bridge_transfer NSString *)kSecClassGenericPassword, (__bridge_transfer NSString *)kSecClass,
                                   _service, kSecAttrService,
                                   key, kSecAttrAccount,
                                   kCFBooleanTrue, kSecReturnData,
                                   kSecMatchLimitOne, kSecMatchLimit,
                                   nil];
    
    CFDictionaryRef query = (__bridge_retained CFDictionaryRef) keychainQuery;
    
    // Get the token data from the keychain
    CFTypeRef resData = NULL;
    
    // Get the token dictionary from the keychain
    if (SecItemCopyMatching(query, (CFTypeRef *) &resData) == noErr)
        data = (__bridge_transfer NSData *)resData;
    
    CFRelease(query);
    
    return data;
}

- (void)_removeFromKeychainDataForKey:(NSString*)key
{
    // Build the keychain query
    NSDictionary *keychainQuery = [NSDictionary dictionaryWithObjectsAndKeys:
                                   (__bridge_transfer NSString *)kSecClassGenericPassword, (__bridge_transfer NSString *)kSecClass,
                                   _service, kSecAttrService,
                                   key, kSecAttrAccount,
                                   kCFBooleanTrue, kSecReturnAttributes,
                                   nil];
    
    CFDictionaryRef query = (__bridge_retained CFDictionaryRef) keychainQuery;
    
    SecItemDelete(query);
    CFRelease(query);
}

@end
