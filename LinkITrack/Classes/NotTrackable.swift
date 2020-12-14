//
//  NotTrackable.swift
//  LinkITrack
//
//  Created by Linkit on 12/12/20.
//

import Foundation

class NotTrackable: UIView {
    let kCONTENT_XIB_NAME = "NotTrackable"
    
    @IBOutlet var lblNotTrackable: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public func setLabel(label: String) {
        DispatchQueue.main.async {
            self.lblNotTrackable.text = label;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        lblNotTrackable.fixInView(self)
        lblNotTrackable.text = "Your order is not yet trackable."
        lblNotTrackable.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

extension UILabel
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
