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

---
## Licence ##

Copyright (c) 2013 Joan Martin, vilanovi@gmail.com.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE