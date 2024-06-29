//
//  LoginCredentialsDelegate.swift
//  Danam2.0
//
//  Created by E5000846 on 29/06/24.
//

import Foundation

protocol LoginCredentialsDelegate: AnyObject {
  func dataToPass(_ data: (String , String))
}
