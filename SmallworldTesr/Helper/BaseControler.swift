//
//  BaseControler.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 22/10/2023.
//

import UIKit

class BaseControler: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkInternet()
    }
}
