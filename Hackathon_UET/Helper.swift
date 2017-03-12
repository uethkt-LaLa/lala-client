//
//  Helper.swift
//  Kinly
//
//  Created by Tuan Vu on 12/22/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

import UIKit
import Contacts





class Helper: NSObject {
    
    
    class func hour(date : Date) -> Int
    {
        let cal = Calendar.current
        let components = cal.dateComponents([.year , .month , .day , .hour , .minute], from: date)
        return components.hour!
    }
    class func min(date : Date) -> Int
    {
        let cal = Calendar.current
        let components = cal.dateComponents([.year , .month , .day , .hour , .minute], from: date)
        return components.minute!
    }
    
    class func month(date : Date) -> Int
    {
        let cal = Calendar.current
        let components = cal.dateComponents([.year , .month , .day], from: date)
        return components.month!
    }
    class func year(date : Date) -> Int
    {
        let cal = Calendar.current
        let components = cal.dateComponents([.year , .month , .day], from: date)
        return components.year!
    }
    class func day(date : Date) -> Int
    {
        let cal = Calendar.current
        let components = cal.dateComponents([.year , .month , .day], from: date)
        return components.day!
    }
    
    class func weekday(date : Date) -> String
    {
        let weekdays : [String] = ["SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY"]
        let cal = Calendar.current
        let components = cal.dateComponents([.weekday], from: date)
        return weekdays[components.weekday!-1]
    }
    
    
    class func dateDictionaryWithDate(_ date : Date) -> [String : Int]
    {
        var dict :[String : Int] = Dictionary()
        dict["day"] = Helper.day(date: date)
        dict["month"] = Helper.month(date:date)
        dict["year"] = Helper.year(date:date)
        
        return dict
    }
    
    class func dateStringbyDate(_ date : Date) -> String
    {
        return String(Helper.day(date: date)) + "-" + String(Helper.month(date:date)) + "-" + String(Helper.year(date:date))
    }
    
    class func headerDateEventCalendar(_ date : Date) -> String
    {
        let monthly : [String] = ["Jan",
                                  "Feb",
                                  "Mar",
                                  "Apr",
                                  "May",
                                  "Jun",
                                  "Jul",
                                  "Aug",
                                  "Sep",
                                  "Oct",
                                  "Nov",
                                  "Dec"];
        
        return String(Helper.day(date: date)) + " " + String(monthly[Helper.month(date:date)-1]) + " " + String(Helper.year(date:date))
        
        
        
    }
    
    class func sortFunc(num1: Int, num2: Int) -> Bool {
        return num1 < num2
    }
    
    class func sortMonthly(month1 : String , month2: String) -> Bool
    {
        let com1 = month1.components(separatedBy: "-")
        let com2 = month2.components(separatedBy: "-")
        
        let com1Weight = Int(com1[0])! + Int(com1[1])!
        let com2Weight = Int(com2[0])! + Int(com2[1])!
        
        return com1Weight < com2Weight
        
    }
    
    class func monthFormattedWithInt(_ month : Int) -> String
    {
        let monthly : [String] = ["Jan",
                                  "Feb",
                                  "Mar",
                                  "Apr",
                                  "May",
                                  "Jun",
                                  "Jul",
                                  "Aug",
                                  "Sep",
                                  "Oct",
                                  "Nov",
                                  "Dec"];
        return monthly[month-1]
    }
    
    class func milisecondsToDateTime( miliSecs : UInt64) -> Date
    {
        let timeInSeconds = Double(miliSecs) / 1000
        // get the Date
        let dateTime = Date(timeIntervalSince1970: timeInSeconds)
        return dateTime
    }
    
    class func dateToMiliSecs(date : Date) -> UInt64
    {
        return UInt64(NSDate().timeIntervalSince1970*1000)
    }
    
    


    
    class func getAllContact() -> Array<String>
    {
        var result : [String] = []
        let contactStore = CNContactStore()
//        var contacts = [CNContact]()
        let keys = [CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                
                for ContctNumVar: CNLabeledValue in contact.phoneNumbers
                {
                    let FulMobNumVar  = ContctNumVar.value as! CNPhoneNumber
                    let MccNamVar = FulMobNumVar.value(forKey: "countryCode") as? String
                    let MobNumVar = FulMobNumVar.value(forKey: "digits") as? String
                    
                    result.append(MobNumVar!)
                    print("phone number get from contcats \(MccNamVar!)")
                    print("phone number get from contcats \(MobNumVar!)")
                }
  
            }
        }
        catch {
            print("unable to fetch contacts")
        }
        
        return result
    
    }
    
    

}
