//
//  ViewController.swift
//  PuentedelaVegaSnapchat
//
//  Created by Alexander Puente de la Vega on 14/10/24.
//
import FirebaseAuth
import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    print("Intentando Iniciar Sesión")
                    
                    if error != nil {
                        print("Se presentó el siguiente error: \(error?.localizedDescription ?? "Error desconocido")")
                        
                        // Intentar crear un nuevo usuario
                        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                            print("Intentando crear un usuario")
                            
                            if error != nil {
                                print("Se presentó el siguiente error al crear el usuario: \(error?.localizedDescription ?? "Error desconocido")")
                            } else {
                                print("El usuario fue creado exitosamente")
                                
                                // Agregar el email a la base de datos
                                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                                
                                // Crear y mostrar la alerta de creación de usuario
                                let alerta = UIAlertController(title: "Creación de Usuario", message: "Usuario: \(self.emailTextField.text!) se creó correctamente.", preferredStyle: .alert)
                                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                                })
                                
                                alerta.addAction(btnOK)
                                self.present(alerta, animated: true, completion: nil)
                            }
                        }
                    } else {
                        print("Inicio de sesión exitoso")
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                }
    

}

}
