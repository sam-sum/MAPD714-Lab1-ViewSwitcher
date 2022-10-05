//
//  SwitchingViewController.swift
//  View Switcher
//
//  Created by Samuel Sum on 2022-10-03.
//

import UIKit

class SwitchingViewController: UIViewController {

    var blueViewController: BlueViewController?
    var yellowViewController: YellowViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blueViewController = storyboard?.instantiateViewController(withIdentifier: "Blue") as? BlueViewController
        
        blueViewController?.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)
    }

    @IBAction func switchViews(_ sender: UIBarButtonItem) {
        // Create the new view controller, if required
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController =
                    storyboard?.instantiateViewController(withIdentifier: "Yellow")
                    as? YellowViewController
            }
        } else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController =
                    storyboard?.instantiateViewController(withIdentifier: "Blue")
                    as? BlueViewController
            }
        }

        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        // Switch view controllers
        if blueViewController != nil
            && blueViewController!.view.superview != nil {
            yellowViewController?.view.frame = view.frame
            switchViewController(from: blueViewController,
                                 to: yellowViewController)
        } else {
            blueViewController?.view.frame = view.frame
            switchViewController(from: yellowViewController,
                                 to: blueViewController)
        }
        UIView.commitAnimations()
    }
    
    private func switchViewController(from fromVC:UIViewController?,
                                          to toVC:UIViewController?) {
            if fromVC != nil {
                fromVC!.willMove(toParent: nil)
                fromVC!.view.removeFromSuperview()
                fromVC!.removeFromParent()
            }
            
            if toVC != nil {
                self.addChild(toVC!)
                self.view.insertSubview(toVC!.view, at: 0)
                toVC!.didMove(toParent: self)
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
