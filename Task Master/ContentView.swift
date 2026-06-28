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
        )
    ]

    private var sortedTasks: [Task] {
        tasks.sorted { $0.dueDate < $1.dueDate }
    }
    
    private func isToday(d: Date) -> Bool {
        Calendar.current.isDate(d, inSameDayAs: Date.now)
    }

    private var tasksDueToday: [Task] {
        tasks.filter { task in
            isToday(d: task.dueDate)
        }
    }
    
    private func isThisWeek(earlier: Date, later: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: earlier, to: later)
        
        if let days = components.day {
            return days <= 7
        }
        
        return false
    }
    
    // Tasks with day delta > 1 and <= 7
    private var tasksDueThisWeek: [Task] {
        tasks.filter { task in
            isThisWeek(earlier: Date.now, later: task.dueDate) && !isToday(d: task.dueDate)
        }
    }
    
    // Tasks with day delta > 7
    private func isLater(d: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date.now, to: d)
        
        if let days = components.day {
            return days > 7
        }
        
        return false
    }
    
    private var tasksDueLater: [Task] {
        tasks.filter { task in
            isLater(d: task.dueDate)
        }
    }

    @State private var showForm = false

    var body: some View {
        NavigationStack {
            Button("+") {
                withAnimation(.spring(duration: 0.3)) {
                    showForm = true
                }
            }
            
            Text("Due Today")
            List(tasksDueToday) { task in
                NavigationLink(value: task) {
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
            
            Text("Due This Week")
            List(tasksDueThisWeek) { task in
                NavigationLink(value: task) {
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
            
            Text("Due Later")
            List(tasksDueLater) { task in
                NavigationLink(value: task) {
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
            .navigationDestination(for: Task.self) { selectedTask in
                TaskFormView(task: selectedTask, onUpdate: updateTask)
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
