//
//  DependencyContainer.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 24.12.2022..
//

import Foundation
import Presentation
import Domain
import Data
import Core
import Apollo

@MainActor
final class DependencyContainer {
    let mediaBaseURL = "https://ik.imagekit.io/smeybgkgf/tr:h-300/"
    let concurrentQueue = DispatchQueue(
        label: "com.hydro1337x.ventium.concurrentQueue",
        qos: .userInitiated,
        attributes: .concurrent
    )
    let apolloClient = ApolloClient(url: URL(string: "https://ventium-7lx4w6qtva-ew.a.run.app/graphql")!)
    let networkMonitor = NetworkMonitorDecorator(
        NetworkMonitor(queue: DispatchQueue(label: "com.hydro1337x.ventium.networkMonitorQueue", qos: .userInitiated))
    )
    let channel = Channel()
    
    var fetchPostsRepository: FetchPostsRepository {
        ApolloFetchPostsRepository(
            client: apolloClient,
            queue: concurrentQueue,
            postMapper: { [mediaBaseURL] input in
                try PostMapper.map(input, baseURL: mediaBaseURL)
            }
        )
    }
    var fetchStoriesRepository: FetchStoriesRepository {
        ApolloFetchStoriesRepository(
            client: apolloClient,
            queue: concurrentQueue) { [mediaBaseURL] input in
                try StoryMapper.map(input, baseURL: mediaBaseURL)
            }
    }
    var fetchImageRepository: FetchImageRepository {
        URLSessionImageRepository(session: .shared)
    }
    
    let fakeRepository = FakeRepository()
    
    var fetchPostsUseCase: FetchPostsUseCase {
        FetchPostsUseCase.live(repository: fakeRepository)
    }
    var fetchStorieUseCase: FetchStoriesUseCase {
        FetchStoriesUseCase.live(repository: fakeRepository)
    }
    var fetchImageUseCase: FetchImageUseCase {
        FetchImageUseCase.live(repository: fetchImageRepository)
    }
    
    var profileFactory: ProfileFactory { ProfileFactory() }
    var notificationsFactory: NotificationsFactory { NotificationsFactory() }
    var searchFactory: SearchFactory { SearchFactory() }
    var homeFactory: HomeFactory {
        HomeFactory(
            fetchPostsUseCase: fetchPostsUseCase,
            fetchStoriesUseCase: fetchStorieUseCase,
            fetchImageUseCase: fetchImageUseCase,
            channel: channel
        )
        
    }
    var tabsFactory: TabsFactory {
        TabsFactory(
            homeFactory: homeFactory,
            searchFactory: searchFactory,
            notificationsFactory: notificationsFactory,
            profileFactory: profileFactory
        )
    }
    var authFactory: AuthFactory { AuthFactory() }
    var rootFactory: RootFactory {
        RootFactory(
            authFactory: authFactory,
            tabsFactory: tabsFactory,
            channel: channel
        )
    }
    
    var rootCoordinatorStore: RootCoordinatorStore {
        let initialScene = rootFactory.makeTabsCoordinator()
        return RootCoordinatorStore(
            scene: .tabs(initialScene),
            factory: rootFactory,
            reachabilityStream: networkMonitor.reachabilityStream
        )
    }
    
    func makeDebugView(onDismiss: @escaping () -> Void) -> DebugView {
        let actions = DebugView.Actions(
            onReachabilityChange: {
                self.networkMonitor.send($0)
            }, onToastSend: {
                self.channel.send(TabsCoordinatorEvent.showToast($0))
            }, onDismiss: onDismiss
        )
        
        return DebugView(actions: actions)
    }
}

final class FakeRepository: FetchStoriesRepository, FetchPostsRepository {
    let storiesPaginator = Paginator<Story>()
    let postsPaginator = Paginator<Post>()
    let storyImageURLs = [
        "https://media.istockphoto.com/id/501387734/photo/dancing-friends.jpg?s=612x612&w=0&k=20&c=SoTKXXMiJYnc4luzJz3gIdfup3MI8ZlROFNXRBruc10=",
        "https://media.istockphoto.com/id/1298329918/photo/birthday-celebratory-toast-with-string-lights-and-champagne-silhouettes.jpg?s=612x612&w=0&k=20&c=PaDeMR5-r0NdlxghuVF9tRqR5XkCdNdTzxrkofv0Syk=",
        "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVzaWMlMjBwYXJ0eXxlbnwwfHwwfHw%3D&w=1000&q=80",
        "https://img.freepik.com/free-vector/realistic-confetti-background_23-2148473498.jpg",
        "https://media.istockphoto.com/id/1165055006/photo/nice-looking-attractive-gorgeous-glamorous-elegant-stylish-cheerful-cheery-positive-girls-and.jpg?s=612x612&w=0&k=20&c=zXqufRf_lhy8U-vVXoqlxnlVaFeAgk-_bx-CWx9E3F8=",
        "https://images.unsplash.com/photo-1611244806964-91d204d4a2a7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3VtbWVyJTIwcGFydHl8ZW58MHx8MHx8&w=1000&q=80",
        "https://thumbs.dreamstime.com/b/young-party-cheerful-people-showered-confetti-club-31137048.jpg",
        "https://www.pulainfo.hr/wp/wp-content/uploads/2019/05/party-1.jpg"
    ]
    
