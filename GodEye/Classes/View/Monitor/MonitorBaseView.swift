//
//  MonitorPercentView.swift
//  Pods
//
//  Created by zixun on 17/1/5.
//
//

import Foundation
import SystemEye

func dispatch_async_safely_to_main_queue(_ block: @escaping ()->()) {
    dispatch_async_safely_to_queue(DispatchQueue.main, block)
}

// This methd will dispatch the `block` to a specified `queue`.
// If the `queue` is the main queue, and current thread is main thread, the block
// will be invoked immediately instead of being dispatched.
func dispatch_async_safely_to_queue(_ queue: DispatchQueue, _ block: @escaping ()->()) {
    if queue === DispatchQueue.main && Thread.isMainThread {
        block()
    } else {
        queue.async {
            block()
        }
    }
}


enum MonitorBaseViewPosition {
    case left
    case right
}

class MonitorBaseView: UIButton {

    var position:MonitorBaseViewPosition = .left
    
    var firstRow:Bool = true
    
    private(set) var type: MonitorSystemType!
    
    init(type:MonitorSystemType) {
        
        super.init(frame: CGRect.zero)
        self.type = type
        self.infoLabel.text = type.info
        self.contentLabel.text = type.initialValue
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.rightLine)
        self.addSubview(self.topLine)
        
        self.addSubview(self.infoLabel)
        self.addSubview(self.contentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rect = self.bounds
        rect.origin.x = rect.size.width - 0.5
        rect.size.width = 0.5
        rect.origin.y = 20
        rect.size.height -= rect.origin.y * 2
        self.rightLine.frame = self.position == .left ? rect : CGRect.zero
        
        rect.origin.x = self.position == .left ? 20 : (self.firstRow ? 0 : 20)
        rect.origin.y = 0
        rect.size.width = self.frame.size.width - (self.firstRow ? 20 : 40)
        rect.size.height = 0.5
        self.topLine.frame = rect
        
        
        rect.size.height = 50
        rect.origin.x = 20
        rect.size.width = self.frame.size.width - rect.origin.x - 20
        rect.origin.y = (self.frame.size.height - rect.size.height) / 2
        self.contentLabel.frame = rect
        
        rect.origin.x = 20
        rect.origin.y = 10
        rect.size.width = self.frame.size.width - 20
        rect.size.height = 12
        self.infoLabel.frame = rect
    }
    
    fileprivate lazy var contentLabel: UILabel = {
        let new = UILabel()
        new.text = "Unknow"
        new.textColor = UIColor.white
        new.textAlignment = .right
        new.numberOfLines = 0
        new.font = UIFont(name: "HelveticaNeue-UltraLight", size: 32)
        return new
    }()
    
    private(set) lazy var infoLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.systemFont(ofSize: 12)
        new.textColor = UIColor.white
        return new
    }()
    
    private lazy var rightLine: UIView = {
        let new = UIView()
        new.backgroundColor = UIColor.white
        return new
    }()
    
    private lazy var topLine: UIView = {
        let new = UIView()
        new.backgroundColor = UIColor.white
        return new
    }()
}


// MARK: - Tool
extension MonitorBaseView {
    fileprivate func attributes(size:CGFloat) -> [NSAttributedStringKey : Any] {
        return [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue-UltraLight", size: size) as Any,
                NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    
    fileprivate func contentString(_ string:String,unit:String) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: string, attributes: self.attributes(size: 32)))
        result.append(NSAttributedString(string: unit, attributes: self.attributes(size: 16)))
        return result
    }
}


// MARK: - Byte
extension MonitorBaseView {
    
    
    func configure(byte:Double) {
        let str = byte.storageCapacity()
        weak var weakSelf = self
        dispatch_async_safely_to_main_queue {
            guard let strongSelf = weakSelf else { return }
            strongSelf.contentLabel.attributedText = self.contentString(String.init(format: "%.1f", str.capacity), unit: str.unit)
        }
        
    }
}


// MARK: - Percent
extension MonitorBaseView {
    func configure(percent:Double) {
        weak var weakSelf = self
        dispatch_async_safely_to_main_queue {
            guard let strongSelf = weakSelf else { return }
            strongSelf.contentLabel.attributedText = self.contentString(String.init(format: "%.1f", percent), unit: "%")
        }
        
    }
}

extension MonitorBaseView {
    func configure(fps: Double) {
        weak var weakSelf = self
        dispatch_async_safely_to_main_queue {
            guard let strongSelf = weakSelf else { return }
            strongSelf.contentLabel.attributedText = self.contentString(String.init(format: "%.1f", fps), unit: "FPS")
        }
        
    }
}
