//
//  TaskListView.swift
//  Task Master
//
//  Created by Ty Janik on 6/28/26.
//

import SwiftUI

struct TaskListView: View {
    let headerText: String
    let tasks: [Task]
    let updateTask: (Task) -> Void
    
    private var sortedTasks: [Task] {
        tasks.sorted { $0.dueDate < $1.dueDate }
    }
    
    var body: some View {
        Text(headerText)
        List(sortedTasks) { task in
            NavigationLink(value: task) {
                // Format task for row display
                HStack {
                    Text(task.name)
                        .font(.headline)

                    Spacer()

                    Text(task.dueDate.formatted())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationDestination(for: Task.self) { selectedTask in
            TaskFormView(task: selectedTask, onUpdate: updateTask)
        }
    }
}
