import SwiftUI

struct AdaptiveNavigationView<Sidebar: View, Detail: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let title: String
    @ViewBuilder let sidebar: () -> Sidebar
    @ViewBuilder let detail: () -> Detail

    var body: some View {
        if horizontalSizeClass == .regular {
            NavigationSplitView {
                sidebar()
                    .navigationTitle(title)
            } detail: {
                detail()
            }
        } else {
            NavigationStack {
                sidebar()
                    .navigationTitle(title)
            }
        }
    }
}
