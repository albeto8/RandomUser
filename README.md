# Random User App

## Targets

App is divided in three targets:

1.  **UserFeature:** Contains User model, network client for downloading data and images and JSON Parsing. 
2.  **RandomUseriOS:** Contains ViewModels, Controller and View
3.  **RandomUser:** Main app that composes **UserFeature** and **RandomUseriOS** modules

![](/targets.png)

## Tests

![](/tests.png)

## External libraries

- SnapshotTesting for testing UI

https://github.com/pointfreeco/swift-snapshot-testing

## Snapahot tests

Snapshots were recorded using **Xcode Version 12.5.1** and **iPod touch (7th generation)** simulator. Tests will fail when running them with different simulator or different Xcode version.

Light Mode             |  Dark Mode
:-------------------------:|:-------------------------:
![](/RandomUseriOSTests/Profile%20UI/__Snapshots__/ProfileSnapshotTests/test_profileWithContent.light-iPhoneX.png)  |  ![](/RandomUseriOSTests/Profile%20UI/__Snapshots__/ProfileSnapshotTests/test_profileWithContent.dark-iPhoneX.png)

## Random User App Architecture

![imagen](/RandomUserArchitecture.png)
