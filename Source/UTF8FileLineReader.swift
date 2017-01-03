//
//  Created by ysn551 on 12/30/16.
//  Copyright © 2016 ysn551. All rights reserved.
//

import Foundation

private let kBlockSize: Int =  MemoryLayout<Int>.size
private let kInitialBlocksSize: Int = MemoryLayout<Int>.size * 100
private let kNewlineCode: UInt8 = 0x0a

/**
 # UTF8FileLineReader
   This provides the function to read one line in the file.
 */
struct UTF8FileLineReader {

    private let fileHandle: FileHandle
    private let fileSize: UInt64

    /**
     Retuns an FileLineReader object initialized to read one line in the file.
     - parameter path: file path.
     */
    init?(path: String) {
        guard let fileAttributes = try? FileManager.`default`.attributesOfItem(atPath: path),
            let fileHandle = FileHandle(forReadingAtPath: path)
            else { return nil }
        
        self.fileHandle = fileHandle
        self.fileSize = fileAttributes[.size] as! UInt64
    }
    
    /// Flag that indicate whether fileHandle is scaned to the end of file.
    public var isAtEnd: Bool {
        return self.fileHandle.offsetInFile >= self.fileSize
    }

    public func readLine() -> Data? {

        // returns varlue
        var blocksData: Data? = nil
    
        let previousOffsetInFile = self.fileHandle.offsetInFile

        seekingFile: while self.isAtEnd == false {
            // read data in file
            let blockData = self.fileHandle.readData(ofLength: kBlockSize)

            // find newline-code per one byte
            for b in blockData {
                if b != kNewlineCode {
                    if blocksData == nil {
                        blocksData = Data(capacity: kInitialBlocksSize)
                    }
                    blocksData!.append(b)
                } else {
                    break seekingFile
                }
            }
        }

        // put back file offset by too much to read data
        self.fileHandle.seek(toFileOffset: previousOffsetInFile + UInt64(blocksData?.count ?? 0) + 1)

        return blocksData
    }
    
}
