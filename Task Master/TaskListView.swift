//
//  TaskListView.swift
//  Task Master
//
//  Created by Ty Janik on 6/28/26.
//

import SwiftUI

struct TaskListView: View {
    let tasks: [Task]
    
    private var sortedTasks: [Task] {
        tasks.sorted { $0.dueDate < $1.dueDate }
    }
    
    var body: some View {
        ForEach(sortedTasks) { task in
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
    }
}
