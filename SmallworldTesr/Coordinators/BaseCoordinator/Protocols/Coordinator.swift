//
//  Coordinator.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}
