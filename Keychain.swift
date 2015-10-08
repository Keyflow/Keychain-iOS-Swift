import Foundation
import Security

class Keychain {
    
    class func save(key: String, object: AnyObject) -> Bool {
        var query = Keychain.queryForKey(key)
        
        Keychain.delete(key)
        
        query[kSecValueData as String] = NSKeyedArchiver.archivedDataWithRootObject(object)
        
        return Keychain.checkOSStatus(SecItemAdd(query as CFDictionaryRef, nil))
    }
    
    class func load(key: String) -> AnyObject? {
        var query = Keychain.queryForKey(key)
        
        query[kSecReturnData as String] = kCFBooleanTrue as Bool
        query[kSecMatchLimit as String] = kSecMatchLimitOne as String
        
        var keyData: AnyObject?
        var object: AnyObject?
        
        if Keychain.checkOSStatus(SecItemCopyMatching(query as CFDictionaryRef, &keyData)) {
            object = NSKeyedUnarchiver.unarchiveObjectWithData(keyData as! NSData)
        }
        
        return object
    }
    
    class func delete(key: String) -> Bool {
        let query = Keychain.queryForKey(key)
        return Keychain.checkOSStatus(SecItemDelete(query as CFDictionaryRef))
    }
    
    private class func checkOSStatus(status: OSStatus) -> Bool {
        return status == noErr
    }
    
    private class func queryForKey(key: String) -> [String: AnyObject] {
        return [kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : key,
            kSecAttrAccount as String : key,
            kSecAttrAccessible as String : kSecAttrAccessibleAfterFirstUnlock as String]
    }
}
