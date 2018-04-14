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
  
  // MARK: - Public vars
  
  var spellList: SpellList!
  var cypherString: String = ""
  var cypherAttributedString: NSAttributedString!
  var cypher: Cypher!
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var displayText: UITextView!
  @IBOutlet weak var sendBarButton: UIBarButtonItem!
  
  
  // MARK: - IBActions
  
  @IBAction func generateButtonTapped(sender: UIButton) {
    newCypher()
  }
  
  
  @IBAction func acknowledgmentTapped(sender: UIButton) {
    // http://slyflourish.com
    UIApplication.shared.openURL(NSURL(string: "http://slyflourish.com")! as URL)
  }
  
  
  @IBAction func sendButtonTapped(sender: UIBarButtonItem) {
    openSendCypherAlert()
  }
  
  
  // Mark: - Public Methods
  
  // Open Send Cypher/Relic Alert
  
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
  
  
  // Send Email
  
  func emailCypher() {
    let mailVC = MFMailComposeViewController()
    mailVC.mailComposeDelegate = self
    mailVC.setToRecipients([])
    mailVC.setSubject("Cypher")
    mailVC.setMessageBody(cypher.getHTMLDescription(), isHTML: true)
    
    present(mailVC, animated: true, completion: nil)
  }
  
  
  // Email Delegate
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  
  // Message
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
      
    }
    controller.dismiss(animated: true, completion: nil)
  }
  
  // Check SMS and Mail capability
  
  func checkMessageAndMailCapability() {
    if !MFMessageComposeViewController.canSendText() && !MFMailComposeViewController.canSendMail() {
      sendBarButton.isEnabled = false
    }
  }
  
  
  
  
  // MARK: - New Cypher
  
  
  
  func newCypher() {
    let spell = spellList.getRandomSpellWeightedForLevel()
    let description = ObjectGenerator.getDescription()
    cypher = Cypher(name: "", objectDescription: description, spellEffect: spell)
    
    print(cypher)
    
    displayCypher()
  }
  
  
  func displayCypher() {
    displayText.attributedText = cypher.getHTMLDescription().html2Attributed
  }
  
  
  
  // String to Attributed String
  
  func stringToAttributedString(str: String) -> NSAttributedString {
    var html = str
    
    while let range = html.range(of: "\n") {
      html.replaceSubrange(range, with: "</br>")
    }
    
    html = "<span style='font-family: Helvetica; font-size:14pt'>"+html+"</span>"
    
    let attrStr = NSAttributedString(string: html)
    
    return attrStr
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
    
    displayText.font = UIFont.boldSystemFont(ofSize: 20)
    
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

//extension String {
//  func stringToAttributedString() -> NSAttributedString {
//    var html = self
//    while let range = html.rangeOfString("\n") {
//      html.replaceRange(range, with: "</br>")
//    }
//
//    html = "<span style='font-family: Helvetica; font-size:14pt'>"+html+"</span>"
//    let data = html.data(using: String.Encoding.unicode, allowLossyConversion: true)
//    let attrStr = try! NSAttributedString(data: data!, options: [NSDocumentTypeDocumentOption: NSHTMLTextDocumentType], documentAttributes: nil)
//    return attrStr
//  }
//}

extension String {
  var stringToAttributedString: NSAttributedString? {
    do {
      guard let data = data(using: String.Encoding.utf8) else {
        return nil
      }
      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      print("error: ", error)
      return nil
    }
  }
}

extension String {
  var html2Attributed: NSAttributedString? {
    do {
      guard let data = data(using: String.Encoding.utf8) else {
        return nil
      }
      let attStr = try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
      
      // ----------------
      
      let newAttributedString = NSMutableAttributedString(attributedString: attStr)
      
      // Enumerate through all the font ranges
      newAttributedString.enumerateAttribute(NSAttributedStringKey.font, in: NSMakeRange(0, newAttributedString.length), options: [])
      {
        value, range, stop in
        guard let currentFont = value as? UIFont else {
          return
        }
        
        // An NSFontDescriptor describes the attributes of a font: family name, face name, point size, etc.
        // Here we describe the replacement font as coming from the "Hoefler Text" family
        let fontDescriptor = currentFont.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.family: "Hoefler Text"])
        
        // Ask the OS for an actual font that most closely matches the description above
        if let newFontDescriptor = fontDescriptor.matchingFontDescriptors(withMandatoryKeys: [UIFontDescriptor.AttributeName.family]).first {
          // let newFont = UIFont(descriptor: newFontDescriptor, size: currentFont.pointSize)
          let newFont = UIFont(descriptor: newFontDescriptor, size: currentFont.pointSize * 2)
          newAttributedString.addAttributes([NSAttributedStringKey.font: newFont], range: range)
        }
      }
      
      // label.attributedText = newAttributedString
      
      // ----------------
      
      // let font = UIFont.boldSystemFont(ofSize: 24)
      
      return newAttributedString
      // return attStr
    } catch {
      print("error: ", error)
      return nil
    }
  }
}

//extension String{
//  func convertHtml() -> NSAttributedString{
//    guard let data = data(using: .utf8) else { return NSAttributedString() }
//    do{
//      return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
//    }catch{
//      return NSAttributedString()
//    }
//  }
//}


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
