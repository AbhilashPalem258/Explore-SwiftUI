//
//  TaskBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 02/11/22.
//

import Foundation
import SwiftUI
import Combine
/*
 - Task cancellation
 - Task Priority
 - Task Detached, child tasks
 - Task Yield
 */

/*
 Source:
 - https://www.hackingwithswift.com/quick-start/concurrency/how-to-get-a-result-from-a-task
 - https://www.hackingwithswift.com/quick-start/concurrency/how-to-cancel-a-task
 
 Definition:
 
 - func withTaskCancellationHandler<T>(operation: () async throws -> T, onCancel handler: @Sendable () -> Void) async rethrows -> T
 
 
 Notes:
 - If priority is not specified, TaskPriority.Medium is used.
 - Tasks can start running immediately after creation; you don’t explicitly start or schedule them
 -  if you discard the reference to a task, you give up the ability to wait for that task’s result or cancel the task
 - Only code that’s running as part of the task can interact with that task. To interact with the current task, you call one of the static methods on Task
 - Task.yield(): Suspends the current task and allows other tasks to execute. A task can voluntarily suspend itself in the middle of a long-running operation that doesn’t contain any suspension points, to let other tasks run for a while before execution returns to this task.
 - Don’t use a detached task if it’s possible to model the operation using structured concurrency features like child tasks. Child tasks inherit the parent task’s priority and task-local storage, and canceling a parent task automatically cancels all of its child tasks. You need to handle these considerations manually with a detached task.
 - Task.cancel() method. Discarding your reference to a detached task doesn’t implicitly cancel that task, it only makes it impossible for you to explicitly cancel the task.
 
 Task Cancellation:
 
 -  Likewise, it’s the responsibility of the code running as part of the task to check for cancellation whenever stopping is appropriate. In a long-task that includes multiple pieces, you might need to check for cancellation at several points, and handle cancellation differently at each point. If you only need to throw an error to stop the work, call the Task.checkCancellation() function to check for cancellation.
 
 - Cancellation is a purely Boolean state; there’s no way to include additional information like the reason for cancellation. This reflects the fact that a task can be canceled for many reasons, and additional reasons can accrue during the cancellation process.
 */

extension String: Error {}

fileprivate struct DataManager {
    
    private let url = URL(string: "https://picsum.photos/200")!
    
    func fetchImage() async throws -> Data {
       let (data, response) = try await URLSession.shared.data(from: url)
        if let statuscode = (response as? HTTPURLResponse)?.statusCode,
           statuscode >= 200 && statuscode < 300,
           response.mimeType == "image/jpeg" {
            return data
        } else {
            throw URLError(.badURL)
        }
    }
}

