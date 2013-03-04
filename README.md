KeychainManager
===============

Use this manager to access the keychain as it was a dictionary.

###I. Get an instance of a AMKeychainManager

The `AMKeychainManager` implements the singleton pattern for each service. You can retrieve the default instance for each service using the method:

  + (AMKeychainManager*)defaultManagerForService:(NSString*)service;

However, you can access the default service (named as your `NSBundle` identifier) usign the method:
	
	+ (AMKeychainManager*)defaultManager;

You can also create a new instance of a manager for a service using the basic init method:

	- (id)initWithService:(NSString*)service;
	
##### Note
The keychain stores the key-values pairs within a service name. Multiple instances of a keychain manager with a same service value will access and operate over the same keychain key-values pairs.

###II. Get, Set & Remove Values

With this manager, you can easily store `NSData` or `NSString` values inside the keychain. 

To store and retrieve `NSData` use the methods:

	- (NSData*)keychainDataForKey:(NSString*)key;
	- (void)setKeychainData:(NSData*)data forKey:(NSString*)key;

To store and retrieve `NSString` use the methods:

	- (NSString*)keychainValueForKey:(NSString*)key;
	- (void)setKeychainValue:(NSString*)value forKey:(NSString*)key;

To remove an entry of the keychain use the method:

	- (void)removeKeychainEntryForKey:(NSString*)key;
