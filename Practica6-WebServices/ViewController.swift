//
//  ViewController.swift
//  Practica6-WebServices
//
//  Created by Yola on 26/09/18.
//  Copyright © 2018 Yola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usuarios = [Usuario]()
    var usuario: Usuario?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        //String de la url del servicio
        let urlString = "https://jsonplaceholder.typicode.com/users"
        //Objeto url
        let url = URL(string: urlString)
       
        //Tarea de petición
        let peticion = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //Verificar si existe algún error
            if(error != nil){
                print("Error: \(String(describing: error))")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    //print(json)
                    //Llenado de contenedor local (usuarios)
                    for user in json{
                        //Extraer la info
                        let name = user["name"] as! String
                        let email = user["email"] as! String
                        let phone = user["phone"] as! String
                        let address = user["address"] as! [String: AnyObject]
                        let street = address["street"] as! String
                        let city = address["city"] as! String
                        let zip = address["zipcode"] as! String
                        let geo = address["geo"] as! [String: AnyObject]
                        let lat = Double(geo["lat"] as! String)
                        let lng = Double(geo["lng"] as! String)
                        print(address)
                        //Agregar info al arreglo
                        self.usuarios.append(Usuario(name: name, email: email, phone: phone, lat: lat!, lng: lng!, street: street, city: city, zip: zip))
                    }
                    
                    //Refrescar la tabla
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }
        
        peticion.resume()
        
        
        
        
        
        
        
        
        /*
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [[String : AnyObject]]
                    print(json)
                    
                    
                    OperationQueue.main.addOperation({
                        //self.tableView.reloadData()
                    })
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usuario")
        
        cell?.textLabel?.text = usuarios[indexPath.row].name
        cell?.detailTextLabel?.text = usuarios[indexPath.row].email
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usuario = usuarios[indexPath.row]
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UserViewController
        destination.usuario = self.usuario
    }

}

class Usuario {
    var name: String
    var email: String
    var phone: String
    var lat: Double
    var lng: Double
    var street: String
    var city: String
    var zip: String
    
    init(name: String, email:String, phone: String, lat: Double, lng: Double, street: String, city: String, zip: String){
        self.name = name
        self.email = email
        self.phone = phone
        self.lat = lat
        self.lng = lng
        self.street = street
        self.city = city
        self.zip = zip
    }
}





