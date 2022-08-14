
 
import SwiftUI
  
struct CustomTabBar : View {
      
    @Binding var index : Int
      
    var body: some View {
          
        HStack(spacing: 30) {
              
            HStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 30)
                  
                Text(self.index == 0 ? "Daily Medication" : "")
                    .fontWeight(.light)
                    .font(.system(size:14))
            }.padding(30)
            .background(self.index == 0 ? Color.pink.opacity(0.5) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 0
            }
              
            HStack {
                Image(systemName: "doc.text.magnifyingglass")
                    .resizable()
                    .frame(width: 35, height: 30)
                  
                Text(self.index == 1 ? "Database" : "")
                    .fontWeight(.light)
                    .font(.system(size:14))
            }.padding(30)
            .background(self.index == 1 ? Color.blue.opacity(0.5) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 1
            }
              
            
              
        }.padding(.top, 8)
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        
    }
}
 
struct CustomTabBar_Previews: PreviewProvider {
    @State static var index = 0
    static var previews: some View {
        CustomTabBar(index: $index)
    }
}
