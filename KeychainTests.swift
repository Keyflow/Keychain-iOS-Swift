import XCTest

class KeychainTests: XCTestCase {
    
    func testKeychainMethods() {
        let key = "Key"
        let subKey1 = "TestKey1"
        let subKey2 = "TestKey2"
        let subKey3 = "TestKey3"
        let data1 = "TestData1"
        let data2 = [1, 2, 3, 4]
        let data3 = ["SubKey1": data1, "SubKey1": data2]
        
        let object = [subKey1 : data1, subKey2: data2, subKey3: data3]
        
        XCTAssert(Keychain.save(key, object:object), "Couldn't save object to the Keychain")
        
        let loadedObject = Keychain.load(key)
        XCTAssert(loadedObject != nil, "Couldn't read object from the Keychain, received nil")
        
        let loadedDictionary = loadedObject as! Dictionary<String, AnyObject>
        XCTAssert(loadedDictionary[subKey1] as! String == data1, "Read String is corrupted")
        XCTAssert((loadedDictionary[subKey2] as! [Int]) == data2, "Read Array is corrupted")
        XCTAssert((loadedDictionary[subKey3] as! Dictionary<String, AnyObject>) == data3, "Read Dictionary is corrupted")
        
        XCTAssert(Keychain.delete(key), "Couldn't delete object in Keychain")
    }
}
