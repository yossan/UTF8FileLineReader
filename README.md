# UTF8FileLineReader

This module provides a function which reads a line from the file encoded UTF8.

# USAGE

```
let fileLineReader = UTF8FileLineReader(path: `filePath`)

// read one line as Data
while let lineData = fileLineReader?.readLine() {
     // convert Data to String
    if let lineString = String(data: lineData, encoding: .utf8) {
    }
}
```

# INSTALL
## Swift Package Manager

Add the following into dependencies.

```
.Package(url: "https://github.com/ysn551/UTF8FileLineReader", "0.0.1")
```

# LICENSE

[BSD LICENSE](https://opensource.org/licenses/bsd-license.php)

-----------
[@ysn551](https://twitter.com/ysn551),　January 3,2017

