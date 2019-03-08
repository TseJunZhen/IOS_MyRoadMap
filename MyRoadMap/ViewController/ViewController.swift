//
//  ViewController.swift
//  myDailyNote
//
//  Created by 洪立德 on 2019/1/9.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    // log in
    @IBOutlet weak var logMailTxt: UITextField!
    @IBOutlet weak var logPasswordTxt: UITextField!
    
    
    // sign up
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var userMailTxt: UITextField!
    @IBOutlet weak var userPasswordTxt: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    let warningLB = UILabel()
    let date = Date()
//    var userKey = ""
    
    @IBOutlet weak var swipeUPLb: UILabel!
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    
    //saved userDefaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        swipeUPLb.isHidden = true
        // add gesture
        var swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.showFirstViewController))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
        let primaryColor = UIColor(red: 210/255, green: 109/255, blue: 180/255, alpha: 1)
        let secondaryColor = UIColor(red: 52/255, green: 148/255, blue: 230/255, alpha: 1)
        
        if logPasswordTxt != nil {
            logPasswordTxt.delegate = self
        }
        
        logMailTxt.getCorner(cornerItem: logMailTxt, myCorner: 5, cornerBG: .white)
        logPasswordTxt.getCorner(cornerItem: logPasswordTxt, myCorner: 5, cornerBG: .white)
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
//            print("toHome")
        }
    }
    
    @objc func showFirstViewController(gesture: UIGestureRecognizer) {
        
        gesture.addTarget(self, action: #selector(ViewController.handleSignIn))
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        // log in
        logMailTxt.resignFirstResponder()
        logPasswordTxt.resignFirstResponder()
    }
    
    
    @IBAction func tapGestureAtn(_ sender: UITapGestureRecognizer) {
       
        // close keyboard
        view.endEditing(true)
        
        if signUpView != nil {
        UIView.animate(withDuration: 1.0) {
            self.signUpView.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1.1) {
            self.signUpView.removeFromSuperview()
        }
        }
    }
    
    // log in
    @objc func handleSignIn() {
        guard let email = logMailTxt.text else { return }
        guard let pass = logPasswordTxt.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                
//                let collectionRef = Firestore.firestore().collection("people/man/roadMap")
//                let date = Date()
//                let key = user?.user.uid
//                self.userKey = key!
//                collectionRef.document(email).setData(["name" : "","phone":"","mail":email,"birth":date,"profileUrl":""])
                self.defaults.set(email, forKey: "mail")
                
                
                self.performSegue(withIdentifier: "toHome", sender: self)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func signUpAtn(_ sender: UIButton) {
        
        // insert xib
        if (Bundle.main.loadNibNamed("signUp", owner: self, options: nil)?.first as? signUp) != nil
        {
            signUpView.frame.size.width = view.frame.size.width * 0.8
            signUpView.frame.size.height = view.frame.size.height * 0.6
            signUpView.frame.origin.x = self.view.frame.size.width * 0.2 / 2
            signUpView.frame.origin.y = self.view.frame.size.height * 0.4 / 2
            
            signUpView.getCorner(cornerItem: signUpView, myCorner: 40, cornerBG: .white)
            self.view.addSubview(signUpView)
            
        }
        userNameTxt.adjustsFontSizeToFitWidth = true
        userMailTxt.adjustsFontSizeToFitWidth = true
        userPasswordTxt.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func doneAtn(_ sender: UIButton) {
        
        doneBtn.addTarget(self, action: #selector(ViewController.handleSignUp), for: .touchUpInside)
        
    }
    
    // sign up
    @objc func handleSignUp() {
        guard let username = userNameTxt.text else { return }
        guard let email = userMailTxt.text else { return }
        guard let pass = userPasswordTxt.text else { return }
        
//        setContinueButton(enabled: false)
//        continueButton.setTitle("", for: .normal)
//        activityView.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
//                print("User created!")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                
                changeRequest?.commitChanges { error in
                    if error == nil {
//                        print("User display name changed!")
                        self.logMailTxt.text = self.userMailTxt.text!
                        self.logPasswordTxt.text = self.userPasswordTxt.text!
                        self.signUpView.removeFromSuperview()
                        
                        let collectionRef = Firestore.firestore()
                            .collection(firestoreValue.people.rawValue).document(firestoreValue.version_1.rawValue)
                            .collection(firestoreValue.raodMap.rawValue).document(email)

//                        let key = user?.user.uid
//                        self.userKey = key!
                        collectionRef.setData(["name" : String(email.first!),
                                               "phone": "",
                                               "mail": email,
                                               "birth": Timestamp(date: self.date),
                                               "createAt": Timestamp(date: self.date),
                                               "profileUrl": ""])
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            self.swipeUPLb.isHidden = false
                            self.swipeUPLb.flash(sender: self.swipeUPLb, repeatIs: 5)
                        })

                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            self.swipeUPLb.isHidden = true
                        })
                        
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
                
            } else {
                self.warningLB.frame.size.width = self.signUpView.frame.size.width * 0.8
                self.warningLB.frame.size.height = self.signUpView.frame.size.height * 0.1
                self.warningLB.frame.origin.x = self.signUpView.frame.size.width * 0.1
                self.warningLB.frame.origin.y = self.signUpView.frame.size.height * 0.9
                self.warningLB.text = "you got the wrong number please try it again"
                self.warningLB.textColor = .red
                self.warningLB.numberOfLines = 2
                self.warningLB.isHidden = false
                self.signUpView.addSubview(self.warningLB)
                self.warningLB.flash(sender: self.warningLB, repeatIs: 3)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.warningLB.isHidden = true
                })
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
}

extension ViewController : UITextFieldDelegate {
    
    //MARK: - Text Field Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (logMailTxt!.text != nil) && logPasswordTxt!.text != nil{
            
            let email = logMailTxt.text!
            let pass = logPasswordTxt.text!
            
            Auth.auth().signIn(withEmail: email, password: pass) { user, error in
                if error == nil && user != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self.swipeUPLb.isHidden = false
                        self.swipeUPLb.flash(sender: self.swipeUPLb, repeatIs: 5)
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        self.swipeUPLb.isHidden = true
                    })
                }else {
                    print("Error logging in: \(error!.localizedDescription)")
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        if (logMailTxt!.text != nil) && logPasswordTxt!.text != nil{
           
            let email = logMailTxt.text!
            let pass = logPasswordTxt.text!
            
            Auth.auth().signIn(withEmail: email, password: pass) { user, error in
                if error == nil && user != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self.swipeUPLb.isHidden = false
                        self.swipeUPLb.flash(sender: self.swipeUPLb, repeatIs: 5)
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        self.swipeUPLb.isHidden = true
                    })
                }else {
                    print("Error logging in: \(error!.localizedDescription)")
                }
            }
        }
        return true
    }
}
