//
//  CodableReadWritable.swift
//  Console
//
//  Created by 김인중 on 20/09/2018.
//  Copyright © 2018 Injungkim. All rights reserved.
//

import Cocoa

enum CodableReadWritableError: Error {
    case notFoundPlist
    case read
}

protocol CodableReadWritable {
    var path: URL { get set }
}

extension CodableReadWritable {
    func read<T: Codable> (type: T.Type) throws -> T? {
        do {
            guard let data = try? Data(contentsOf: path) else {
                throw CodableReadWritableError.notFoundPlist
            }
            let decodeObj = try PropertyListDecoder().decode(type, from: data)
            return decodeObj as T
        } catch {
            print("CodableReadWritable read fail")
            throw CodableReadWritableError.notFoundPlist
        }
    }
    
    func save<T: Codable> (codableObj: T) {
        do {
            let plist = PropertyListEncoder()
            plist.outputFormat = .xml
            let data = try plist.encode(codableObj)
            try data.write(to: path)
        } catch {
            print("CodableReadWritable save fail")
        }
    }
}
