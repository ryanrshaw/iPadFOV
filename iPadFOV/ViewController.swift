//
//  ViewController.swift
//  iPadFOV
//
//  Created by bender on 11/30/18.
//  Copyright © 2018 rrshaw. All rights reserved.
//  astrometry.net API key: qbpvizogjfkyrstv 

import UIKit
//import DropDownSw
import iOSDropDown

class ViewController: UIViewController {

    
    @IBOutlet weak var txtSensorW: UITextField!
    
    @IBOutlet weak var txtSensorH: UITextField!
    
    @IBOutlet weak var myRect: UIView!
    @IBOutlet weak var fovW: UITextField!
    @IBOutlet weak var fovH: UITextField!
    @IBOutlet weak var fovWMin: UITextField!
    //@IBOutlet weak var textSensW: UITextField!
    @IBOutlet weak var fovHMin: UITextField!
    @IBOutlet weak var fovWSec: UITextField!
    @IBOutlet weak var fovHSec: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var fovWD: UITextField!
    @IBOutlet weak var fovHD: UITextField!
    @IBOutlet weak var txtFL: UITextField!
    @IBOutlet weak var sensorSizeW: UITextField!
    
    @IBOutlet weak var valueLabel: UILabel!
    // iOSDropDown https://github.com/jriosdev/iOSDropDown
    @IBOutlet weak var newd: DropDown!
    @IBOutlet weak var teleDropDown: DropDown!
    
    
    
    @IBOutlet weak var sensorSizeH: UITextField!
    
