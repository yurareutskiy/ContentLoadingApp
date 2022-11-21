//
//  ViewController.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import UIKit
import SwiftUI


class TabBarViewController: UITabBarController {

    let commentService = CommentService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let commentsView = UIHostingController(rootView: CommentsView().environmentObject(commentService))
        commentsView.tabBarItem = UITabBarItem(title: "Comments", image: UIImage(systemName: "text.bubble"), selectedImage: UIImage(systemName: "text.bubble.fill"))
        
        let numberGeneratorView = UIHostingController(rootView: NumberGeneratorView())
        numberGeneratorView.tabBarItem = UITabBarItem(title: "Numbers", image: UIImage(systemName: "number.square"), selectedImage: UIImage(systemName: "number.square.fill"))
        viewControllers = [commentsView, numberGeneratorView]
    }
}
