//
//  Async_Image.swift
//  Day49_PreProject10
//
//  Created by Bruno Oliveira on 17/05/24.
//

import SwiftUI

struct Async_Image: View, Hashable {
    var body: some View {
        NavigationStack {
            
            NavigationLink("AsyncImage - Without Scale") {
                Section("AsyncImage - Without Scale") {
                    AsyncImage(url: URL(string:"https://hws.dev/img/logo.png"))
                }
            }
            .padding()
            
            /*I created that picture to be 1200 pixels high, but when it displays you’ll see it’s much bigger. This gets straight to one of the fundamental complexities of using AsyncImage: SwiftUI knows nothing about the image until our code is run and the image is downloaded, and so it isn’t able to size it appropriately ahead of time.
             
             If I were to include that 1200px image in my project, I’d actually name it logo@3x.png, then also add an 800px image that was logo@2x.png. SwiftUI would then take care of loading the correct image for us, and making sure it appeared nice and sharp, and at the correct size too. As it is, SwiftUI loads that image as if it were designed to be shown at 1200 pixels high – it will be much bigger than our screen, and will look a bit blurry too.

             To fix this, we can tell SwiftUI ahead of time that we’re trying to load a 3x scale image, like this:*/
            
            NavigationLink("AsyncImage - With Scale") {
                Section("AsyncImage - With Scale"){
                    AsyncImage(url: URL(string:"https://hws.dev/img/logo.png"), scale: 3)
                }
            }
            .padding()
            /*When you run the code now you’ll see the resulting image is a much more reasonable size. Modifiers don`t works directly with AsyncImage. we’re applying modifiers to a wrapper around the image, which is the AsyncImage view. That will ultimately contain our finished image, but it will also contain a placeholder that gets used while the image is loading. You can actually see the placeholder just briefly when your app runs – that 200x200 gray square is it, and it will automatically go away once loading finishes.
             
             To adjust our image, you need to use a more advanced form of AsyncImage that passes us the final image view once it’s ready, which we can then customize as needed. As a bonus, this also gives us a second closure to customize the placeholder as needed.

             For example, we could make the finished image view be both resizable and scaled to fit, and use Color.red as the placeholder so it’s more obvious while you’re learning*/
            
            NavigationLink("AsyncImage - Applying Modifiers") {
                Section("AsyncImage - Applying Modifiers") {
                    AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ZStack{
                            Color.red
                            ProgressView()
                                .background(.white)
                        }
                    }
                    .frame(width: 200, height: 200)
                }
            }
            .padding()
            
            /*A resizable image and Color.red both automatically take up all available space, which means the frame() modifier actually works now.
             
             The placeholder view can be whatever you want. For example, if you replace Color.red with ProgressView() – just that – then you’ll get a little spinner activity indicator instead of a solid color.

             If you want complete control over your remote image, there’s a third way of creating AsyncImage that tells us whether the image was loaded, hit an error, or hasn’t finished yet. This is particularly useful for times when you want to show a dedicated view when the download fails – if the URL doesn’t exist, or the user was offline, etc.*/
            NavigationLink("AsyncImage - Handling with erros and loading") {
                Section("AsyncImage - Handling with erros and loading ") {
                    AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("There was an Error loading the image")
                                .font(.title)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 200, height: 200)
                }
            }
            .padding()
            
            .toolbar {
                Button("Nothing to do") {
                    
                }
            }
        }
    }
}

#Preview {
    Async_Image()
}
