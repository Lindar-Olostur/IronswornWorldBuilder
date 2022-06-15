//
//  MotherView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 15.06.2022.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "rootView" {
                RootView()
            } else if viewRouter.currentPage == "homeView" {
                HomeView()
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
