//
//  SendPhotoTableViewCell.swift
//  UpaxTest
//
//  Created by Alan on 16/11/21.
//

import UIKit

protocol SendPhotoTableViewCellDelegate: AnyObject {
    func sendData()
}

final class SendPhotoTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SendPhotoTableViewCell.self)
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.layer.cornerRadius = 8
        button.setTitle("Send data", for: .normal)
        button.addTarget(self, action: #selector(sendData), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: SendPhotoTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryView = .none
        contentView.addSubview(sendButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func sendData() {
        delegate?.sendData()
    }
}
