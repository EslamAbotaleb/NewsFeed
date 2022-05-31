//
//  News+CoreDataProperties.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 01/06/2022.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var titleNews: String?
    @NSManaged public var descriptionNews: String?
    @NSManaged public var image: String?

}

extension News : Identifiable {

}
