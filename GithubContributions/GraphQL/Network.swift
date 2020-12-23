//
//  Network.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  //private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.github.com/graphql")!)
    //        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
    //endpointURL: url)

    //
    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://api.github.com/graphql")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
                
        let key = UserDefaults(suiteName: "group.contributions.data")?.value(forKey: "authkey")
        guard let authToken = key else {
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
            return
        }

        // TODO
        request.addHeader(name: "Authorization", value: "Bearer \(authToken)")
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}

class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(TokenAddingInterceptor(), at: 0)
        return interceptors
    }
}
