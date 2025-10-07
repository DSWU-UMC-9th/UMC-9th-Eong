//
//  SegmentButtons.swift
//  Megabox
//
//  Created by 권예원 on 10/6/25.
//

import SwiftUI

struct SegmentButtons: View {
    enum Section: String, CaseIterable {
        case chart = "무비차트"
        case upcoming = "상영예정"
    }
    @Binding var selected: Section

    var body: some View {
        HStack(spacing: 23) {
            ForEach(Section.allCases, id: \.self) { section in
                            RoundedButton(
                                title: section.rawValue,
                                isSelected: selected == section
                            ) {
                                selected = section
                            }
                        }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RoundedButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.PretendardMedium14)
                .foregroundStyle(isSelected ? .white : .gray04)
                .padding(.horizontal, 20)
                .padding(.vertical, 6)
                .frame(height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 1000)
                        .fill(isSelected ? .gray08 : .gray02)
                )
        }
    }
}


#Preview {
    @Previewable @State var selected: SegmentButtons.Section = .chart

    return SegmentButtons(selected: $selected)
}
