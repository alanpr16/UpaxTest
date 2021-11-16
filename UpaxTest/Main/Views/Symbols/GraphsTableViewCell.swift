//
//  GraphsTableViewCell.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//
import UIKit

protocol GraphsTableViewCellDelegate: AnyObject {
    func goToGraph()
}

final class GraphsTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: GraphsTableViewCell.self)
    
    weak var delegate: GraphsTableViewCellDelegate?
    
    lazy var descriptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 8
        button.setTitle("Go to Graphs", for: .normal)
        button.addTarget(self, action: #selector(goToGraphs), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryView = .none
        contentView.addSubview(descriptionButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            descriptionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            descriptionButton.heightAnchor.constraint(equalToConstant: 40),
            descriptionButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func goToGraphs() {
        delegate?.goToGraph()
    }
}
