//
//  Created by ysn551 on 12/30/16.
//  Copyright © 2016 ysn551. All rights reserved.
//
import XCTest
@testable import UTF8FileLineReader

class UTF8FileLineReaderTest: XCTestCase {

    let testBundle = Bundle(path: URL(fileURLWithPath: #file).deletingLastPathComponent().path)!
    func filePath(name: String) -> String {
        return testBundle.path(forResource: name, ofType: nil)!
    }

    func testAsciiFile() {
        let path = self.filePath(name: "ascii_utf8.txt")
        let fileLineReader = UTF8FileLineReader(path: path)

        XCTAssertNotNil(fileLineReader)
        
        var i: Int = 0
        let asciiFileLines = self.asciiFileLines
        while let lineData = fileLineReader?.readLine() {
            let lineStr = String(data: lineData, encoding: .utf8)

            XCTAssertNotNil(lineStr)
            XCTAssertEqual(lineStr!, asciiFileLines[i])

            i += 1

        }
    }

    var asciiFileLines: [String] {
        return [ 
            "a",
            "bb",
            "ccc",
            "dddd",
            "eeeee",
            "ffffff",
            "ggggggg",
            "hhhhhhhh",
            "iiiiiiiii",
            "jjjjjjjjjj",
            "kkkkkkkkkk",
            "lllllllllll",
            "mmmmmmmmmmmm",
            "nnnnnnnnnnnnn",
            "oooooooooooooo"
        ]
    }

    func testMultiBytesFile() {
        let path = self.filePath(name: "multibytes_utf8.txt")
        let fileLineReader = UTF8FileLineReader(path: path)

        XCTAssertNotNil(fileLineReader)
        
        var multibytesFileLines = self.multibytesFileLines
        var i: Int = 0
        while let lineData = fileLineReader?.readLine() {
            let lineStr = String(data: lineData, encoding: .utf8)
            XCTAssertNotNil(lineStr)
            XCTAssertEqual(lineStr, multibytesFileLines[i])
            i += 1
        }
    }

    var multibytesFileLines: [String] {
        return [
            "Hello",
            "おはよう",
            "안녕",
            "早上好",
            "höchste",
            "✈ ★ ♂ □ § 〓",
            "🎍 🎋 🍃 🍂 🍁 🍄",
            "H e お　안¥早hö✈🎍",
        ]
    }


    func testTooLargeFileLine() {
        let path = self.filePath(name: "large_one_line.txt")
        let fileLineReader = UTF8FileLineReader(path: path)
        XCTAssertNotNil(fileLineReader)

        var lineNum = 0
        var size: Int = 0
        while let lineData = fileLineReader?.readLine() {
            
            size = lineData.count
            lineNum += 1
        }

        XCTAssertEqual(lineNum, 1)
        XCTAssertEqual(size, 15776)
    }

}
