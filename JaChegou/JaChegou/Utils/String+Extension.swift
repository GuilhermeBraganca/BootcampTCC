//
//  String+Extension.swift
//  JaChegou
//
//  Created by MacBook on 07/11/24.
//

extension String {
    func trimLeft() -> String {
        guard let range = rangeOfCharacter(from: .whitespacesAndNewlines.inverted) else {
            return ""
        }
        return String(self[range.lowerBound...])
    }
}
