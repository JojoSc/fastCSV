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
    
    func testAddRow() {
        let file1 = "a,b,c\n1,2,3\n4,5,6\n"
        let csv1 = fastCSV.CSV(string: file1)
        let file2 = "a,b,c\n1,2,3\n4,5,6\n7,8,9\n"
        let csv2 = fastCSV.CSV(string: file2)
        csv1.addRow(["7", "8", "9"])
        XCTAssert(csv1 == csv2)
    }
    
    func testAddColumn() {
        let file1 = "a,b,c\n1,2,3\n4,5,6\n"
        let csv1 = fastCSV.CSV(string: file1)
        let file2 = "a,b,c,d\n1,2,3,x\n4,5,6,y\n"
        let csv2 = fastCSV.CSV(string: file2)
        csv1.addColumn(name:"d", data:["x", "y"])
        XCTAssert(csv1 == csv2)
    }
    
    func testInEquality() {
        let file1 = "a,b,c\n1,2,3\n4,5,6\n"
        let csv1 = fastCSV.CSV(string: file1)
        let file2 = "a,b,c,d\n1,2,3,x\n4,5,6,y\n"
        let csv2 = fastCSV.CSV(string: file2)
        XCTAssert(csv1 != csv2)
    }
    
    // TODO:
    func testEquality() {
        let file1 = "a,b,c\n1,2,3\n4,5,6\n"
        let csv1 = fastCSV.CSV(string: file1)
        let file2 = "a,b,c,\n1,2,3\n4,5,6"
        let csv2 = fastCSV.CSV(string: file2)
        XCTAssert(csv1 == csv2)
    }
    
    func testMap() {
        let file = "a,b,c\n1,2,3\n4,5,6\n"
        let csv = fastCSV.CSV(string: file)
        let rows:[[Int]] = csv.rows.map{$0.map{Int($0)!}}
        XCTAssert(rows == [[1,2,3],[4,5,6]])
        
        let row0:[Int] = csv[row: 0].map{Int($0)!}
    }
}
