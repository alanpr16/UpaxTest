//
//  QuestionViewData.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import SwiftUI

struct QuestionViewData {
    let question: String
    let options: [OptionsViewData]
}

struct OptionsViewData {
    let color: UIColor
    let option: String
    let percent: Int
}
