//
//  SpeedTest.swift
//  fastCSV
//
//  Created by Johannes Schreiber on 05/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import fastCSV
import CSwiftV
import SwiftCSV
import fastCSV

class SpeedTest: XCTestCase {
    
    var file:String!
    
    override func setUp() {
        super.setUp()
        file = try! NSString(contentsOfFile: "/Users/Jojo/Documents/BTC/Historical/Test2/dataCum.csv", encoding: NSASCIIStringEncoding) as String
    }

    func testPerformancefastCSVRows() {
        self.measureBlock() {
            let csv = fastCSV.CSV(string: self.file)
            for row in csv.rows {
                for _ in row {
                    
                }
            }
        }
    }
    
    func testPerformancefastCSVCols() {
        self.measureBlock() {
            let csv = fastCSV.CSV(string: self.file)
            for col in csv.columns {
                for _ in col {
                    
                }
            }
        }
    }
    
    //    func testPerformanceCSwiftV() {
    //        self.measureBlock() {
    //            let csv = CSwiftV(string: self.file)
    //            for _ in csv.rows {
    //            }
    //        }
    //    }
    //
    //    func testPerformanceSwiftCSV() {
    //        self.measureBlock() {
    //            let csv = SwiftCSV.CSV(string: self.file)
    //            for _ in csv.rows {
    //            }
    //        }
    //    }
    
    
    // Testing how fast map({...}) is
    func testMapSpeed() {
        let csv = fastCSV.CSV(string: self.file)
        let col1 = csv.columns[0]
        self.measureBlock() {
            _ = col1.map { Double($0) }
        }
    }
}
