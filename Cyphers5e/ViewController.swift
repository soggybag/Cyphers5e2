//
//  ViewController.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 10/6/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController,
  MFMessageComposeViewControllerDelegate,
MFMailComposeViewControllerDelegate {
  
  
  var spellList: SpellList!
  var cypherString: String = ""
  var cypherAttributedString: NSAttributedString!
  var cypher: Cypher!
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var displayText: UITextView!
  @IBOutlet weak var sendBarButton: UIBarButtonItem!
  
  @IBAction func generateButtonTapped(sender: UIButton) {
    newCypher()
  }
  
  
  
  @IBAction func acknowledgmentTapped(sender: UIButton) {
    // http://slyflourish.com
    UIApplication.shared.openURL(NSURL(string: "http://slyflourish.com")! as URL)
  }
  
  
  
  
  // MARK: - IBActions
  
  @IBAction func sendButtonTapped(sender: UIBarButtonItem) {
    openSendCypherAlert()
  }
  
  
  
  // MARK: - Send Cypher Alert
  
  func openSendCypherAlert() {
    let alert = UIAlertController(title: "Send Cypher", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    let message = UIAlertAction(title: "Message", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
      self.messageCypher()
    }
    
    let email = UIAlertAction(title: "Email", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
      self.emailCypher()
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
    
    if MFMessageComposeViewController.canSendText() {
      alert.addAction(message)
    }
    if MFMailComposeViewController.canSendMail() {
      alert.addAction(email)
    }
    
    alert.addAction(cancel)
    
    present(alert, animated: true, completion: nil)
  }
  
  
  
  // TODO: - Show alert when messages fail
  
  func showErrorAlert(message: String) {
    
  }
  
  
  // MARK: - Send Email
  
  func emailCypher() {
    let mailVC = MFMailComposeViewController()
    mailVC.mailComposeDelegate = self
    mailVC.setToRecipients([])
    mailVC.setSubject("Cypher")
    mailVC.setMessageBody(cypher.getHTMLDescription(), isHTML: true)
    
    present(mailVC, animated: true, completion: nil)
  }
  
  
  // MARK: - Email Delegate 
  
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  
  func messageCypher() {
    let messageVC = MFMessageComposeViewController()
    messageVC.body = cypher.getPlainTextDescription()
    messageVC.recipients = []
    messageVC.messageComposeDelegate = self
    
    present(messageVC, animated: true, completion: nil)
  }
  
  
  
  // MARK: - Message Delegate method
  
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    switch result {
    case MessageComposeResult.cancelled :
      print("message canceled")
      
    case MessageComposeResult.failed :
      print("message failed")
      
    case MessageComposeResult.sent :
      print("message sent")
      
    default:
      break
    }
    controller.dismiss(animated: true, completion: nil)
  }
  
  
  
  // MARK: - New Cypher
  
  func newCypher() {
    /*
     // Get Cypher string
     let str = spellList.getCypher()
     let atr = stringToAttributedString(str)
     displayText.attributedText = atr
     
     cypherString = str
     cypherAttributedString = atr
     */
    
    let spell = spellList.getRandomSpellWeightedForLevel()
    let description = ObjectGenerator.getDescription()
    cypher = Cypher(name: "", objectDescription: description, spellEffect: spell)
    
    displayCypher()
    
    print("--------------------------------")
    print(cypher.getHTMLDescription())
    print(cypher.getPlainTextDescription())
  }
  
  
  func displayCypher() {
    displayText.attributedText = stringToAttributedString(str: cypher.getHTMLDescription())
  }
  
  
  
  // MARK: - String to Attributed String
  
  func stringToAttributedString(str: String) -> NSAttributedString {
    var html = str
    // while let range = html.rangeOfString("\n") {
    while let range = html.range(of: "\n") {
      html.replaceSubrange(range, with: "</br>")
      // html.replaceRange(range, with: "</br>")
    }
    
    html = "<span style='font-family: Helvetica; font-size:14pt'>"+html+"</span>"
    let data = html.data(using: String.Encoding.unicode, allowLossyConversion: true)
    let attrStr = try! NSAttributedString(data: data!, options: [NSDocumentTypeDocumentOption: NSHTMLTextDocumentType], documentAttributes: nil)
    return attrStr
  }
  
  
  
  // MARK: - Check SMS and Mail capability
  
  func checkMessageAndMailCapability() {
    if !MFMessageComposeViewController.canSendText() && !MFMailComposeViewController.canSendMail() {
      sendBarButton.isEnabled = false
    }
  }
  
  
  
  // MARK: - Set gradient background
  
  func setGradientBackground() {
    let colorA = UIColor(white: 0.92, alpha: 1.0).cgColor as CGColor
    let colorB = UIColor(white: 0.85, alpha: 1.0).cgColor as CGColor
    
    let gl = CAGradientLayer()
    gl.colors = [colorA, colorB]
    gl.locations = [0.0, 1.0]
    gl.frame = view.bounds
    
    view.layer.insertSublayer(gl, at: 0)
  }
  
  
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setGradientBackground()
    spellList = SpellList()
    newCypher()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}




// MARK: - Extensions

extension String {
  func stringToAttributedString() -> NSAttributedString {
    var html = self
    while let range = html.rangeOfString("\n") {
      html.replaceRange(range, with: "</br>")
    }
    
    html = "<span style='font-family: Helvetica; font-size:14pt'>"+html+"</span>"
    let data = html.data(using: String.Encoding.unicode, allowLossyConversion: true)
    let attrStr = try! NSAttributedString(data: data!, options: [NSDocumentTypeDocumentOption: NSHTMLTextDocumentType], documentAttributes: nil)
    return attrStr
  }
}


extension CAGradientLayer {
  func turquoiseColor() -> CAGradientLayer {
    let topColor = UIColor(red: (15/255.0), green: (118/255.0), blue: (128/255.0), alpha: 1)
    let bottomColor = UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1)
    
    let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
    let gradientLocations: [Float] = [0.0, 1.0]
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.colors = gradientColors
    gradientLayer.locations = gradientLocations as [NSNumber]
    
    return gradientLayer
  }
  
  /*
   func simpleGradientWithColors(colors: [CGColor], and locations: [Float]) -> CAGradientLayer {
   let gradientColors: [CGColor] = colors
   let gradientLocations: [Float] = locations
   
   let gradientLayer: CAGradientLayer = CAGradientLayer()
   gradientLayer.colors = gradientColors
   gradientLayer.locations = gradientLocations
   
   return gradientLayer
   }
   */
}
