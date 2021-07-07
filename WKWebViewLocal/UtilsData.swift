//
//  UtilsData.swift
//  WKWebViewLocal
//
//  Created by Lucy on 30/06/21.
//  Copyright © 2021 Mellowmuse. All rights reserved.
//

import Foundation

class UtilsData: NSObject {
    static let shared = UtilsData()
    var modelForms: [ModelForm] = []
    var modelPlans: [ModelPlan] = []
    var currentIndex = 0
    var fm = FileManager.default
    var fresult: Bool = false
    var subUrlForm: URL?
    var mainUrlForm: URL? = Bundle.main.url(forResource: "form", withExtension: "json")
    var subUrlPlan: URL?
    var mainUrlPlan: URL? = Bundle.main.url(forResource: "plan", withExtension: "json")

    func writeToFileForms(location: URL) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let JsonData = try encoder.encode(modelForms)
            try JsonData.write(to: location)
        } catch {}
    }

    func getDataForm() {
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            subUrlForm = documentDirectory.appendingPathComponent("form.json")
            loadFileForm(mainPath: mainUrlForm!, subPath: subUrlForm!)
        } catch {
            print(error)
        }
    }

    func getDataPlan() {
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            subUrlPlan = documentDirectory.appendingPathComponent("plan.json")
            loadFilePlan(mainPath: mainUrlPlan!, subPath: subUrlPlan!)
        } catch {
            print(error)
        }
    }

    func loadFileForm(mainPath: URL, subPath: URL) {
        if fm.fileExists(atPath: subPath.path) {
            decodeDataForm(pathName: subPath)

            if modelForms.isEmpty {
                decodeDataForm(pathName: mainPath)
            }

        } else {
            decodeDataForm(pathName: mainPath)
        }

    }

    func loadFilePlan(mainPath: URL, subPath: URL) {
        if fm.fileExists(atPath: subPath.path) {
            decodeDataForm(pathName: subPath)

            if modelPlans.isEmpty {
                decodeDataPlan(pathName: mainPath)
            }

        } else {
            decodeDataPlan(pathName: mainPath)
        }

    }

    func decodeDataPlan(pathName: URL) {
        do {
            let jsonData = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            modelPlans = try decoder.decode([ModelPlan].self, from: jsonData)
            print("DATA Plan", modelPlans[0])

        } catch {
            print(error)
        }
    }
    func decodeDataForm(pathName: URL) {
        do {
            let jsonData = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            modelForms = try decoder.decode([ModelForm].self, from: jsonData)
            print("DATA Form", modelForms[0].strName)

        } catch {
            print(error)
        }
    }

    func saveToJsonFile(url: URL, data: AnyObject) {
        // Transform array into data and save it into file
        do {
            let data = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
            try data.write(to: url, options: [])
        } catch {
            print(error)
        }
    }

    func retrieveFromJsonFile(url: URL) {
        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: url, options: [])
            guard let personArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: [String: String]]] else { return }
            print(personArray) // prints [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]
        } catch {
            print(error)
        }
    }
}
