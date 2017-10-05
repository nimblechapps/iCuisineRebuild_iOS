//
//  ToolsTVC.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 04/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import UIKit

class ToolsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,ToolBarDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var tableViewTools : UITableView!
    var toolBar : TextToolBarView!
    
    @IBOutlet weak var btnWiKey : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toolBar = TextToolBarView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        self.toolBar.toolBarDelegate = self
        self.toolBar.textField?.delegate = self
        
        BLEHelper.sharedInstance.update { (char) in
            self.tableViewTools.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func wiKeyTapped(){
        
        if let textFld = self.toolBar.textField{
            textFld.becomeFirstResponder()
            textFld.inputAccessoryView = self.toolBar
            
        }
    }
    
    func doneTapped(textInput : String){
        if let textFld = self.toolBar.textField{
            textFld.resignFirstResponder()
        }
    }
    func cancelTapped(){
        if let textFld = self.toolBar.textField{
            textFld.resignFirstResponder()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallCuttingBoardCell", for: indexPath) as! SmallCuttingBoardCell
            
            let smallCuttingBoard = SmallCuttingBoardTool.sharedInstance
            
            cell.labelToolName.text = smallCuttingBoard.toolName
            cell.labelToolWeight.text = smallCuttingBoard.toolCurrentWeightString
            cell.labelToolTargetWeight.text  = smallCuttingBoard.toolTargetWeightString
            
            if smallCuttingBoard.toolIsConnected ==  true{
                cell.fullScreenView.backgroundColor = _kThemeRed
                cell.imageContainerView.backgroundColor = _kThemeRed
                cell.containerView.connectedShadow()
            }
            else{
                cell.fullScreenView.backgroundColor = _kBackgroundGrey
                cell.imageContainerView.backgroundColor = _kBackgroundGrey
                cell.containerView.disconnectedShadow()
            }
            
            if smallCuttingBoard.toolIsExpanded == true{
                cell.buttonExpandContract.connectedGlow()
            }
            else{
                cell.buttonExpandContract.disconnectedGlow()
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpatulaCell", for: indexPath) as! SpatulaCell
            
            let spatula = SpatulaTool.sharedInstance
            
            cell.labelToolName.text = spatula.toolName
            cell.labelToolTemperature.text = spatula.toolCurrentTemperatureString
            cell.labelToolTargetTemperature.text  = spatula.toolTargetTemperatureString
            
            if spatula.toolIsConnected ==  true{
                cell.fullScreenView.backgroundColor = _kThemeRed
                cell.imageContainerView.backgroundColor = _kThemeRed
                cell.containerView.connectedShadow()
            }
            else{
                cell.fullScreenView.backgroundColor = _kBackgroundGrey
                cell.imageContainerView.backgroundColor = _kBackgroundGrey
                cell.containerView.disconnectedShadow()
            }
            
            if spatula.toolIsExpanded == true{
                cell.buttonExpandContract.connectedGlow()
            }
            else{
                cell.buttonExpandContract.disconnectedGlow()
            }
            
            if let endDate = spatula.toolTimerEndDate{
                
                let timeAndStatus = DateHelpers.getFormattedTimeRemaining(dueDate: endDate)
                
                if timeAndStatus.isComplete == true{
                   cell.labelTimer.text = "00:00"
                   cell.buttonSetTimer.disconnectedGlow()
                   spatula.toolTimerEndDate = nil
                }
                else{
                    cell.buttonSetTimer.connectedGlow()
                    cell.labelTimer.text = timeAndStatus.formattedTime
                }
            }
            else{
                cell.labelTimer.text = ""
            }
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "Cell")!
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let smallCuttingBoard = SmallCuttingBoardTool.sharedInstance
        if smallCuttingBoard.toolIsExpanded == true{
            return tableViewTools.frame.size.height
        }
        else{
            return 200.0
        }
    }
    
    
    
}
