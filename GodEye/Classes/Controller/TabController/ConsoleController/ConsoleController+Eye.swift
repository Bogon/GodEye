//
//  ConsoleViewController+Eye.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation
import ASLEye
import CrashEye
import NetworkEye
import ANREye
import Log4G
import LeakEye

extension ConsoleController {
    
    /// open god's eyes
    func openEyes() {
        EyesManager.shared.delegate = self
        
        let defaultSwitch = GodEyeController.shared.configuration!.defaultSwitch
        if defaultSwitch.asl { EyesManager.shared.openASLEye() }
        if defaultSwitch.log4g { EyesManager.shared.openLog4GEye() }
        if defaultSwitch.crash { EyesManager.shared.openCrashEye() }
        if defaultSwitch.network { EyesManager.shared.openNetworkEye() }
        if defaultSwitch.anr { EyesManager.shared.openANREye() }
        if defaultSwitch.leak { EyesManager.shared.openLeakEye() }
    }
    
    func addRecord(model:RecordORMProtocol) {
        if let pc = self.printViewController {
            pc.addRecord(model: model)
        }else {
            
            weak var weakSelf = self
            dispatch_async_safely_to_main_queue {
                guard let strongSelf = weakSelf else { return }
                let type = Swift.type(of:model).type
                type.addUnread()
                strongSelf.reloadRow(of: type)
            }
            
        }
    }
}

extension ConsoleController: Log4GDelegate {
    
    fileprivate func openLog4GEye() {
        Log4G.add(delegate: self)
    }
    
    func log4gDidRecord(with model:LogModel) {
        
        weak var weakSelf = self
        let recordModel = LogRecordModel(model: model)
        recordModel.insert(complete: { (success:Bool) in
            guard let strongSelf = weakSelf else { return }
            strongSelf.addRecord(model: recordModel)
        })
    }
}

//MARK: - NetworkEye
extension ConsoleController: NetworkEyeDelegate {
    /// god's network eye callback
    func networkEyeDidCatch(with request:URLRequest?,response:URLResponse?,data:Data?) {
        Store.shared.addNetworkByte(response?.expectedContentLength ?? 0)
        let model = NetworkRecordModel(request: request, response: response as? HTTPURLResponse, data: data)
        weak var weakSelf = self
        model.insert(complete:  { (success:Bool) in
            guard let strongSelf = weakSelf else { return }
            strongSelf.addRecord(model: model)
        })
    }
}
//MARK: - CrashEye
extension ConsoleController: CrashEyeDelegate {
    
    /// god's crash eye callback
    func crashEyeDidCatchCrash(with model:CrashModel) {
        let model = CrashRecordModel(model: model)
        weak var weakSelf = self
        model.insertSync(complete: { (success:Bool) in
            
            guard let strongSelf = weakSelf else { return }
            strongSelf.addRecord(model: model)
        })
    }
}

//MARK: - ASLEye
extension ConsoleController: ASLEyeDelegate {
    
    
    
    /// god's asl eye callback
    public func aslEye(_ aslEye:ASLEye,catchLogs logs:[String]) {
        for log in logs {
            let model = LogRecordModel(type: .asl, message: log)
            weak var weakSelf = self
            model.insert(complete: { (success:Bool) in
                guard let strongSelf = weakSelf else { return }
                strongSelf.addRecord(model: model)
            })
        }
    }
}

extension ConsoleController: LeakEyeDelegate {
    
    public func leakEye(_ leakEye:LeakEye,didCatchLeak object:NSObject) {
        let model = LeakRecordModel(obj: object)
        weak var weakSelf = self
        model.insert { (success:Bool) in
             guard let strongSelf = weakSelf else { return }
            strongSelf.addRecord(model: model)
        }
    }
}

//MARK: - ANREye
extension ConsoleController: ANREyeDelegate {
    /// god's anr eye callback
    func anrEye(anrEye:ANREye,
                catchWithThreshold threshold:Double,
                mainThreadBacktrace:String?,
                allThreadBacktrace:String?) {
        let model = ANRRecordModel(threshold: threshold,
                                   mainThreadBacktrace: mainThreadBacktrace,
                                   allThreadBacktrace: allThreadBacktrace)
        weak var weakSelf = self
        model.insert(complete:  { (success:Bool) in
            guard let strongSelf = weakSelf else { return }
            strongSelf.addRecord(model: model)
        })
    }
}