    @IBOutlet weak var pixelsW: UITextField!
    
    
    @IBOutlet weak var txtF: UITextField!
    @IBOutlet weak var txtAperture: UITextField!
    
    
    @IBAction func btnAbout(_ sender: Any) {
        let alert = UIAlertController(title: "About", message: "copyright 2024 by rrs", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel , handler: {
            (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
        if let popOver = alert.popoverPresentationController {
            popOver.sourceView = sender as? (UIView)
            popOver.permittedArrowDirections = UIPopoverArrowDirection.down
            
            //popOver.UIPopoverArrowDirection.Up
            //popOver.sourceRect =  sender.bounds
            //popOver.sourceRect =
            //popOver.barButtonItem
        }
    }
    
    
    
    @IBOutlet weak var camView: UIView!
    @IBOutlet weak var viewTele: UIView!
    @IBOutlet weak var fovView: UIView!
    @IBOutlet weak var calcView: UIView!
    @IBOutlet weak var pixelsH: UITextField!
    @IBOutlet weak var labelFrame: UILabel!
    @IBOutlet weak var inputFrame: UIView!
  
    @IBOutlet weak var buttonReset: UIButton!
    @IBAction func buttonResetRot(_ sender: Any) {
        // woohoo something that works
        myRect.transform = CGAffineTransform.identity
    }
    @IBAction func buttonReset(_ sender: UIButton) {
        
    }
    
    
    @IBAction func btnCalcPush(_ sender: AnyObject) {
        //fovW.text = String(integerW(from: txtSensorW))
        let dblFL = dblA(from: txtAperture)*dblF(from: txtF)
        txtFL.text = String(dblFL)
        
        myRect.transform = CGAffineTransform.identity
        labelFrame.isHidden = false
        labelFrame.numberOfLines = 2
        //labelFrame.text = "Imaging\nframe"
        
        let sensSizeW = integerSW(from: sensorSizeW)
        let sensSizeH = integerSH(from: sensorSizeH)
        let pixW = integerPW(from: pixelsW)
        let pixH = integerPH(from: pixelsH)
        
        
        let sensWidth = (sensSizeW * pixW) / 1000
        let sensHeight = (sensSizeH * pixH) / 1000
    
        txtSensorW.text = String(format:"%.3f", (sensSizeW * pixW) / 1000)
        txtSensorH.text = String(format:"%.3f", (sensSizeH * pixH) / 1000)
        //let sensWidth = integerW(from: txtSensorW)
        //let sensHeight = integerH(from: txtSensorH)
        let fl = integerFL(from: txtFL)
        let pi: Double = 3.14159265358979
        //let degWidth: Double = 2*(atan(sensWidth/(2*fl))*(180/pi))
        let degWidth: Double = 2*(atan(sensWidth/(2*fl))*(180/pi))
        let degHeight: Double = 2*(atan(sensHeight/(2*fl))*(180/pi))
        
        var degWS =  Int(degWidth * 3600)
        degWS = abs(degWS % 3600)
        let fovWM = degWS / 60
        degWS %= 60
        let degWD = Int(degWidth)
        
        var degHS =  Int(degHeight * 3600)
        degHS = abs(degHS % 3600)
        let fovHM = degHS / 60
        degHS %= 60
        let degHD = Int(degHeight)
        
        //labelFrame.text = "Test"
        
        fovWMin.text = String(fovWM)
        fovWSec.text = String(degWS)
        fovHMin.text = String(fovHM)
        fovHSec.text = String(degHS)
        fovWD.text = String(degWD)
        fovHD.text = String(degHD)
        fovW.text = String(format:"%.3f", degWidth)
        fovH.text = String(format:"%.3f", degHeight)
        //let myFrame = CGRect(x: 550.0, y: 300.0, width: degWidth * 200, height: degHeight * 200)
        myRect.frame = CGRect(x: 20.0, y: 300.0, width: degWidth * 990 + 3, height: degHeight * 990 + 3)
        //let myRect = UIView(frame: myFrame)
        //lblW.text = String(degWidth)
    
        myRect.backgroundColor = UIColor.clear
        
        //let gradientMaskLayer = CAGradientLayer()
        //gradientMaskLayer.frame = myRect.bounds
        //gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
       // gradientMaskLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
       // gradientMaskLayer.locations = [0, 1, 1, 1]
       // myRect.layer.mask = gradientMaskLayer
        //view.addSubview(myRect)
        myRect.layer.borderWidth = 2
        myRect.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(myRect)
        //view.addSubview(myRect)
        //let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
    }
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenSize: CGRect = UIScreen.main.bounds
        img.frame = CGRect(x: 450, y:0, width: screenSize.width * 0.3, height: screenSize.height)
        
        //buttonText.layer.cornerRadius = 100
        //buttonText.clipsToBounds = true
        //buttonReset.layer.cornerRadius = 100
        //buttonReset.clipsToBounds =  true
        // The list of array to display. Can be changed dynamically
        inputFrame.layer.cornerRadius = 5.0
        inputFrame.clipsToBounds = true
        inputFrame.layer.borderWidth = 3
        inputFrame.layer.borderColor = UIColor.darkGray.cgColor
        
        viewTele.layer.cornerRadius = 5.0
        viewTele.clipsToBounds = true
        viewTele.layer.borderWidth = 3
        viewTele.layer.borderColor = UIColor.darkGray.cgColor
        
        teleDropDown.layer.cornerRadius = 5.0
        teleDropDown.clipsToBounds = true
        teleDropDown.layer.borderWidth = 1
        teleDropDown.layer.borderColor = UIColor.red.cgColor
        
        newd.layer.cornerRadius = 5.0
        newd.clipsToBounds = true
        newd.layer.borderWidth = 1
        newd.layer.borderColor = UIColor.red.cgColor
        
        fovView.layer.cornerRadius = 5.0
        fovView.clipsToBounds = true
        fovView.layer.borderWidth = 3
        fovView.layer.borderColor = UIColor.darkGray.cgColor
        
        camView.layer.cornerRadius = 5.0
        camView.clipsToBounds = true
        camView.layer.borderWidth = 3
        camView.layer.borderColor = UIColor.darkGray.cgColor
        
        calcView.layer.cornerRadius = 15.0
        calcView.clipsToBounds = true
        calcView.layer.borderWidth = 2
        calcView.layer.borderColor = UIColor.black.cgColor
        
        self.view.addSubview(inputFrame)
        self.view.sendSubviewToBack(inputFrame)
        valueLabel.text = "no camera"
        labelFrame.text = "ATIK 460EX"
        //labelFrame.text = "No camera selected"
        let option =  Options()
        newd.optionArray = option.cameras
        //Its Id Values and its optional
        newd.optionIds = option.ids
        newd.isSearchEnable = false
        newd.rowBackgroundColor = UIColor.white
        newd.selectedRowColor = UIColor.lightGray
        // The the Closure returns Selected Index and String
        newd.didSelect{(selectedText, index, id) in
            //self.valueLabel.text = "\(selectedText) index: \(index) id: \(id)"
            self.valueLabel.text = "\(selectedText)"
            
           if (index == 0)
           {
           self.pixelsW.text = "1628"
            self.pixelsH.text = "1236"
            //self.txtSensorW.text = "4.4"
            //self.txtSensorH.text = "4.4"
            self.sensorSizeW.text = "4.4"
            self.sensorSizeH.text = "4.4"
            self.labelFrame.text = "\(selectedText)"
            self.myRect.transform = CGAffineTransform.identity
            self.btnCalcPush( self.newd )
        
            }
            if (index == 1)
            {
                self.pixelsW.text = "2749"
                self.pixelsH.text = "2199"
                //self.txtSensorW.text = "4.4"
                //self.txtSensorH.text = "4.4"
                self.sensorSizeW.text = "4.54"
                self.sensorSizeH.text = "4.54"
                self.labelFrame.text = "\(selectedText)"
                self.myRect.transform = CGAffineTransform.identity
                self.btnCalcPush( self.newd )
            }
            if (index == 2)
            {
                self.pixelsW.text = "5568"
                self.pixelsH.text = "3712"
                //self.txtSensorW.text = "4.4"
                //self.txtSensorH.text = "4.4"
                self.sensorSizeW.text = "4.2"
                self.sensorSizeH.text = "4.2"
                self.labelFrame.text = "\(selectedText)"
                self.myRect.transform = CGAffineTransform.identity
                self.btnCalcPush( self.newd )
            }
            if (index == 3)
            {
                self.pixelsW.text = "5496"
                self.pixelsH.text = "3672"
                //self.txtSensorW.text = "4.4"
                //self.txtSensorH.text = "4.4"
                self.sensorSizeW.text = "2.4"
                self.sensorSizeH.text = "2.4"
                self.labelFrame.text = "\(selectedText)"
                self.myRect.transform = CGAffineTransform.identity
                self.btnCalcPush( self.newd )
            }
            if (index == 4)
            {
                self.pixelsW.text = "1280"
                self.pixelsH.text = "1024"
                //self.txtSensorW.text = "4.4"
                //self.txtSensorH.text = "4.4"
                self.sensorSizeW.text = "5.2"
                self.sensorSizeH.text = "5.2"
                self.labelFrame.text = "\(selectedText)"
                self.myRect.transform = CGAffineTransform.identity
                self.btnCalcPush( self.newd )
            }
       }
        let teleOption = teleOptions()
        teleDropDown.optionArray = teleOption.scopes
        teleDropDown.optionIds = option.ids
        teleDropDown.isSearchEnable = false
        teleDropDown.rowBackgroundColor = UIColor.white
        teleDropDown.selectedRowColor = UIColor.lightGray
        teleDropDown.didSelect{(selectedText, index, id) in
            //self.valueLabel.text = "\(selectedText) index: \(index) id: \(id)"
            //self.valueLabel.text = "\(selectedText)"
            if (index == 0)
            {
                self.txtAperture.text = "203"
                self.txtF.text = "10"
                
                self.btnCalcPush( self.teleDropDown )
                
            }
            if (index == 1)
            {
                self.txtAperture.text = "203"
                self.txtF.text = "7"
                
                self.btnCalcPush( self.teleDropDown )
            }
            if (index == 2)
            {
                self.txtAperture.text = "203"
                self.txtF.text = "2.1"
                self.btnCalcPush( self.teleDropDown )
            }
            if (index == 3)
            {
                self.txtAperture.text = "203"
                self.txtF.text = "2.0"
                self.btnCalcPush( self.teleDropDown )
            }
            if (index == 4)
            {
                self.txtAperture.text = "80"
                self.txtF.text = "6.0"
                self.btnCalcPush( self.teleDropDown )
            }
        }
       
    }
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    @IBAction func rotatePiece(_ gestureRecognizer : UIRotationGestureRecognizer) {   // Move the anchor point of the view's layer to the center of the
        // user's two fingers. This creates a more natural looking rotation.
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view?.transform = gestureRecognizer.view!.transform.rotated(by: gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }}

    
    func integerW(from txtSensorW: UITextField) -> Double {
        guard let text = txtSensorW.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func integerH(from txtSensorH: UITextField) -> Double {
        guard let text = txtSensorH.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func integerFL(from txtFL: UITextField) -> Double {
        guard let text = txtFL.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func integerSW(from txtSensorSW: UITextField) -> Double {
        guard let text = txtSensorSW.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func integerSH(from txtSensorSH: UITextField) -> Double {
        guard let text = txtSensorSH.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func dblA(from txtAperture: UITextField) -> Double {
        guard let text = txtAperture.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func dblF(from txtF: UITextField) -> Double {
        guard let text = txtF.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func integerPW(from txtSensorPW: UITextField) -> Double {
        guard let text = txtSensorPW.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func integerPH(from txtSensorPH: UITextField) -> Double {
        guard let text = txtSensorPH.text, let number = Double(text) else {
            return 0
        }
        return number
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
   
}

