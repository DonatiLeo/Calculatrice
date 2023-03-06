//
//  Cerveau.swift
//  Calculatrice
//
//  Created by donati on 06/03/2023.
//

import Foundation

class Cerveau : CustomStringConvertible {
    var description: String {
        return pileDOp.description
    }
    
    var pileDOp = [Op]()
    var operationsConnues = [String : Op]()
    
    enum Op : CustomStringConvertible {
        var description: String {
            switch self {
            case .Operande(let val):
                return "\(val)"
            case .OperationUnaire(let name, _):
                return name
            case .OperationBinaire(let name, _):
                return name
            }
        }
        
        case OperationUnaire (String, (Double) -> Double)
        case OperationBinaire (String, (Double, Double) -> Double)
        case Operande (Double)
    }
    
    func push(operande: Double) {
        pileDOp.append(Op.Operande(operande))
    }
    
    func push(nomOperation: String) {
        if let op = operationsConnues[nomOperation]  {
            pileDOp.append(op)
        }
    }
    
    func evaluate() -> Double? {
        let (res, _) = evaluate(pileDOp)
        return res;
    }
    
    func evaluate(_ ops: [Op]) -> (resultat : Double?, resteSurPile: [Op]) {
        if ops.isEmpty {
            return (nil, ops)
        }
        var remainOps = ops
        let op = remainOps.removeLast()
        switch op {
        case .Operande(let valeur):
            return (valeur, remainOps)
        case .OperationUnaire(_, let op):
            let res : Double?
            (res , remainOps) = evaluate(remainOps)
            if res != nil {
                return (op(res!), remainOps )
            }
            else {
                return (nil, remainOps)
            }
        case .OperationBinaire(_, let op):
            let res1, res2 : Double?
            (res1 , remainOps) = evaluate(remainOps)
            (res2 , remainOps) = evaluate(remainOps)
            if (res1 != nil && res2 != nil) {
                return (op(res1!, res2!), remainOps )
            }
            else {
                return (nil, remainOps)
            }
        }
    }
    
    init() {
        operationsConnues["+"] = Op.OperationBinaire("+"){$0 + $1}
        operationsConnues["×"] = Op.OperationBinaire("×"){$0 * $1}
        operationsConnues["-"] = Op.OperationBinaire("-"){$1 - $0}
        operationsConnues["÷"] = Op.OperationBinaire("÷"){$1 / $0}
        operationsConnues["√"] = Op.OperationUnaire("√"){ sqrt($0)}
    }
}
