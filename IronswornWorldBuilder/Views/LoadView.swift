//
//  LoadView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 05.05.2022.
//

import SwiftUI

struct LoadView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var campaign: Campaign
    @State private var files: [String] = []
    
    func directoryContents() -> [String] {
        let documentDirectoryPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let filemanager = FileManager.default
        let files = filemanager.enumerator(atPath: documentDirectoryPath)
        var list: [String] = []
        while let file = files?.nextObject() {
            list.append(file as! String)
        }
        return list
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(files, id: \.self) { file in
                    Text("\((file as NSString).deletingPathExtension)")
                        .onTapGesture { loadFile(id: file)
                        }
                }
                .onDelete(perform: deleteFile)
                
            }
            .onAppear {files = directoryContents()
            }
            .navigationBarTitle("List of campaigns", displayMode: .inline)
        }
    }
    
    func deleteFile(at offsets: IndexSet) {
        let documentDirectoryPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileUrl = URL(fileURLWithPath: documentDirectoryPath)
        guard let index = Array(offsets).first else { return }
        do {
            try FileManager.default.removeItem(at: fileUrl.appendingPathComponent("\(files[index])"))
        } catch {
          //error
        }
        files.remove(atOffsets: offsets)
    }
    
    func loadFile(id: String) {
        campaign.getData(file: id)
        self.presentationMode.wrappedValue.dismiss()
        campaign.writeToFile()
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView(campaign: Campaign())
    }
}
