//
//  ContentView.swift
//  Task Master
//
//  Created by Ty Janik on 5/2/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = [String]()

    //    @Query private var tasks: [Task] // TODO: Implement storage

    // Mocked data
    @State private var tasks: [Task] = [
        Task(name: "Dishes", dueDate: Date.now),
        Task(
            name: "Laundry",
            dueDate: Calendar.current.date(
                byAdding: .day,
                value: 7,
                to: Date.now
            )!
        ),
        Task(
            name: "Vacuum",
            dueDate: Calendar.current.date(
                byAdding: .day,
                value: 2,
                to: Date.now
            )!
        ),
        Task(
            name: "Clean the fridge",
            dueDate: Calendar.current.date(
                byAdding: .day,
                value: 31,
                to: Date.now
            )!
        ),
    ]

    private var tasksDueToday: [Task] {
        tasks.filter { task in
            task.isDueToday()
        }
    }

    // Tasks with day delta > 1 and <= 7
    private var tasksDueThisWeek: [Task] {
        tasks.filter { task in
            task.isDueThisWeek()
                && !task.isDueToday()
        }
    }

    private var tasksDueLater: [Task] {
        tasks.filter { task in
            task.isDueLater()
        }
    }

    @State private var showForm = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("Due Today")) {
                        TaskListView(
                            tasks: tasksDueToday,
                        )
                    }

                    Section(header: Text("Due This Week")) {
                        TaskListView(
                            tasks: tasksDueThisWeek,
                        )
                    }

                    Section("Due Later") {
                        TaskListView(
                            tasks: tasksDueLater,
                        )
                    }
                }
                .navigationDestination(for: Task.self) { selectedTask in
                    TaskFormView(task: selectedTask, onUpdate: updateTask)
                }
            }
            .navigationTitle("Task Master")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.spring(duration: 0.3)) {
                            showForm = true
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showForm) {
            TaskFormView(onCreate: createTask)
        }
    }

    private func dismissOverlay() {
        withAnimation(.easeOut(duration: 0.2)) {
            showForm = false
            print("Dismissing")
        }
    }

    private func createTask(task: Task) {
        tasks.append(task)
        dismissOverlay()
    }

    private func updateTask(task: Task) {
        for index in tasks.indices {
            if tasks[index].id == task.id {
                tasks[index] = task
                print("Updated task")
            }
        }
    }

}

#Preview {
    ContentView()
    //        .modelContainer(for: Task.self, inMemory: true) // NEEDED WHEN PERSISTING DATA
}
