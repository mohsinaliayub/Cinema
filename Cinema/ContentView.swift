//
//  ContentView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    var body: some View {
        DashboardView(animation: animation)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DashboardViewModel(tmdb: DummyTMDBService()))
    }
}