fileprivate class ViewModel: ObservableObject {
    let dataManager: DataManager
    
    @MainActor @Published var images = [UIImage]()
    @MainActor @Published var taskDescriptions = [String]()
    
    init(dataManager: DataManager = DataManager()){
        self.dataManager = dataManager
    }
    
    func fetchImage() async {
        do {
            let data = try await dataManager.fetchImage()
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.images.append(image)
                }
            } else {
                throw "Bad Image"
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchTaskdescription(priority: (String, TaskPriority)) {
        Task(priority: priority.1) {
            if priority.0 == "High" {
                // - Task.yield(): Suspends the current task and allows other tasks to execute. A task can voluntarily suspend itself in the middle of a long-running operation that doesn’t contain any suspension points, to let other tasks run for a while before execution returns to this task.
                await Task.yield()
            }
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            let thread = Thread.current.description
            let taskPriority = Task.currentPriority.rawValue
            await MainActor.run {
                self.taskDescriptions.append("[\(priority.0)] Thread: \(thread), TaskPriority: \(taskPriority)")
            }
        }
    }
    
    func fetchChildTaskExploration(priority: TaskPriority) {
        Task(priority: priority) {
            let thread = Thread.current.description
            let taskPriority = Task.currentPriority.rawValue
            await MainActor.run {
                self.taskDescriptions.append("Thread: \(thread), TaskPriority: \(taskPriority)")
            }
            Task {
                let thread = Thread.current.description
                let taskPriority = Task.currentPriority.rawValue
                await MainActor.run {
                    self.taskDescriptions.append("Thread: \(thread), TaskPriority: \(taskPriority)")
                }
            }
        }
    }
    
    func fetchDetachedTaskExploration(ParentTaskPriority: TaskPriority, childTaskPriority: TaskPriority) {
        Task(priority: ParentTaskPriority) {
            let thread = Thread.current.description
            let taskPriority = Task.currentPriority.rawValue
            await MainActor.run {
                self.taskDescriptions.append("[Parent Task] Thread: \(thread), TaskPriority: \(taskPriority)")
            }
            
            Task.detached {
                let thread = Thread.current.description
                let taskPriority = Task.currentPriority.rawValue
                await MainActor.run {
                    self.taskDescriptions.append("[Detached Default] Thread: \(thread), TaskPriority: \(taskPriority)")
                }
            }
            
            
            Task.detached(priority: childTaskPriority) {
                let thread = Thread.current.description
                let taskPriority = Task.currentPriority.rawValue
                await MainActor.run {
                    self.taskDescriptions.append("[Detached childTaskPriority] Thread: \(thread), TaskPriority: \(taskPriority)")
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    @StateObject private var vm = ViewModel()
    @State private var imageCollectionTask: Task<Void, Never>? = nil
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ViewBuilder var imageCollectionView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(vm.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .navigationTitle("Task Bootcamp")
        .toolbar {
            Text("Add Image")
                .onTapGesture {
                    Task(priority: .userInitiated) { () -> Bool in
                        print(Thread.current)
                        print(Task.currentPriority)
                       await vm.fetchImage()
                       return true
                    }
                }
        }
    }
    /*
     If we have bunch of tasks running on same thread, the task with highest priority will be prioritized first. It means it is going to start first than other tasks. That doesn't necessarily mean they are going to finish first.
     */
    @ViewBuilder var taskPriorityDescriptionView: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.taskDescriptions, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Task Descriptions")
        .onAppear {
            let priorities: [(String, TaskPriority)] = [
                ("Low", .low), //Task priority: 17
                ("Medium", .medium), //21
                ("High", .high), //25
                ("User Initiated", .userInitiated), //25
                ("Utility", .utility), //17
                ("Background", .background) //9
            ]
            
            for priority in priorities {
                vm.fetchTaskdescription(priority: priority)
            }
        }
    }
    
    //Child tasks inherit task priority from parent tasks
    @ViewBuilder var childTaskExploration: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.taskDescriptions, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Child Task Exploration")
        .onAppear {
            vm.fetchChildTaskExploration(priority: .background)
        }
    }
    
    //Detached tasks: Runs the given throwing operation asynchronously as part of a new top-level task
    @ViewBuilder var detachedTaskExploration: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.taskDescriptions, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Detached Task Exploration")
        .onAppear {
            vm.fetchDetachedTaskExploration(ParentTaskPriority: .background, childTaskPriority: .userInitiated)
        }
    }
    
    @ViewBuilder var imageLoadingCollection: some View {
        ScrollView {
            NavigationLink {
                ZStack {
                    Color.brown.edgesIgnoringSafeArea(.all)
                    Text("Secondary screen")
                        .navigationTitle("Secondary Screen")
                        .navigationBarTitleDisplayMode(.automatic)
                }
            } label: {
                Text("NAVIGATE")
                    .padding(.vertical)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10.0)
                    .padding(.horizontal)
            }
            LazyVGrid(columns: columns) {
                ForEach(vm.images, id: \.self) { item in
                    Image(uiImage: item)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .navigationTitle("Image Collection")
        .onAppear {
            self.imageCollectionTask = Task(priority: .userInitiated) {
                for _ in 0..<20 {
                    await vm.fetchImage()
                }
            }
        }
        .onDisappear {
            self.imageCollectionTask?.cancel()
        }
    }
    
    var body: some View {
        NavigationView {
            imageLoadingCollection
        }
    }
}

struct TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootcamp()
    }
}
