//
//  GlobalSetting.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 6/8/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class GlobalSettings: NSObject {
    let mainColor = UIColor(displayP3Red: 31/255, green: 235/255, blue: 104/255, alpha: 1)
    let darkGreen = UIColor(displayP3Red: 0/255, green: 229/255, blue: 89/255, alpha: 0.8)
    let darkTitleGreen = UIColor(displayP3Red: 2/255, green: 180/255, blue: 66/255, alpha: 1)
    let lightGray = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    let darkGray = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
    private static var sharedGlobalSettings: GlobalSettings = {
        let globalSettings = GlobalSettings()
        return globalSettings
    }()
    class func shared() -> GlobalSettings {
        return sharedGlobalSettings
    }
    private func calculateFontSize() -> CGFloat {
        let fontSize : CGFloat = 13;
        var newFontSize : CGFloat = UIScreen.main.bounds.size.height * CGFloat(fontSize/568)
        if (UIScreen.main.bounds.size.height < 500) {
            newFontSize = UIScreen.main.bounds.size.height * CGFloat(CGFloat(fontSize) / 480.0);
        }
        let maxFontSize : CGFloat = 18;
        if (newFontSize>maxFontSize) {
            newFontSize = maxFontSize;
        }
        return newFontSize;
    }
    func systemFont() -> UIFont {
        return UIFont(name: "Poppins-Medium", size:self.calculateFontSize())!
    }
    func boldSystemFont() -> UIFont {
        return UIFont.init(name: "Poppins-Medium", size:self.calculateFontSize()+2)!
    }
    func smallSystemFont() -> UIFont {
        return UIFont(name: "Poppins-Medium", size:self.calculateFontSize()-2)!
    }
    func systemFont(size:CGFloat) -> UIFont {
        return UIFont.init(name: "Poppins-Medium", size:size)!
    }
    func boldSystemFont(size:CGFloat) -> UIFont {
        return UIFont.init(name: "Poppins-Medium", size:size+2)!
    }
}

