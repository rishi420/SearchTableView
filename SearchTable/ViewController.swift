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
        
        searchTableView.layoutMargins = UIEdgeInsets.zero
        searchTableView.separatorInset = UIEdgeInsets.zero
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        searchTableView.searchDataSource = self
        
        searchTableView.itemList = createProjectList()
    }

    fileprivate func createProjectList() -> [Project] {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTableView.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath)
        let project = searchTableView.itemList[(indexPath as NSIndexPath).row] as! Project
        cell.textLabel?.text = project.name
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
}

extension ViewController : SearchTableViewDataSource {
    
    func searchPropertyName() -> String {
        return "name"
    }
}

