//
//  RecipeDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/17/25.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    private var recipeDetailView: RecipeDetailView!
//    var recipe = RecipeModel(titleImage: String, recipeName: String)

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailView = RecipeDetailView(frame: self.view.bounds)
        self.view = recipeDetailView
        self.title = "한식 식사"
        if let backImage = UIImage(named: "Arrow3")?.withRenderingMode(.alwaysOriginal) {
            let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
