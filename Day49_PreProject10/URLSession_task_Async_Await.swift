//
//  URLSession_Async_Await.swift
//  Day49_PreProject10
//
//  Created by Bruno Oliveira on 16/05/24.
//

import SwiftUI

// struct to store responses from APIs
struct Response: Codable {
    var results: [Result]
}

// struck that conform to data return back from API
struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct URLSession_task_Async_Await: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
            
            /*We want that to be run as soon as our List is shown, but we can’t just use onAppear() here because that doesn’t know how to handle sleeping functions – it expects its function to be synchronous.
             
             SwiftUI provides a different modifier for these kinds of tasks, giving it a particularly easy to remember name: task(). This can call functions that might go to sleep for a while; all Swift asks us to do is mark those functions with a second keyword, await, so we’re explicitly acknowledging that a sleep might happen.
             
             await: Think of await as being like try – we’re saying we understand a sleep might happen, in the same way try says we acknowledge an error might be thrown.
             */
        }
    }
        
        //This is where our networking call comes in: we’re going to ask the iTunes API to send us a list of all the songs by Taylor Swift, then use JSONDecoder to convert those results into an array of Result instances.
        
        //Asynchronous function:
        
        /*Rather than forcing our entire progress to stop while the networking happens, Swift gives us the ability to say “this work will take some time, so please wait for it to complete while the rest of the app carries on running as usual.”
         
         This functionality – this ability to leave some code running while our main app code carries on working – is called an asynchronous function. A synchronous function is one that runs fully before returning a value as needed, but an asynchronous function is one that is able to go to sleep for a while, so that it can wait for some other work to complete before continuing. In our case, that means going to sleep while our networking code happens, so that the rest of our app doesn’t freeze up for several seconds.

         To make this easier to understand, let’s write it in a few stages. First, here’s the basic method stub – please add this to the ContentView struct:*/
        
    func loadData() async {
        /*async: we’re telling Swift this function might want to go to sleep in order to complete its work
        
         every time a sleep is possible we need to use the await keyword with the code we want to run. Just as importantly, an error might also be thrown here – maybe the user isn’t currently connected to the internet, for example*/
        
        //1- Creating the URL we want to read.
        guard let url = URL(string: "https://itunes.apple.com/search?term=eduardo+costa&entity=song") else {
            print("Invalid URL")
            return
        }
        
        //2- Fetching the data for that URL.
        /*Regardless, a sleep is possible here, and every time a sleep is possible we need to use the await keyword with the code we want to run. Just as importantly, an error might also be thrown here – maybe the user isn’t currently connected to the internet, for example.
         
         So, we need to use both try and await at the same time.*/
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //3- Decoding the result of that data into a Response struct.
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
            
        } catch {
            print("Invalid data")
        }
        
        /*A- Our work is being done by the data(from:) method, which takes a URL and returns the Data object at that URL. This method belongs to the URLSession class, which you can create and configure by hand if you want, but you can also use a shared instance that comes with sensible defaults.
         B- The return value from data(from:) is a tuple containing the data at the URL and some metadata describing how the request went. We don’t use the metadata, but we do want the URL’s data, hence the underscore – we create a new local constant for the data, and toss the metadata away.
         C- When using both try and await at the same time, we must write try await – using await try is not allowed. There’s no special reason for this, but they had to pick one so they went with the one that reads more naturally.
        
        So, if our download succeeds our data constant will be set to whatever data was sent back from the URL, but if it fails for any reason our code prints “Invalid data” and does nothing else*/
    }
}

#Preview {
    URLSession_task_Async_Await()
}
