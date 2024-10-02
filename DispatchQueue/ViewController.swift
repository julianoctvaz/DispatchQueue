//
//  ViewController.swift
//  DispatchQueue
//
//  Created by Juliano on 02/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
//        doEmojiThings()
//        doAnotherThing()
//        eachQueueIsIt()
    }

//    override func loadView() {
//    }

//    override func viewIsAppearing(_ animated: Bool) {
//        doSomething()
//    }

    
//    override func viewWillAppear(_ animated: Bool) {
//        doSomething()
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        doSomething()
//    }
        
    func doEmojiThings() {
        
        Dispatch.DispatchQueue.global(qos: .background).async {
            for i in 0...5 {
                print("😈 \(i)")
            }
        }
        
        Dispatch.DispatchQueue.global(qos: .userInteractive).async {
            for i in 0...5 {
                print("😢 \(i)")
            }
        }
    }
    
    func doSomething() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            print("A")
        }

        DispatchQueue.main.async {
            print("B")
        }

        DispatchQueue.global().async {
            print("C")
        }

        print("D")
    }
    
    func eachQueueIsIt() {
        let queue = DispatchQueue(label: "queue")
        queue.async {
            print("Running on background thread? \(Thread.isMainThread)") // false
        }

        DispatchQueue.main.async {
            print("Running on main thread? \(Thread.isMainThread)") // true
        }
    }
    
    func doAnotherThing() {
        
        let queue = DispatchQueue(label: "queue")
        //queue é uma fila serial, e por padrão, filas criadas dessa maneira são executadas em uma thread de fundo (background thread), a menos que seja especificado o contrário, isto é, da forma cocmo está, a gente está sem especificar o parâmetro qos (Quality of Service) ou attributes
        
        let viewA = UIView()
        let viewB = UIView()
        viewA.tag = 1
        viewB.tag = 2
        
        let view = viewA
        
        queue.async { [view] in
            print(view.tag)
//            Todas as operações que envolvem modificações ou leituras de UI precisam ocorrer na main thread
            //O erro Main Thread Checker: UI API called on a background thread) ocorre porque você está tentando acessar uma propriedade da interface do usuário (UIView.tag) a partir de uma thread de background, o que não é permitido em iOS.
            
            //Se você quisermos executar essa fila na thread principal, teríamos que usar explicitamente DispatchQueue.main, que é a fila dedicada às operações de interface de usuário.
            
            //Operações que não envolvem a UI (como cálculos ou operações de rede) são geralmente movidas para filas em threads de fundo para evitar bloqueios na thread principal.
        }
    }
}
