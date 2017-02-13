//
//  CTFReduxStore.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/12/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ReSwift

struct CTFReduxStore: StateType {
    var activityQueue: [(UUID, CTFActivityRun)] = []
}

struct QueueActivityAction: Action {
    let uuid: UUID
    let activityRun: CTFActivityRun
}

struct CompleteActivityAction: Action {
    let uuid: UUID
}

struct ActivityQueueReducer: Reducer {
    
    func handleAction(action: Action, state: CTFReduxStore?) -> CTFReduxStore {
        var state = state ?? CTFReduxStore()
        
        switch action {
        case let queueActivityAction as QueueActivityAction:
            state.activityQueue = state.activityQueue + [(queueActivityAction.uuid, queueActivityAction.activityRun)]
        case let completeActivityAction as CompleteActivityAction:
            state.activityQueue = state.activityQueue.filter({ (uuid: UUID, _) -> Bool in
                return uuid != completeActivityAction.uuid
            })
            
        default:
            break
        }
        
        return state
    }
    
}

class CTFReduxStoreManager: NSObject {
    
    static let sharedInstance = CTFReduxStoreManager()
    static let mainStore = sharedInstance.store
    
    let store: Store<CTFReduxStore>
    
    private override init() {
        
        self.store = Store<CTFReduxStore>(
            reducer: ActivityQueueReducer(),
            state: nil
        )
        
        super.init()
        
    }
    
}


