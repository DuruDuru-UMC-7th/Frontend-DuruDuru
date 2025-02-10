//
//  CalendarView.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/10/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Date
    var onDateSelected: (Date) -> Void
    @Environment(\.dismiss) var dismiss

    init(initialDate: Date, onDateSelected: @escaping (Date) -> Void) {
        self._selectedDate = State(initialValue: initialDate)
        self.onDateSelected = onDateSelected
    }

    var body: some View {
        VStack {
            DatePicker("날짜를 선택하세요", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Button("확인") {
                onDateSelected(selectedDate)
                dismiss()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
