//
//  NewTaskView.swift
//  Task Master
//
//  Created by Ty Janik on 5/2/26.
//

import SwiftUI

struct NewTaskView: View {
    @State private var newTask = Task()
    @Binding var tasks: [Task]
    @Binding var showForm: Bool

    var body: some View {

        Form {
            Button("Save") {
                tasks.append(newTask)
                showForm = false
            }
            TextField("Name", text: $newTask.name)
            DatePicker("Due date", selection: $newTask.dueDate)
            LabeledContent("Every") {
                TextField("Every", value: $newTask.frequency.value, format: .number)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
            }
            Picker("Units", selection: $newTask.frequency.unit) {
                ForEach(FrequencyUnit.allCases) { freq in
                    Text(freq.rawValue.capitalized)
                        .tag(freq)
                }
            }
        }
    }
}
