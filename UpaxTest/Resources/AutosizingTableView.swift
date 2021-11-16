//
//  AutosizingTableView.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import UIKit

final class AutosizingTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return .init(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
