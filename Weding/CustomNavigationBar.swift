//
//  CustomNavigationBar.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {
    
    @IBOutlet weak var titleNavigation: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    
    var callBack = {}
    var closure = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        return view!
    }
    
    private func setUpTitle(title: String!) {
        titleNavigation.text = title
    }
    
    @IBAction func pressedLeftItem(_ sender: Any) {
        self.callBack()
    }
    
    @IBAction func pressedRightItem(_ sender: Any) {
        print("right")
    }
 
}
