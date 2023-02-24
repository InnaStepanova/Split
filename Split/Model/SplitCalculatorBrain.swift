//
//  SplitCalculatorBrain.swift
//  Split
//
//  Created by Лаванда on 23.02.2023.
//

import UIKit

struct SplitCalculatorBrain {
    
    var split: SplitCalculator?

    mutating func calculateSplitSumma(qtyPerson: Double, summ: Double, tip: Int) -> SplitCalculator? {
        let summ = (summ + Double(tip) * summ / 100.0) / qtyPerson
        
        split = SplitCalculator(summ: summ, tip: tip, qtyPerson: qtyPerson)
        return split
    }
}
