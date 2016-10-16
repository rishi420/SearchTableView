//
//  SearchTableView.swift
//  Genops
//
//  Created by Warif Akhand Rishi on 4/11/16.
//  Copyright © 2016 Genweb2. All rights reserved.
//

import UIKit

public protocol SearchTableViewDataSource : NSObjectProtocol {
    func searchPropertyName() -> String
}

class SearchTableView : UITableView {

    var itemList : [AnyObject] {
        get {
            return getDataSource()
        } set {
            items = newValue
        }
    }
    
    var searchDataSource: SearchTableViewDataSource?
    
    fileprivate var items = [AnyObject]()
    
    fileprivate var searchProperty : String {
        
        guard let searchDataSource = searchDataSource else {
            return ""
        }
        
        return searchDataSource.searchPropertyName()
    }
    
    fileprivate var filteredItems = [AnyObject]()
    fileprivate let searchController = UISearchController(searchResultsController: .none)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup() {
        DispatchQueue.main.async { () -> Void in
            self.searchController.dimsBackgroundDuringPresentation = false
            self.searchController.searchResultsUpdater = self
            self.searchController.searchBar.sizeToFit()
            self.tableHeaderView = self.searchController.searchBar
            let contentOffset = CGPoint(x: 0.0, y: self.contentOffset.y + self.searchController.searchBar.frame.height)
            self.setContentOffset(contentOffset, animated: false)
        }
    }
    
    fileprivate func getDataSource() -> [AnyObject] {
        return (searchController.isActive) ? filteredItems : items
    }
}

extension SearchTableView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // Update the filtered array based on the search text.
        let searchResults = items
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Build all the "AND" expressions for each value in the searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            // Each searchString creates an OR predicate for: name, yearIntroduced, introPrice.
        
            var searchItemsPredicate = [NSPredicate]()
            
            // Below we use NSExpression represent expressions in our predicates.
            // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value).
            
            // Name field matching.
            let titleExpression = NSExpression(forKeyPath: searchProperty)
            let searchStringExpression = NSExpression(forConstantValue: searchString)
            
            let titleSearchComparisonPredicate = NSComparisonPredicate(leftExpression: titleExpression, rightExpression: searchStringExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
            
            searchItemsPredicate.append(titleSearchComparisonPredicate)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .none
            numberFormatter.formatterBehavior = .default
            
            // Add this OR predicate to our master AND predicate.
            let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates:searchItemsPredicate)
            
            return orMatchPredicate
        }
        
        // Match up the fields of the Product object.
        let finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }
        
        // Hand over the filtered results to our search results table.
        //let resultsController = searchController.searchResultsController as! ProjectListViewController
        filteredItems = filteredResults
        reloadData()
    }
}
