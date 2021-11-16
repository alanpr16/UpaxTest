//
//  GraphsPresenter.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import UIKit

protocol GraphsPresenterDelegate: AnyObject {
    func display(questions: [QuestionViewData])
}

final class GraphsPresenter {
    
    private let networkManager = ServicesManager()
    var questions: [Question] = []
    
    weak var delegate: GraphsPresenterDelegate?
    
    func setView(delegate: GraphsPresenterDelegate){
        self.delegate = delegate
    }
    
    func getInfoGraphs() {
        networkManager.getGraphsInfo { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                guard let questionsReceived = response?.questions else { return }
                guard let colors = response?.colors else { return }
                self.questions = questionsReceived.map { $0.mapToModel() }
                
                var questionsToShow: [QuestionViewData] = []
                
                for question in self.questions {
                    let options = question.chartData.enumerated().map { (index, option) in
                        OptionsViewData(color: UIColor(hex: colors[index]) ?? .blue,
                                        option: option.text,
                                        percent: option.percetnage)
                    }
                    questionsToShow.append(QuestionViewData(question: question.text,
                                                            options: options))
                    
                }
                
                self.delegate?.display(questions: questionsToShow)
            case .failure(let error):
                print(error)
            }
        }
    }
}
