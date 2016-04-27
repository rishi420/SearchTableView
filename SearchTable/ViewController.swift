//
//  ViewController.swift
//  SearchTable
//
//  Created by Warif Akhand Rishi on 4/27/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTableView: SearchTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.layoutMargins = UIEdgeInsetsZero
        searchTableView.separatorInset = UIEdgeInsetsZero
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        searchTableView.searchDataSource = self
        
        searchTableView.itemList = createProjectList()
    }

    private func createProjectList() -> [Project] {
        var projectList = [Project]()
        for i in 0..<30 {
            projectList.append(Project(projectId: i+1, name: "Project \(i+1)"))
        }
        return projectList
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTableView.itemList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProjectListCell", forIndexPath: indexPath)
        let project = searchTableView.itemList[indexPath.row] as! Project
        cell.textLabel?.text = project.name
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
}

extension ViewController : SearchTableViewDataSource {
    
    func searchPropertyName() -> String {
        return "name"
    }
}

