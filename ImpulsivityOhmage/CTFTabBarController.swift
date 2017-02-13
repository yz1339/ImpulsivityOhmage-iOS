//
//  CTFTabBarController.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/11/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ReSwift
import ResearchKit


class CTFTabBarController: UITabBarController, StoreSubscriber {

    var appConfig: CTFAppConfig?
    
    var presentedActivity: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appConfig = self.appConfig {
            self.loadFromAppConfig(appConfig: appConfig)
        }
        
        CTFReduxStoreManager.mainStore.subscribe(self)

        // Do any additional setup after loading the view.
    }
    
    deinit {
        CTFReduxStoreManager.mainStore.unsubscribe(self)
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
    
    func runActivity(uuid: UUID, activityRun: CTFActivityRun) {
        
        guard let steps = CTFTaskBuilderManager.sharedBuilder.steps(forElement: activityRun.activity) else {
                return
        }
        
        
        
        let task = ORKOrderedTask(identifier: activityRun.identifier, steps: steps)
        
        let taskFinishedHandler: ((ORKTaskViewController, ORKTaskViewControllerFinishReason, Error?) -> ()) = { [weak self] (taskViewController, reason, error) in
            
            if reason == ORKTaskViewControllerFinishReason.completed {
                
                let taskResult: ORKTaskResult = taskViewController.result
                
                if let resultTransforms = activityRun.resultTransforms {
                    CTFResultsProcessorManager.sharedResultsProcessor.processResult(taskResult: taskResult, resultTransforms: resultTransforms)
                }
                
            }
            
            self?.dismiss(animated: true, completion: {
                self?.presentedActivity = nil
                let action = CompleteActivityAction(uuid: uuid)
                CTFReduxStoreManager.mainStore.dispatch(action)
            })
            
        }
        
        let taskViewController = CTFTaskViewController(task: task, taskFinishedHandler: taskFinishedHandler)
        
        
        present(taskViewController, animated: true, completion: nil)
        
    }
    
    func newState(state: CTFReduxStore) {
    
        if self.presentedActivity == nil,
            let (uuid, activityRun) = state.activityQueue.first {
            
            self.runActivity(uuid: uuid, activityRun: activityRun)
            
        }
        
    }

}
