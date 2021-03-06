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
    var strYear1: String
    var strYear2: String
    var strValue1: String
    var strValue2: String
    var strValue3: String
    var strValue4: String
    var dictionary: [String: Any] {
        return
            [
                "code": strCode,
                "name": strName,
                "classification": strClassification,
                "year1": strYear1,
                "year2": strYear2,
                "amount2": strAmount2,
                "amount1": strAmount1,
                "value1": strValue1,
                "value2": strValue2,
                "value3": strValue3,
                "value4": strValue4
            ]
    }
    enum CodingKeys: String, CodingKey {
        case strName = "name"
        case strCode = "code"
        case strClassification = "classification"
        case strYear1 = "year1"
        case strYear2 = "year2"
        case strAmount2 = "amount2"
        case strAmount1 = "amount1"
        case strValue1 = "value1"
        case strValue2 = "value2"
        case strValue3 = "value3"
        case strValue4 = "value4"

    }
}
