//
//  NewTaskView.swift
//  Task Master
//
//  Created by Ty Janik on 5/2/26.
//

import SwiftUI

struct TaskFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var newTask: Task
    let onSave: (Task) -> Void
    
    private let isEditMode: Bool
    
    // Init in create mode
    init(onCreate: @escaping (Task) -> Void) {
        isEditMode = false
        newTask = Task()
        self.onSave = onCreate
        print("create")
    }
    
    // Init in edit mode
    init(task: Task, onUpdate: @escaping (Task) -> Void) {
        isEditMode = true
        newTask = task
        self.onSave = onUpdate
        print("edit")
    }

    var body: some View {
        
        Form {
            Button("Save") {
                onSave(newTask)
                
                if (isEditMode) {
                    dismiss()
                }
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
