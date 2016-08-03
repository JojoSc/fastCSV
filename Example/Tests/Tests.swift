import UIKit
import XCTest
import fastCSV
import CSwiftV
import SwiftCSV

class Tests: XCTestCase {
    
    var file:String!
    
    override func setUp() {
        super.setUp()
        file = try! NSString(contentsOfFile: "/Users/Jojo/Desktop/dataCum.csv", encoding: NSASCIIStringEncoding) as String
    }
    
    
    // MARK: Test speed
    
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
    
    func testMapSpeed() {
        let csv = fastCSV.CSV(string: self.file)
        let col1 = csv.columns[0]
        self.measureBlock() {
            _ = col1.map{Double($0)}
        }
    }
    
    
    // MARK: Test function
    
    func testCopyInput() {
        let file = "a,b,c\n1,2,3\n4,5,6\n"
        let csv = fastCSV.CSV(string: file)
        let copy = csv.generateCSV()
        XCTAssert(file == copy, "\(file) != \(copy)")
    }
    
    func testRead() {
        let file = "a,b,c\n1,2,3\n4,5,6\n"
        let csv = fastCSV.CSV(string: file)
        XCTAssert(csv.columns.count == 3)
        XCTAssert(csv.rows.count == 2)
        XCTAssert(csv.header == ["a", "b", "c"])
    }
    
    func testAdd() {
        let file = "a,b,c\n1,2,3\n4,5,6\n"
        let csv = fastCSV.CSV(string: file)

    }
}
