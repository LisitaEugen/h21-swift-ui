//
//  Habit.swift
//  H21
//
//  Created by Evgheni Lisita on 17.09.19.
//  Copyright © 2019 Evgheni Lisita. All rights reserved.
//

import Foundation
import CoreData

//extension Habit {
//    enum Fields: String {
//        case color
//        case creationDate
//        case title
//        case motivation
//        case firebaseId
//    }
//    
//    convenience init(context: NSManagedObjectContext, dictionary: NSDictionary) {
//        self.init(context: context)
//        
//        self.color = (dictionary[Fields.color.rawValue] as? Int32) ?? 0
//        self.title = dictionary[Fields.title.rawValue] as? String
//        self.motivation = dictionary[Fields.motivation.rawValue] as? String
//        self.firebaseId = dictionary[Fields.firebaseId.rawValue] as? String
//        let creationDateRow = dictionary[Fields.creationDate.rawValue] as? String
//        self.creationDate = Date.date(fromString: creationDateRow ?? "", withFormat: FBCloud.firebaseDateFormat) ?? Date()
//        
//    }
//    
//    func isAchievementEnabled(forDate date: Date) -> Bool {
//        if let achievements = self.achievements,
//            let achievementsArray = achievements.array as? [Achievement] {
//            for achievement in achievementsArray {
//                if achievement.date == date {
//                    return true
//                }
//            }
//        }
//        
//        return false
//    }
//    
//    func getProgressPercentage() -> Int {
//        if let achievements = self.achievements,
//            let achievementsArray = achievements.array as? [Achievement] {
//            
//            return Int((Double(achievementsArray.count) / 21.0) * 100.0)
//        }
//        
//        return 0
//    }
//    
//    
//}
//
//extension NSManagedObject {
//    
//    
//    func toDict() -> [String:Any] {
//        let keys = Array(entity.attributesByName.keys)
//        return dictionaryWithValues(forKeys:keys)
//    }
//    
//    func toDictionary() -> [String: Any] {
//        let dictionary = toDict()
//        let transformedDict = dictionary.mapValues { value -> Any in
//            if value is Date {
//                let date = value as? Date
//                
//                return Date.getFormattedDate(date: date ?? Date(), format: FBCloud.firebaseDateFormat)
//            }
//            
//            return value
//        }
//        
//        
//        return transformedDict
//    }
//}


