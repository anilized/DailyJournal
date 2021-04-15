//
//  EntryViewController.swift
//  DailyJournal
//
//  Created by Anil Can on 15.04.2021.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {

    
    var entry: Entry?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var entryDateVar: UIDatePicker!
    @IBOutlet weak var entryDescVar: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Notification observer

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if entry == nil {
            // Create
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                // MARK: - Saving to Core Data
                entry = Entry(context: context)
                entry?.date = entryDateVar.date
                entry?.text = entryDescVar.text
                entryDescVar.becomeFirstResponder()
            }
        }
        
        entryDescVar.text = entry?.text
        entryDescVar.becomeFirstResponder()
        if let entryDate = entry?.date {
            entryDateVar.date = entryDate
        }
        
        entryDescVar.delegate = self
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext() // saved
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        // Function for getting keyboard height and adjust keyboard based on textView's height
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomConstraint.constant = keyboardHeight
        }
    }
    
    @IBAction func deleteEntry(_ sender: Any) {
        
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(entry!)
                try? context.save()
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = entryDescVar.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        entry?.date = entryDateVar.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    
    
}
