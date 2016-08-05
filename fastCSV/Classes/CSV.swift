//
//  CSV.swift
//  BTXPlot
//
//  Created by Johannes Schreiber on 05/07/16.
//  Copyright © 2016 Johannes Schreiber. All rights reserved.
//

import Foundation

public class CSV {

    public var lineSeparator = "\n"
    public var columnSeparator = ","

    public var header:[String] {
        return storage[0]
    }

    public subscript(column column:Int) -> [String] {
        var col = storage.map { $0[column] }
        col.removeFirst()
        return col
    }
    
    public var columns:[[String]] {
        var rtn = [[String]]()
        for i in 0..<storage[0].count {
            rtn.append(self[column: i])
        }
        return rtn
    }
    
    public subscript(row row:Int) -> [String] {
        return storage[row + 1]
    }

    public var rows:[[String]] {
        return Array(storage[1..<storage.count])
    }


    private var storage = [[String]]()

    
    
    // MARK: - Reading and writing CSV files
    
    public init(string:String) {
        var lines = string.componentsSeparatedByString(lineSeparator)
        storage.append( lines.removeFirst().componentsSeparatedByString(columnSeparator) )

        for line in lines {
            if line != "" {
                let vals = line.componentsSeparatedByString(columnSeparator)
                storage.append(vals)
            }
        }
        
    }

    public func generateCSV() -> String {
        var rtn = ""
        for row in storage {
            rtn += row.joinWithSeparator(columnSeparator) + lineSeparator
        }
        return rtn
    }


    
    
    // MARK: - Remove Methods

    public func removeRow(row:Int) {
        storage.removeAtIndex(row + 1)
    }

    public func removeRows(rows:Range<Int>) {
        var shiftedRange = rows
        shiftedRange.startIndex += 1
        shiftedRange.endIndex += 1
        storage.removeRange(shiftedRange)
    }

    public func removeColumn(col:Int) {
        storage = storage.map { var x = $0; x.removeAtIndex(col); return x }
    }

    public func removeColumns(cols:Range<Int>) {
        storage = storage.map { var x = $0; x.removeRange(cols); return x }
    }
    
    
    
    
    // MARK: - Add Methods
    
    public func append(csv:CSV) {
        storage.appendContentsOf(csv.rows)
    }

}
