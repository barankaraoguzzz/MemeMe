//
//  UIResponse+Utilies.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 26.02.2021.
//

import UIKit

extension UIResponder {

    static weak var responder: UIResponder?

    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }

    @objc private func trap() {
        UIResponder.responder = self
    }
}
