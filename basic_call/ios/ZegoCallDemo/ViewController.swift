//
//  ViewController.swift
//  ZegoCallDemo
//
//  Created by zego on 2022/8/19.
//

import UIKit

class ViewController: UIViewController {
    
    let selfUserID: String = String(format: "%d", Int.random(in: 0...99999))
    var selfUserName: String?
    
    @IBOutlet weak var userIDLabel: UILabel! {
        didSet {
            userIDLabel.text = selfUserID
        }
    }
    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            selfUserName = String(format: "z_%@", selfUserID)
            userNameLabel.text = selfUserName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func makeNewCall(_ sender: Any) {
        
        let config: ZegoUIkitPrebuiltCallConfig = ZegoUIkitPrebuiltCallConfig()
        let layout: ZegoLayout = ZegoLayout()
        let pipConfig: ZegoLayoutPictureInPictureConfig = ZegoLayoutPictureInPictureConfig()
        pipConfig.smallViewPostion = .topRight
        layout.config = pipConfig
        config.layout = layout
        
        let callVC = ZegoUIKitPrebuiltCallVC.init(yourAppID, appSign: yourAppSign, userID: selfUserID, userName: self.selfUserName ?? "", callID: yourCallID, config: config)
        callVC.modalPresentationStyle = .fullScreen
        self.present(callVC, animated: true, completion: nil)
    }


}

