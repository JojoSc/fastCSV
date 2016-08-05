import UIKit
import XCTest
import fastCSV

class Tests: XCTestCase {
    
    
    var file:String!
    
    override func setUp() {
        super.setUp()
        file = try! NSString(contentsOfFile: "/Users/Jojo/Documents/BTC/Historical/Test2/dataCum.csv", encoding: NSASCIIStringEncoding) as String
    }
    

    
    func testCopyInput() {
        let file = "a,b,c\n1,2,3\n4,5,6\n"
        let csv = fastCSV.CSV(string: file)
        let copy = csv.generateCSV()
        XCTAssert(file == copy, "\(file) != \(copy)")
    }
    
    func testRead() {
        let file = "a,b,c\n1,2,3\n4,5,6\n"
        let csv = fastCSV.CSV(string: file)
        let header = ["a", "b", "c"]
        let columns = [["1","4"],["2","5"],["3","6"]]
        let rows = [["1","2","3"],["4","5","6"]]
        
        XCTAssert(csv.columns == columns, "\(csv.columns) != \(columns)")
        XCTAssert(csv.rows == rows)
        XCTAssert(csv.header == header)
    }
    
    func testAdd() {
        let file = "a,b,c\n1,2,3\n4,5,6\n"
        let csv = fastCSV.CSV(string: file)
        csv.append(csv)
        let expected = "a,b,c\n1,2,3\n4,5,6\n1,2,3\n4,5,6\n"
        XCTAssert(csv.generateCSV() == expected)
    }
}
