//
//  CTFTabBarController.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/11/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit

class CTFTabBarController: UITabBarController {

    var appConfig: CTFAppConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appConfig = self.appConfig {
            self.loadFromAppConfig(appConfig: appConfig)
        }

        // Do any additional setup after loading the view.
    }
    
    private func loadFromAppConfig(appConfig: CTFAppConfig) {
        //get rid of all child view controllers
        self.viewControllers = nil
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //add view controller for each page in app config
        let pageViewControllers = appConfig.pages.flatMap { (page) -> UIViewController? in
            
            guard let vc = storyboard.instantiateViewController(withIdentifier: "activities_scene") as? CTFActivitiesViewController else {
                
                return nil
                
            }
            
            vc.activityFileName  = page.activityFileName
            vc.navigationItem.title = page.title
            
            let navVC = UINavigationController(rootViewController: vc)
            navVC.tabBarItem.title = page.shortTitle ?? page.title
            
            return navVC
            
        }
        
        //add settings view controllers
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "settings_scene")
        
        self.viewControllers = pageViewControllers + [settingsVC]
    }

}
