//
//  XCTestCase+Snapshot.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import XCTest
import SnapshotTesting

extension XCTestCase {
  func assert(_ viewController: UIViewController,
              identifier: String = "",
              mode: UIUserInterfaceStyle = .light,
              orientation: ViewImageConfig.Orientation = .portrait,
              testName: String = #function,
              isRecordingMode: Bool = false,
              file: StaticString = #filePath,
              line: UInt = #line) {

    viewController.overrideUserInterfaceStyle = mode

    verifyViewController(
      viewController,
      named: identifier + (mode == .light ? "light" : " dark"),
      isRecordingMode: isRecordingMode,
      orientation: orientation,
      testName: testName,
      file: file,
      line: line)
  }

  func record(_ viewController: UIViewController,
              identifier: String = "",
              mode: UIUserInterfaceStyle = .light,
              orientation: ViewImageConfig.Orientation = .portrait,
              testName: String = #function,
              file: StaticString = #filePath,
              line: UInt = #line) {
    assert(viewController,
           identifier: identifier,
           mode: mode,
           orientation: orientation,
           testName: testName,
           isRecordingMode: true,
           file: file,
           line: line)
  }

  private func verifyViewController(_ viewController: UIViewController,
                                    named: String,
                                    isRecordingMode: Bool = false,
                                    orientation: ViewImageConfig.Orientation,
                                    testName: String,
                                    file: StaticString = #filePath,
                                    line: UInt = #line) {
    let devices: [String: ViewImageConfig] = ["iPhoneX": .iPhoneX(orientation),
                                              "iPhone8": .iPhone8(orientation),
                                              "iPhoneSe": .iPhoneSe(orientation)]

    let results = devices.map { device in
      verifySnapshot(matching: viewController,
                     as: .image(on: device.value),
                     named: "\(named)-\(device.key)",
                     record: isRecordingMode,
                     file: file,
                     testName: testName,
                     line: line)
    }

    results.forEach { XCTAssertNil($0, file: file, line: line) }
  }
}
