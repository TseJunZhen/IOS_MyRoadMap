//
//  TimeDetailViewController.swift
//  MyRoadMap
//
//  Created by Tse Jun Zhen on 15/01/2019.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit
import Firebase

class TimeDetailViewController: UIViewController {
    
    
    @IBOutlet var insertDataView: UIView!
    @IBOutlet var monthView: UIView!
    @IBOutlet var chooseAbilityView: UIView!
    
    @IBOutlet weak var monthLB: UILabel!
    @IBOutlet weak var abilityLB: UILabel!
    
    @IBOutlet var languageAllBtn: [UIButton]!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var okayBtn: UIButton!
    var checkA = false
    var checkB = false
    { didSet{ if checkA == true && checkB == true { okayBtn.alpha = 1 } } }
    
    var getYears = ""
    var getMonths = [String]()
    var getData = [Dictionary<String, Any>]()
    
    let cropView = UIView()
    var skillarray = [["January","swift","09","test1234@gmail.com"],["May","python","06","test1234@gmail.com"]]
    
    var imageNumber = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getData)
        print(getMonths)
    
       getColor(tools: self.view, add: 1)

        // Do any additional setup after loading the view.
    }
    
    func chooseImage(number: Int) -> String{
        
        var logString = ""
        
        if number == 01 { logString = "01C_logo" } else if number == 02 { logString = "02C#_logo" }
        
        else if number == 03 { logString = "03C++_logo"} else if number == 04 { logString = "04css_logo" }
        
        else if number == 05 { logString = "05docker_logo"} else if number == 06 { logString = "06docNet_logo" }
        
        else if number == 07 { logString = "07html_logo"} else if number == 08 { logString = "08ios_logo" }
        
        else if number == 09 { logString = "09ObjectiveC_logo"} else if number == 10 { logString = "10swift_logo" }
        
        else if number == 11 { logString = "11Javascript_logo"} else if number == 12 { logString = "12php_logo" }
        
        else if number == 13 { logString = "13python_logo"} else if number == 14 { logString = "14Ruby_logo" }
        
        else if number == 15 { logString = "15nodejs_logo"} else if number == 16 { logString = "16vue_logo" }
        
        else if number == 17 { logString = "17yml_logo"} else if number == 18 { logString = "18go_logo" }
        
        else if number == 19 { logString = "19kotlin_logo"} else if number == 20 { logString = "20xamarin_logo" }
        
        else if number == 21 { logString = "21sqlite_logo"} else if number == 22 { logString = "22fmdb_logo" }
        
        else if number == 23 { logString = "23oracle_logo"} else if number == 24 { logString = "24mongoDB_logo" }
        
        else if number == 25 { logString = "25mysql_logo"} else if number == 26 { logString = "26coredata_logo" }
        
        else if number == 27 { logString = "27realm_logo"} else if number == 28 { logString = "28graphQL_logo" }
        
        else if number == 29 { logString = "29extremedb_logo"} else if number == 30 { logString = "30postgreSQL_logo" }
                
        return logString  //useImage
    }
    
    @IBAction func insertDataAtn(_ sender: UIButton) {
        
        if Bundle.main.loadNibNamed("insertData", owner: self, options: nil)?.first as? insertData != nil{
            insertDataView.frame.size.width = view.frame.size.width * 0.6
            insertDataView.frame.size.height = view.frame.size.height * 0.4
            insertDataView.frame.origin.x = self.view.frame.size.width * 0.4 / 2
            insertDataView.frame.origin.y = self.view.frame.size.height * 0.6 / 2
            
            insertDataView.getCorner(cornerItem: insertDataView, myCorner: 40, cornerBG: .white)
            
            cropView.frame = view.frame ; cropView.alpha = 0.4 ; getColor(tools: cropView, add: 0.5)
            self.view.addSubview(cropView)
            self.view.addSubview(insertDataView)
            
            monthLB.text = ".Jan"
            abilityLB.text = ".swift"
            okayBtn.alpha = 0
        }
    }
    
    func getColor (tools: UIView, add: CGFloat){
        let primaryColor = UIColor(red: 210/255, green: 109/255, blue: 180/255, alpha: 1)
        let secondaryColor = UIColor(red: 52/255, green: 148/255, blue: 230/255, alpha: 1)
        tools.alpha = add
        tools.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    @IBAction func chooseMonthAtn(_ sender: UIButton) {
        
        if Bundle.main.loadNibNamed("addMonth", owner: self, options: nil)?.first as? addMonth != nil{
            monthView.frame.size.width = view.frame.size.width * 0.8
            monthView.frame.size.height = view.frame.size.height * 0.4
            monthView.frame.origin.x = self.view.frame.size.width * 0.2 / 2
            monthView.frame.origin.y = self.view.frame.size.height * 0.4 / 2
            
            monthView.getCorner(cornerItem: monthView, myCorner: 25, cornerBG: .black)
            self.view.addSubview(monthView)
        }
        checkA = true
    }
    
    @IBAction func chooseAtn(_ sender: UIButton) {
        
        if Bundle.main.loadNibNamed("chooseAbility", owner: self, options: nil)?.first as? chooseAbility != nil{
            chooseAbilityView.frame.size.width = view.frame.size.width * 0.9
            chooseAbilityView.frame.size.height = view.frame.size.height * 0.7
            chooseAbilityView.frame.origin.x = self.view.frame.size.width * 0.1 / 2
            chooseAbilityView.frame.origin.y = self.view.frame.size.height * 0.3 / 2
            
            chooseAbilityView.getCorner(cornerItem: chooseAbilityView, myCorner: 20, cornerBG: .white)
            self.view.addSubview(chooseAbilityView)
        }
        checkB = true
    }
    
    @IBAction func chooseLanguage(_ sender: UIButton){
        var aa = ""
        switch sender.tag {
        default:
            if (String(sender.tag)).count == 1 {
                aa = "0" + "\(sender.tag)"
                abilityLB.text = "\(aa).\(sender.titleLabel!.text!)"
            }else{
                abilityLB.text = "\(sender.tag).\(sender.titleLabel!.text!)"
            }
            
            for i in 0...29{
                languageAllBtn[i].alpha = 0.5
            }
            sender.alpha = 1
            imageNumber = sender.tag
        }
    }
    
    @IBAction func sureMonthAtn(_ sender: UIButton) {
        switch sender.tag {
        default:
            checkoutBtn(sender: sender)
        }
    }
    
    @IBAction func okayAtn(_ sender: UIButton) {
        
        cropView.removeFromSuperview()
        
        let userMail = UserDefaults().string(forKey: "mail")!
        // skillarray[0][3] , 2018 , January - 這些是要更改的
        let selfRef = Firestore.firestore().document("people/version_1/roadMap/\(userMail)/years/\(getYears)/userData/\(monthLB.text!)/")
        
        var showTitle = ""
        for i in 0...29 {
            if languageAllBtn[i].tag == imageNumber {
                showTitle = languageAllBtn[i].titleLabel!.text!
            }
        }
        
        let abilities = abilityLB.text!
        let deRange = abilities.range(of: ".")
        
        let setAbility = abilities.suffix(from: deRange!.upperBound)
        let imgNum = abilities.prefix(upTo: deRange!.lowerBound)
        
        let dicData: Dictionary<String, Any> = ["ability": showTitle,"languageImage":String(imgNum)]
        
        getMonths.append(monthLB.text!)
        getData.append(dicData as! [String: Any])
        
        selfRef.setData(["ability":"\(setAbility)","languageImage":"\(imgNum)","enabled":true])
        
        detailTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.insertDataView.removeFromSuperview()
        }
        
    }
    
    @IBAction func chooseOkayAtn(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 2, animations: {
                self.self.chooseAbilityView.alpha = 0
                self.chooseAbilityView.removeFromSuperview()
            })
        }
    }
    
    
    
    func checkoutBtn(sender: UIButton){
        sender.getCorner(cornerItem: sender, myCorner: 15, cornerBG: .white)
        sender.backgroundColor = .yellow
        
        monthLB.text = sender.titleLabel?.text
        UIView.animate(withDuration: 3) {
            self.monthView.alpha = 0
        }
    }
    
    @IBAction func backAtn(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
}

extension TimeDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getMonths.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "TimeDetailCell", for: indexPath) as! TimeDetailCell
        
     
        let imgNum = getData[indexPath.row]["languageImage"]!
        let aa = "\(imgNum)"
        

        detailCell.monthLb.text = "\(getMonths[indexPath.row])"
        detailCell.abilityLb.text = "\(getData[indexPath.row]["ability"]!)"
        detailCell.abilityImage.image = UIImage(named: chooseImage(number: Int(aa)!))

        return detailCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(0)
    }
}
