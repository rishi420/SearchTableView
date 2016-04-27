//
//  Project.swift
//  SearchTable
//
//  Created by Warif Akhand Rishi on 4/27/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

import Foundation

class Project: NSObject {
    
    var projectId: Int
    var name: String
    
    init(projectId: Int, name: String) {
        self.projectId = projectId
        self.name = name
    }
}
