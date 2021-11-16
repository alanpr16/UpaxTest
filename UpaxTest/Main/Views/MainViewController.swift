//
//  MainViewController.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import UIKit

final class MainViewController: UIViewController, UINavigationControllerDelegate {
    
    lazy var tableView: UITableView = {
        let tableView = AutosizingTableView()
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.reuseIdentifier)
        tableView.register(PictureTableViewCell.self, forCellReuseIdentifier: PictureTableViewCell.reuseIdentifier)
        tableView.register(GraphsTableViewCell.self, forCellReuseIdentifier: GraphsTableViewCell.reuseIdentifier)
        tableView.register(SendPhotoTableViewCell.self, forCellReuseIdentifier: SendPhotoTableViewCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    var imagePicker: UIImagePickerController!
    lazy var mainPresenter: MainPresenter = MainPresenter(delegate: self)
    
    override func loadView() {
        super.loadView()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: guide.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 300
        default:
            return 50
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.reuseIdentifier,
                                                         for: indexPath) as? NameTableViewCell else {
                    return UITableViewCell()
                }
            cell.delegate = self
            return cell
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: PictureTableViewCell.reuseIdentifier,
                                                         for: indexPath) as? PictureTableViewCell else {
                    return UITableViewCell()
                }
            cell.imageSelected.image = mainPresenter.image
            cell.delegate = self
            return cell
        case 2:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: GraphsTableViewCell.reuseIdentifier,
                                                         for: indexPath) as? GraphsTableViewCell else {
                    return UITableViewCell()
                }
            cell.delegate = self
            return cell
        case 3:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: SendPhotoTableViewCell.reuseIdentifier,
                                                         for: indexPath) as? SendPhotoTableViewCell else {
                    return UITableViewCell()
                }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: PictureTableViewCellDelegate {
    func goToImage() {
        showAlert()
    }
}

extension MainViewController: GraphsTableViewCellDelegate {
    func goToGraph() {
        mainPresenter.goToGraphs()
    }
}

extension MainViewController: MainPresenterDelegate {
    func goToGraphs(presenter: GraphsPresenter) {
        let viewController = GraphsViewController(presenter: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showDataAlert() {
        let alert = UIAlertController(title: "Alert", message: "Add name and select/take a photo", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: NameTableViewCellDelegate {
    func sendName(name: String) {
        mainPresenter.name = name
    }
}

extension MainViewController: SendPhotoTableViewCellDelegate {
    func sendData() {
        mainPresenter.validateData()
    }
}

extension MainViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.selectImageFrom(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.selectImageFrom(.photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectImageFrom(_ source: ImageSource) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
}

extension MainViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        mainPresenter.image = selectedImage
        tableView.reloadData()
    }
}