    let postImageURLs = [
        "https://img.freepik.com/free-vector/hand-drawn-colorful-music-festival-facebook-cover_23-2149065686.jpg",
        "https://img.freepik.com/free-psd/music-festival-facebook-cover-template_23-2149948680.jpg",
        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/party-mix-youtube-thumbnail-design-template-765ae085447f6b1f797c9a504a926086_screen.jpg?ts=1570790895",
        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/party-music-beach-sunset-youtube-thumbnail-design-template-2ee3ca06baa1189a6c1d4bbb596c68b5_screen.jpg?ts=1600839157",
        "https://storage.highresaudio.com/2020/07/15/3j2tbh-newraveext-preview-m3.jpg",
        "https://www.lololyrics.com/img/cover/42515.jpeg",
        "https://marketplace.canva.com/EAFIrtzQPgI/2/0/1600w/canva-black-and-gold-glitter-award-nomination-2023-facebook-event-cover-MpgDljNwy2s.jpg",
        "https://img.freepik.com/free-vector/gradient-colorful-music-festival-facebook-cover_23-2149084965.jpg"
    ]
    
    let avatarImageURLs = [
        "https://images-platform.99static.com//U_5Tt7dt_PKsRae1aah-qjDgHyU=/0x0:957x957/fit-in/500x500/99designs-contests-attachments/136/136838/attachment_136838649",
        "https://images-platform.99static.com//p3YPJG6PpzpkD0W8AzTkGvaacCs=/0x0:1000x1000/fit-in/500x500/99designs-contests-attachments/109/109427/attachment_109427786",
        "https://images-platform.99static.com//pU_SaMYHbCuknZxkhN6eL2_Z3b4=/112x95:888x871/fit-in/500x500/99designs-contests-attachments/116/116311/attachment_116311668",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1j1I6_HgmxE3N0c47V6HFSGa8coOE7uP9Jf4koqfbd-JPjHdWowpwiqIAVC4eRaecyF8&usqp=CAU",
        "https://mir-s3-cdn-cf.behance.net/project_modules/disp/23481a9538189.560d558934fb7.jpg",
        "https://images-platform.99static.com/NuZXQzHg4Y_1WtQcCyrP-u6EKcg=/369x0:1662x1293/500x500/top/smart/99designs-contests-attachments/89/89296/attachment_89296976",
        "https://img0-placeit-net.s3-accelerate.amazonaws.com/uploads/stage/stage_image/42801/optimized_large_thumb_stage.jpg",
        "https://img0-placeit-net.s3-accelerate.amazonaws.com/uploads/stage/stage_image/42802/optimized_large_thumb_stage.jpg"
    ]
    
    init() {}
    
    func fetch(_ request: Domain.FetchStoriesInput) async -> Result<[Domain.Story], Error> {
        if request.isInitial {
            await storiesPaginator.reset()
        }
        
        let page = await storiesPaginator.paginate(makeStoriesPage())
        
        return .success(page)
    }
    
    func fetch(_ request: Domain.FetchPostsRequest) async -> Result<[Domain.Post], Error> {
        if request.isInitial {
            await postsPaginator.reset()
        }
        
        let page = await postsPaginator.paginate(makePostsPage())
        
        return .success(page)
    }
    
    func makeStoriesPage() async -> PaginatedResponse<Story> {
        let dummyArray = Array(repeating: 1, count: 8)
        var rawPage: [Story] = []
        
        for (index, _) in dummyArray.enumerated() {
            let cursor = await storiesPaginator.cursor
            let story = Story(
                id: (cursor + index).description,
                location: .init(
                    id: (cursor + index).description,
                    name: "Venue Name \(cursor + index)",
                    address: "Address \(cursor + index)",
                    medias: [.init(url: URL(string: avatarImageURLs[index])!, isFavorite: true)]),
                medias: [.init(url: URL(string: storyImageURLs[index])!, isFavorite: true)],
                expiresAt: Date()
            )
            rawPage.append(story)
        }
        
        return await PaginatedResponse(page: rawPage, pagination: .init(cursor: storiesPaginator.cursor, hasNext: true))
    }
    
    func makePostsPage() async -> PaginatedResponse<Post> {
        let dummyArray = Array(repeating: 1, count: 8)
        var rawPage: [Post] = []
        
        for (index, _) in dummyArray.enumerated() {
            let cursor = await postsPaginator.cursor
            let post = Post(
                id: (cursor + index).description,
                name: "Post \(cursor + index)",
                description: "Description \(cursor + index)",
                medias: [.init(url: URL(string: postImageURLs[index])!, isFavorite: true)],
                location: .init(
                    id: (cursor + index).description,
                    name: "Venue Name \(cursor + index)",
                    address: "Address \(cursor + index)",
                    medias: [.init(url: URL(string: avatarImageURLs[index])!, isFavorite: true)]),
                tags: [.init(name: "nightlife"), .init(name: "dance"), .init(name: "livemusic")]
            )
            rawPage.append(post)
        }
        
        return await PaginatedResponse(page: rawPage, pagination: .init(cursor: storiesPaginator.cursor, hasNext: true))
    }
}
