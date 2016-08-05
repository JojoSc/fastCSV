# fastCSV

---
[![Pod](https://img.shields.io/badge/pod-v0.1.0-green.svg)]()
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgray.svg)](https://github.com/JojoSc/OverTheEther)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://en.wikipedia.org/wiki/MIT_License)

---

<br>
## What is this?

FastCSV is a simple CSV (Comma Separated Value) parser. I tried the other two popular CSV parsers, `CSwiftV`and `SwiftCSV`, but when dealing with large files, they were way too slow for my needs. You can find a speed comparison at the end of this page. Note: Currently it is not possible to use the separating Token (e.g. `,`) as a value.

<br>
## Installation

fastCSV is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "fastCSV"
```

Alternatively, add the CSV.swift file to your project.

<br>
## Usage

##### Loading Data
```
let file = "a,b,c\n1,2,3\n4,5,6\n" // or load from disk
let csv = CSV(string: file)
```

##### Reading Data
```
let row0 = csv[row:0]
let column0 = csv[column:1]
let row1:[Int] = csv[row:1].map{Int($0)}
let columns:[[Double]] = csv.columns.map{$0.map{Int($0)!}}
```

##### Adding Data
```
csv.addRow(["7", "8", "9"])
csv.addColumn(name:"d", column:["x", "y"])
csv.addRow( [7, 8, 9].map{String($0)} )
```

##### Concatenating files
```
csv.append(csv2) // This adds all rows from csv2 to csv
```

##### Generating CSV files
```
let file = csv.generateCSV()
try? copy.writeToFile(".../path/...", atomically:true, encoding:NSASCIIStringEncoding)

```

        
<br>
## Speed comparison


#####Speeds:

\+ |fastCSV | CSwiftV | SwiftCSV
-|-|-|-
480 rows, 33 columns| 0.0070 s| 0.453 s| 1.334 s
12480 rows, 33 columns | 1.8 s | 11.0 s |33.8 s

#####Method of testing:

```
self.measureBlock() {
    let csv = CSV(string: self.file)
    for _ in csv.rows {}
}
```

