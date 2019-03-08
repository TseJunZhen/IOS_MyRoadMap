//
//  HomeTableViewController.swift
//  myDailyNote
//
//  Created by Tse Jun Zhen on 09/01/2019.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit
import Firebase

class HomeTableViewController: UIViewController {
    
    var yearDetail = DetailsAndMonthsOfYear()
    var yearsOfUser = YearsOfUser()
    var skills: [Skill] = []
    let db = Firestore.firestore()
    let defaults = UserDefaults.standard
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var timeLineTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firestoreDataInit()
        tableviewInit()
    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "goDetail"{
//            
//            
//            
//        }
//    }
    
    func tableviewInit() {
        if #available(iOS 10.0, *) {
            timeLineTableView.refreshControl = refreshControl
        } else {
            timeLineTableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)

    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        
        fetchWeatherData()
    }
    private func fetchWeatherData() {
                
//                self.updateView()
        self.refreshControl.endRefreshing()
        skills.removeAll()
        initData()
        
        //                self.activityIndicatorView.stopAnimating()
        
        
    }
    
    func firestoreDataInit() {
       
        
        let messageRef = db
            .collection(firestoreValue.people.rawValue)
            .document(firestoreValue.version_1.rawValue)
        
        messageRef.collection(firestoreValue.raodMap.rawValue).whereField("mail", isEqualTo: defaults.value(forKey: "mail") as! String)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    print("\(document.documentID) => \(document.data())")
                    let dictionary:[String: Any] = document.data() 
                    for (key, value) in dictionary {
                        self.defaults.setValue(value as? String, forKey: key)
                    }
                }
                self.initData()

            //
            }
        }
//        print(yearData.mail!)
    }
    
    func initData(){
        
        let docRef = db.collection(firestoreValue.people.rawValue).document(firestoreValue.version_1.rawValue)
                       .collection(firestoreValue.raodMap.rawValue).document(defaults.value(forKey: "mail") as! String)
                       .collection(firestoreValue.years.rawValue).whereField("enabled", isEqualTo: true)
                       .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                
                                var years = [String]()
                                for document in querySnapshot!.documents {
                                    
                                    years.append(String(document.documentID))
                                    var imageName: String?
                                    let dictionary:[String: Any] = document.data()
                                    for (key, value) in dictionary {
                                        if key == "imageName" {
                                            imageName = value as? String
                                        }
                                    }
                                    
                                    let detail = Skill(skillYear: document.documentID, skillImage: UIImage(named: imageName!)!)
                                    self.skills.append(detail)
                                }
                                self.yearsOfUser.year = years
                                self.timeLineTableView.reloadData()
                            }
        }

        sleep(1)
       
        
    }
    
}

extension HomeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let timeCell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell", for: indexPath) as! TimelineCell
        
        // 設置 Accessory 按鈕樣式
        timeCell.accessoryType = .disclosureIndicator
        
        let skill = skills[indexPath.row]
        
        timeCell.setSkill(skill: skill)
        return timeCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "RoadMap's Time Line"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "TimeDetailViewController") as! TimeDetailViewController
        prepareDataForSend(row: indexPath.row, DvC: DvC)

    }
    
    func prepareDataForSend (row: Int, DvC: TimeDetailViewController){
        
        let messageRef = db
        .collection(firestoreValue.people.rawValue).document(firestoreValue.version_1.rawValue)
        .collection(firestoreValue.raodMap.rawValue).document(defaults.value(forKey: "mail") as! String)
        .collection(firestoreValue.years.rawValue).document(yearsOfUser.year![row] as! String)
        .collection(firestoreValue.userData.rawValue)
        .whereField("enabled", isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else if querySnapshot!.documents.count == 0 {
                    DvC.getYears = self.yearsOfUser.year![row]
                    self.navigationController?.pushViewController(DvC, animated: true)
                } else {
                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
                        DvC.getYears = self.yearsOfUser.year![row]
                        DvC.getMonths.append(document.documentID)
                        DvC.getData.append(document.data())
                    }
                    self.navigationController?.pushViewController(DvC, animated: true)

                }
        }

    }
}
