# SearchTableView
UITableView subclass to easily search on tableView. Example project included.

<p align="center"><img src="https://cloud.githubusercontent.com/assets/2233857/14847654/96432252-0c8b-11e6-9fa0-1a7843d20ec3.gif"/></p>

## Features
- [x] At first searchBar will be hidded. As user drag tableVeiw down, s/he'll see the the searchBar.
- [x] Orientation support

## Installation
Just drag and drop `SearchTableView.swift` file in your project

## Usage
Steps:
 1. Change `UITableView` class to `SearchTableView` in storyBoard.
 2. Make an `@IBOutlet` of `SearchTableView` in your viewController
 3. Conform to `searchDataSource` protocol
 4. Assign array or objects in `itemList`
 5. Return `itemList.count` in numberOfRowsInSection
 6. Implement `searchPropertyName()` of `SearchTableViewDataSource` protocol
 7. return `itemList` objects' `property` name you want to search for.

## Known Issue
There is an issue of searchBar overlaps statusBar. Steps to reproduce this issue:
 1. Users search  
 2. Tap on any search result
 3. Navigate to another viewController 
 4. Then change device orientation
 5. Back

This could be an apple bug. Apple sample code also has this issue <br>
 https://developer.apple.com/library/ios/samplecode/TableSearch_UISearchController/Introduction/Intro.html
