import XCTest

import PersistanceTests

var tests = [XCTestCaseEntry]()
tests += PersistanceTests.allTests()
XCTMain(tests)
