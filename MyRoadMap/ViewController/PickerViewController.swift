//
//  PickerViewController.swift
//  MyRoadMap
//
//  Created by Tse Jun Zhen on 15/01/2019.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit
//import FirebaseFirestore
import Firebase

class PickerViewController: UIViewController {
    var yearAndImage = DetailsOfYear()
    var yearsNumber = [Int]()
    let defaults = UserDefaults.standard
    var collectionData: [UIImage] = [ UIImage(named: "01C_logo")!,UIImage(named: "02C#_logo")!,UIImage(named: "03C++_logo")!,UIImage(named: "04css_logo")!,UIImage(named: "05docker_logo")!,UIImage(named: "06docNet_logo")!,UIImage(named: "07html_logo")!,UIImage(named: "08ios_logo")!,UIImage(named: "09ObjectiveC_logo")!,UIImage(named: "10swift_logo")!,UIImage(named: "11Javascript_logo")!,UIImage(named: "12php_logo")!,UIImage(named: "13python_logo")!,UIImage(named: "14Ruby_logo")!,UIImage(named: "15nodejs_logo")!,UIImage(named: "16vue_logo")!,UIImage(named: "17yml_logo")!,UIImage(named: "18go_logo")! ]
    var imageNames: [String] = ["01C_logo", "02C#_logo", "03C++_logo", "04css_logo", "05docker_logo",  "06docNet_logo", "07html_logo", "08ios_logo", "09ObjectiveC_logo", "10swift_logo", "11Javascript_logo", "12php_logo", "13python_logo", "14Ruby_logo", "15nodejs_logo",  "16vue_logo", "17yml_logo", "18go_logo"]
    var imageView:UIImageView!
    var fullScreenSize :CGSize!
    
    @IBAction func actionDoneBtn(_ sender: UIButton) {
        let db = Firestore.firestore().collection(firestoreValue.people.rawValue).document(firestoreValue.version_1.rawValue)
            .collection(firestoreValue.raodMap.rawValue).document(defaults.value(forKey: "mail") as! String)
            .collection(firestoreValue.years.rawValue).document(String(yearAndImage.Year!))
            .setData([ "imageIndex": yearAndImage.ImageTotalIndex!,
                       "imageName": imageNames[yearAndImage.ImageIndex!],
                       "enabled": true
                    ])
    }
    
    func uploadImageToStorage(imageType: UIImage) {
        let storage = Storage.storage()

        var data = Data()
        data = imageType.pngData()! // image file name

        // Create a storage reference from our storage service

        let storageRef = storage.reference()

        let imageRef = storageRef.child("images/" + String(yearAndImage.Year!) + ".png")

        _ = imageRef.putData(data, metadata: nil, completion: { (metadata,error ) in

            guard metadata != nil else{

                print(error as Any)

                return

            }

            
            let downloadURL = metadata?.path

//            print(downloadURL)

        })
        

    }

        
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showYearsText: UITextField!
    @IBOutlet weak var pickerYear: UIPickerView!
    @IBOutlet weak var imageSelect: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerYear.dataSource = self as? UIPickerViewDataSource
        pickerYear.delegate = self as? UIPickerViewDelegate
        collectionView.dataSource = self
        collectionView.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
//        initFirestore()
        initYears()
        initCollection()

    }
    
    func initFirestore() {
        let db = Firestore.firestore()
        let man = db.collection("people").document("man")
        let woman = db.collection("people").document("woman")

        let men = man.collection("roadMap")
        
        men.getDocuments { (document, error) in
            
           print(document?.count)
            }
        
        
    }
    
    func initYears() {
        for i in (1945..<2020).reversed() {
            yearsNumber.append(i)
//            print(i)
        }
    }
    func initCollection() {
        let width = (view.frame.size.width - 20) / 6
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 10,left: 5,bottom: 10,right: 5)
        // 建立 UICollectionViewFlowLayout
    }
    
    func uiImageString(str: String) -> UIImage {
        return UIImage(named: str)!
    }
}
extension PickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCollectionViewCell", for: indexPath) as! MapCollectionViewCell
        UIGraphicsBeginImageContext(cell.frame.size)
        collectionData[indexPath.row].draw(in: cell.bounds)
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            cell.backgroundColor = UIColor(patternImage: image)
        }
        
        yearAndImage.Image = collectionData[indexPath.row]
        yearAndImage.ImageTotalIndex = indexPath.row
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageSelect.image = collectionData[indexPath.row]
        yearAndImage.ImageIndex = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCollectionViewCell", for: indexPath) as! MapCollectionViewCell
        
    }
    
    
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showYearsText.text = String(yearsNumber[row])
        showYearsText.textAlignment = .center
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearsNumber.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        yearAndImage.Year = yearsNumber[row]
        return String(yearsNumber[row])
    }
}
