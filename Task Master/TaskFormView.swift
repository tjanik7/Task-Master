//
//  NewTaskView.swift
//  Task Master
//
//  Created by Ty Janik on 5/2/26.
//

import SwiftUI

struct TaskFormView: View {
    @State private var newTask: Task
    @Binding var tasks: [Task]
    @Binding var showForm: Bool
    
    private let isEditMode: Bool
    
    // Init in create mode
    init(showForm: Binding<Bool>, tasks: Binding<[Task]>) {
        isEditMode = false
        newTask = Task()
        self._showForm = showForm
        self._tasks = tasks
        print("create")
    }
    
    // Init in edit mode
    init(showForm: Binding<Bool>, tasks: Binding<[Task]>, task: Task) {
        isEditMode = true
        newTask = task
        self._showForm = showForm
        self._tasks = tasks
        print("edit")
    }

    var body: some View {

        Form {
            Button("Save") {
                // TODO: Should this just be a callback defined in parent?
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
