//
//  MonitorViewController.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation
//import CCProgressHUDKit

class MonitorController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.niceBlack()
        
        self.view.addSubview(self.containerView)
        self.containerView.delegateContainer = self;
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.containerView.frame = self.view.bounds
    }
    
    private var containerView = MonitorContainerView()
}

extension MonitorController: MonitorContainerViewDelegate {
    func container(container:MonitorContainerView, didSelectedType type:MonitorSystemType) {
        
        //UIAlertView.quickTip(message: "detail and historical data coming soon")
        let alert = UIAlertController.init(title: "提示", message: "detail and historical data coming soon", preferredStyle: UIAlertControllerStyle.alert)
         alert.addAction(UIAlertAction.init(title: "好", style: UIAlertActionStyle.cancel, handler: { (alertaction) in
             
         }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        ///MBProgressHUD.showSuccess("detail and historical data coming soon")
        if type.hasDetail {
            //TODO: add detail
            
        }
    }
}

