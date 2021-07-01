//
//  ModelForm.swift
//  WKWebViewLocal
//
//  Created by Lucy on 17/06/21.
//  Copyright © 2021 Mellowmuse. All rights reserved.
//

import Foundation

struct ModelForm: Codable {
    var strAge: String
    var strAgeOwner: String
    var strName: String
    var strGender: String
    var strNameOwner: String
    var strGenderOwner: String
    var strFrequencyPremi: String
    var strBackDate: String
    var strCountry: String
    var strCurrency: String
    var strSmoker: String
    var strOccupation: String
    var dictionary: [String: Any] {
        return
            [
                "age": strAge,
                "name": strName,
                "gender": strGender,
                "ageOwner": strAgeOwner,
                "nameOwner": strNameOwner,
                "genderOwner": strGenderOwner,
                "backDate": strBackDate,
                "frequency": strFrequencyPremi,
                "country": strCountry,
                "currency": strCurrency,
                "smoker": strSmoker,
                "occupation": strOccupation
            ]
    }

    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }

    enum CodingKeys: String, CodingKey {
        case strAge = "age"
        case strAgeOwner = "ageOwner"
        case strName = "name"
        case strGender = "gender"
        case strNameOwner = "nameOwner"
        case strGenderOwner = "genderOwner"
        case strFrequencyPremi = "frequency"
        case strBackDate = "backDate"
        case strCountry = "country"
        case strCurrency = "currency"
        case strSmoker = "smoker"
        case strOccupation = "occupation"
    }

}

struct ModelPlan: Codable {
    var strName: String
    var strCode: String
    var strClassification: String
    var strAmount1: String
    var strAmount2: String
    var strTermYears: String
    var strValue1: String
    var strValue2: String
    var strValue3: String
    var strValue4: String

    enum CodingKeys: String, CodingKey {
        case strName = "name"
        case strCode = "code"
        case strClassification = "classification"
        case strAmount2 = "amount2"
        case strAmount1 = "amount1"
        case strTermYears = "termYears"
        case strValue1 = "value1"
        case strValue2 = "value2"
        case strValue3 = "value3"
        case strValue4 = "value4"

    }
}
