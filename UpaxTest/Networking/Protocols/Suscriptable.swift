//
//  Suscriptable.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import Foundation

protocol Subscriptable {
  associatedtype Name: Hashable
  subscript(index: Name) -> String { get set }
}
