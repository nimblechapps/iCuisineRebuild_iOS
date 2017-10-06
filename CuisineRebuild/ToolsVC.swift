//
//  ToolsTVC.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 04/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import UIKit

class ToolsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    
    @IBOutlet weak var tableViewTools : UITableView!
    
    @IBOutlet weak var btnWiKey : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BLEHelper.sharedInstance.update { (char) in
            self.tableViewTools.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    @IBAction func wiKeyTapped(){
      
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToolsArray.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch ToolsArray[indexPath.row] {
        case _kSmallCuttingBoard:
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
            
        case _kSpatula:
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
