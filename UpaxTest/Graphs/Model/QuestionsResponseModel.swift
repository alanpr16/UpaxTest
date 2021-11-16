//
//  Questions.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

struct ServiceResponseModel: Decodable {
    let colors: [String]
    let questions: [QuestionResponseModel]
}

struct QuestionResponseModel: Decodable {
    let total: Int
    let text: String
    let chartData: [ChartDataResponseModel]
}

struct ChartDataResponseModel: Decodable {
    let text: String
    let percetnage: Int
}

extension QuestionResponseModel {
    func mapToModel() -> Question {
        Question(total: total,
                 text: text,
                 chartData: chartData.map { $0.mapToModel() } )
    }
}

extension ChartDataResponseModel {
    func mapToModel() -> ChartData {
        ChartData(text: text,
                  percetnage: percetnage)
    }
}
