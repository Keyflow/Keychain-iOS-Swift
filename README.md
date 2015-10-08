# Keychain-iOS-Swift
Keychain-iOS-Swift is a simple Swift wrapper for working with the Keychain in iOS, `Keychain` class is able to save, load and delete from iOS Keychain arbitrary objects, including, for example, `String` and `Dictionary`.

## Example

Let's assume that we want to store user authorization token in iOS Keychain. In this case code might look like that:

```
let key = "AuthorizationTokenKey"
let token = "BE71FACB-8893-4DA3-A51E-B8B7DBC8FB9B"
Keychain.save(key, object: token)
// Token is saved in the Keychain

let loadedToken = Keychain.load(key) as! String
// loadedToken == "BE71FACB-8893-4DA3-A51E-B8B7DBC8FB9B"

Keychain.delete(key)
// Token is deleted from the Keychain
```

You might find a more elaborated example of use in `KeychainTests.swift` along with unit tests.

## Objective-C

For Objective-C version of this code please take a look at [Keychain-iOS-ObjC](https://github.com/Keyflow/Keychain-iOS-ObjC)

## License

This project is licensed under the terms of the MIT [license](https://github.com/Keyflow/Keychain-iOS-Swift/blob/master/LICENSE.md).