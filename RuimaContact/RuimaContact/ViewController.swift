//
//  ViewController.swift
//  RuimaContact
//
//  Created by Tony Duan on 2016/10/31.
//  Copyright © 2016年 ChengduRuiMa. All rights reserved.
//

import UIKit
import AVOSCloud

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var myTable: UITableView!
    let dataArray:NSMutableArray? = NSMutableArray.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.white
        self.title = "睿码App通讯录"
        let query = AVQuery.init(className: "RMContact")
        
                query.order(byDescending: "createdAt")
                query.findObjectsInBackground({[weak self]
                (avObjes,error)-> Void in
                    
                    if error == nil {
                        
                        self?.dataArray!.addObjects(from: avObjes!)
                        print("the obj is \(self?.dataArray)")
                        self?.myTable.reloadData()
                    }
                })
        
//        let obj = query.getFirstObject()
//        let name = obj?.object(forKey: "name")
//        
//        self.myTable.register(UITableViewCell.self, forCellReuseIdentifier: "TonyCell")
//        self.myTable.register(UINib.init(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCellIdt")
//        self.myTable.register(ContactCell.self, forCellReuseIdentifier: "ContactCellIdt")
        
        //MARK: - 如果是在storyboard中自定义UITableviewCell并不需要在register代码设置Cell indexpath
//        self.myTable.estimatedRowHeight = 60
        self.myTable.dataSource = self
        self.myTable.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:ContactCell = tableView.cellForRow(at: indexPath) as! ContactCell
        let phoneNumber  = cell.phoneNumber.text
        
        if let okPhone = phoneNumber {
            let stats =  UIApplication.shared.canOpenURL(URL.init(string: "tel://\(okPhone)")!)
            let alertController:UIAlertController = UIAlertController.init(title: "拨打☎️", message: "\(okPhone)", preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "确认", style: .default, handler: {
                action -> Void in
                print("vava")
                if(stats){
                    let dialPhone = "tel://\(phoneNumber!)"
                    UIApplication.shared.open(URL.init(string: dialPhone)!, options:[:], completionHandler: { (status) in
                        print("opened")
                    })
                }
                
            })
            
            let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: {
                action -> Void in
                print("nonono")
            })
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true , completion: {
                print("vvvvvv")
            })
        }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: - 如果是在storyboard中自定义UITableviewCell可以不用传indexPath
        
//        let cell1:ContactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCellIdt") as! ContactCell
        let cell1:ContactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCellIdt", for: indexPath) as! ContactCell
        
        let obj = dataArray?.object(at: indexPath.row) as! AVObject
        let name = obj.object(forKey: "name")
        let phone = obj.object(forKey: "phoneNumber")
        
        cell1.userName?.text = name as? String
        cell1.phoneNumber?.text = phone as? String
        
        return cell1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

