//
//  ViewController.swift
//  Practica6-WebServices
//
//  Created by Yola on 26/09/18.
//  Copyright © 2018 Yola. All rights reserved.
//

import UIKit

class UserViewController: UIViewController{
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLng: UILabel!
    @IBOutlet weak var lblCalle: UILabel!
    @IBOutlet weak var lblCiudad: UILabel!
    @IBOutlet weak var lblZip: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var usuario: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        lblName.text = usuario?.name
        lblEmail.text = usuario?.email
        lblPhone.text = usuario?.phone
        lblLat.text = usuario?.lat.description
        lblLng.text = usuario?.lng.description
        lblCalle.text = usuario?.street
        lblCiudad.text = usuario?.city
        lblZip.text = usuario?.zip
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func showMap(_ sender: UIButton) {
        performSegue(withIdentifier: "map", sender: self)
    }
    @IBAction func ImportarImagen(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MapViewController
        destination.name = self.usuario?.name
        destination.lat = self.usuario?.lat
        destination.lng = self.usuario?.lng
    }
    

}

extension UserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            myImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}

