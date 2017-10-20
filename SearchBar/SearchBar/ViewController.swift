//
//  ViewController.swift
//  SearchBarDemo
//
//  Created by 沈凯 on 2017/10/17.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit
let space = 50;//搜索框图片加上图片和字体之间的距离
class ViewController: UIViewController {
//    searchBar
    @IBOutlet weak var searchBar: UISearchBar!
//    当前IOS系统版本
    var currentVersion: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchBar的外观设置
        searchBar.layer.masksToBounds = true;
        searchBar.layer.cornerRadius = searchBar.frame.size.height / 2;
        searchBar.layer.borderWidth = 1;
        searchBar.contentMode = .center;
        searchBar.layer.borderColor = UIColor.init(red: 197/255.0, green: 199/255.0, blue: 200/255.0, alpha: 1).cgColor;
//        searchBar弹出的键盘类型设置
        searchBar.returnKeyType = UIReturnKeyType.done;
//        searchBar中的textField设置
        let searchField = searchBar.value(forKey: "_searchField") as! UITextField;
        searchField.setValue(UIFont.systemFont(ofSize: 10), forKeyPath: "_placeholderLabel.font");
        searchField.setValue(UIColor.init(red: 70/255.0, green: 70/255.0, blue: 70/255.0, alpha: 1), forKeyPath: "_placeholderLabel.textColor");
//        获取系统版本号
        let sysVersion = UIDevice.current.systemVersion
        currentVersion = Int(sysVersion.components(separatedBy: ".").first!)
//        判断是不是大于IOS 11
        if currentVersion! < 11 {
            searchField.attributedPlaceholder = NSAttributedString.init(string: "SEARCH", attributes: [NSAttributedStringKey.baselineOffset:-2]);
        }else
        {
//            searchBar中textField的placeholder的宽度可以获取
//            let label = UILabel.init()
//            label.text = "SEARCH"
//            label.font = UIFont.systemFont(ofSize: 10)
//            label.sizeToFit()
//            print(label.frame.width)
//            获取当前屏幕宽度
            self.view.frame.size.width = UIScreen.main.bounds.size.width
//            重新布局
            self.view.layoutSubviews()
//            计算偏移量:偏移量 =（searchBar的宽度-label宽度-搜索框图片加上图片和字体之间的宽度）/ 2
            searchBar.setPositionAdjustment(UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
        }
//        使键盘点击空白处关闭
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(viewTapped(tap:)));
        tap.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(tap);
    }
    @objc func viewTapped(tap: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
}
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        输入时需要进行的操作
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if currentVersion >= 11 {
            self.searchBar.setPositionAdjustment(UIOffset.zero, for: UISearchBarIcon.search)
        }
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if currentVersion >= 11 {
            searchBar.setPositionAdjustment(UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        输入完成时，点击按钮需要进行的操作
        searchBar.resignFirstResponder()
    }
}
