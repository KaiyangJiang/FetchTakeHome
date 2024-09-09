import SwiftUI

struct InstructionsView: View {
    let instructions: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.headline)
                .padding(.bottom, 5)
            
            Text(instructions)
        }
        .padding()
    }
}
