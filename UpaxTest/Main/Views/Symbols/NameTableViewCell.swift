//
//  NameTableViewCell.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import UIKit

protocol NameTableViewCellDelegate: AnyObject {
    func sendName(name: String)
}

final class NameTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: NameTableViewCell.self)
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.delegate = self
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryView = .none
        contentView.addSubview(nameTextField)
    }
    
    weak var delegate: NameTableViewCellDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension NameTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil, string.count >= 2 {
                return false
            }
        }
        catch {
            print("Error")
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let name = textField.text else { return }
        delegate?.sendName(name: name)
    }
}
