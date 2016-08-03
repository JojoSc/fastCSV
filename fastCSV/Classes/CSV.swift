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
        return _header
    }

    public var columns:[[String]] {
        return _columns
    }

    public var rows:[[String]] {
        return _rows
    }



    private var _header = [String]()
    private var _columns = [[String]]()
    private var _rows = [[String]]()

    public init(string:String) {
        var lines = string.componentsSeparatedByString(lineSeparator)
        _header = lines.removeFirst().componentsSeparatedByString(columnSeparator)

        for _ in _header {_columns.append([])}

        for line in lines {
            if line != "" {
                let vals = line.componentsSeparatedByString(columnSeparator)
                _rows.append(vals)
                for (i,val) in vals.enumerate() {
                    _columns[i].append(val)
                }
            }
        }
        
    }

    public func generateCSV() -> String {
        var rtn = header.joinWithSeparator(columnSeparator) + lineSeparator
        for row in _rows {
            rtn += row.joinWithSeparator(columnSeparator) + lineSeparator
        }
        return rtn
    }


    
    
    // MARK: - Remove Methods

    public func removeRow(row:Int) {
        _rows.removeAtIndex(row)
        _columns = _columns.map { var x = $0; x.removeAtIndex(row); return x }
    }

    public func removeRows(rows:Range<Int>) {
        _rows.removeRange(rows)
        _columns = _columns.map { var x = $0; x.removeRange(rows); return x }
    }

    public func removeColumn(col:Int) {
        _header.removeAtIndex(col)
        _columns.removeAtIndex(col)
        _rows = _rows.map { var x = $0; x.removeAtIndex(col); return x }
    }

    public func removeColumns(cols:Range<Int>) {
        _header.removeRange(cols)
        _columns.removeRange(cols)
        _rows = _rows.map { var x = $0; x.removeRange(cols); return x }
    }
    
    
    
    
    // MARK: - Add Methods
    
    public func append(csv:CSV) {
        _rows.appendContentsOf(csv._rows)
        for row in csv._rows {
            for (i,elem) in row.enumerate() {
                _columns[i].append(elem)
            }
        }
    }
}
