//
//  AMKeychainManager.h
//  Created by Joan Martin.
//  Take a look to my repos at http://github.com/vilanovi
//

#import <Foundation/Foundation.h>

@interface AMKeychainManager : NSObject

+ (AMKeychainManager*)defaultManagerForService:(NSString*)service;
+ (AMKeychainManager*)defaultManager;

- (id)initWithService:(NSString*)service;

@property (nonatomic, strong, readonly) NSString *service;

- (NSData*)keychainDataForKey:(NSString*)key;
- (void)setKeychainData:(NSData*)data forKey:(NSString*)key;

- (NSString*)keychainValueForKey:(NSString*)key;
- (void)setKeychainValue:(NSString*)value forKey:(NSString*)key;

- (void)removeKeychainEntryForKey:(NSString*)key;

@end
