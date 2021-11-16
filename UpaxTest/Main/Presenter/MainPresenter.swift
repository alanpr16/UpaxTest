//
//  MainPresenter.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import Foundation
import UIKit
import FirebaseStorage

protocol MainPresenterDelegate: AnyObject {
    func goToGraphs(presenter: GraphsPresenter)
    func showDataAlert()
}

final class MainPresenter {
    
    weak var delegate: MainPresenterDelegate?
    
    private let storage = Storage.storage().reference()
    
    var image: UIImage?
    var name: String?
    
    init(delegate: MainPresenterDelegate) {
        self.delegate = delegate
    }
    
    func goToGraphs() {
        let presenter = GraphsPresenter()
        delegate?.goToGraphs(presenter: presenter)
    }
    
    func validateData() {
        if image != nil && name != nil {
            sendData()
        } else {
            delegate?.showDataAlert()
        }
    }
    
    private func sendData() {
        guard let name = name, let imageData = image?.pngData() else { return }
        
        storage.child("\(name)/file.png").putData(imageData,
                                                 metadata: nil,
                                                 completion: { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
        })
    }
}
