//
//  ViewControllerForm.swift
//  WKWebViewLocal
//
//  Created by Lucy on 16/06/21.
//  Copyright © 2021 Mellowmuse. All rights reserved.
//

import UIKit
import Eureka

class ViewControllerForm: FormViewController {
    var model: [ModelForm] = [ModelForm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        UtilsData.shared.getDataForm()
        UtilsData.shared.getDataPlan()
        LabelRow.defaultCellUpdate = { cell, _ in
            cell.contentView.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            cell.textLabel?.textAlignment = .right

        }

        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }

        form
            +++ Section(header: "Required Name", footer: "")

            <<< TextRow {
                $0.title = "Name"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleMinLength(minLength: 4))
                $0.validationOptions = .validatesOnChange
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                } else {
                    if let str = cell.textField.text {
                        UtilsData.shared.modelForms[0].strName = str
                    }

                }
            }
            .onRowValidationChanged { cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow {
                            $0.title = validationMsg
                            $0.cell.height = { 30 }
                        }
                        let indexPath = row.indexPath!.row + index + 1
                        row.section?.insert(labelRow, at: indexPath)
                    }
                }
            }

            <<< IntRow {
                $0.title = "Age"
                $0.add(rule: RuleRequired())

                $0.add(rule: RuleGreaterThan(min: 1))
                $0.add(rule: RuleSmallerThan(max: 100))
                $0.validationOptions = .validatesOnChange
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                } else {
                    if let str = cell.textField.text {
                        UtilsData.shared.modelForms[0].strAge = str
                    }

                }
            }
            .onRowValidationChanged { cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow {
                            $0.title = validationMsg
                            $0.cell.height = { 30 }
                        }
                        let indexPath = row.indexPath!.row + index + 1
                        row.section?.insert(labelRow, at: indexPath)
                    }
                }
            }

            +++ Section()
            <<< ButtonRow {
                $0.title = "show pdf"
            }
            .onCellSelection { _, row in
                if row.section?.form?.validate().count ?? 1 > 0 {
                    print("ERROR")
                } else {
                    print("NotERROR")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    vc.strName = UtilsData.shared.modelForms[0].strName
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }

    }

}
