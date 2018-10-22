//
//  Undefined.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/22.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

enum Undefined {
    static func object<T>(_ message: String = "Fatal Error",
                          file: String = #file,
                          function: String = #function,
                          line: Int = #line) -> T {
        fatalError("""
            message: \(message)

            file: \(file)
            function: \(function)
            line: \(line)
        """)
    }
}
