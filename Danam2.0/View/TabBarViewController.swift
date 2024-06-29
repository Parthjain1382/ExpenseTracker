//
//  TabBarViewController.swift
//  Danam2.0
//
//  Created by E5000846 on 29/06/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    static let identifier = "TabBarViewController"
        
    var userData: (email: String, uid: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data ",userData?.uid)
        // Do any additional setup after loading the view.
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
