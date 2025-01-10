//
//  IngredientsViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

class IngredientsViewController: UIViewController {
    
    private var ingredientsView: IngredientsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// IngredientsView 초기화
        ingredientsView = IngredientsView(frame: self.view.bounds)
        self.view = ingredientsView
        print("IngredientsViewController")
        
        // Do any additional setup after loading the view.
    }
    
}
