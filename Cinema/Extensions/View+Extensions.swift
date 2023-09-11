//
//  View+Extensions.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 11.09.23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func redacted(if condition: @autoclosure () -> Bool) -> some View {
        redacted(reason: condition() ? .placeholder : [])
    }
}
