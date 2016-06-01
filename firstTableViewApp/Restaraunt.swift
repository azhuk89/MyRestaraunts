//
//  Restaraunt.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/8/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import Foundation
import CoreData

class Restaraunt: NSManagedObject {
    @NSManaged var name: String!
    @NSManaged var type: String!
    @NSManaged var location: String!
    @NSManaged var image: NSData!
    @NSManaged var isVisited: NSNumber!
}