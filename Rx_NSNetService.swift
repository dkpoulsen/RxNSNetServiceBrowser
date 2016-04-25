//
//  Rx_NSNetService.swift
//  EdgeRemote
//
//  Created by Daniel Poulsen on 10/03/2016.
//  Copyright © 2016 cambridgeaudio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxNSNetServiceDelegateProxy : DelegateProxy
    , NSNetServiceDelegate
, DelegateProxyType {
    
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let service: NSNetService = object as! NSNetService
        return service.delegate
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let service: NSNetService = object as! NSNetService
        service.delegate = delegate as? NSNetServiceDelegate
    }
}

extension NSNetService{
    
    
    public var rx_delegate: DelegateProxy {
        return proxyForObject(RxNSNetServiceDelegateProxy.self, self)
    }
    
    public var rx_netServiceDidResolveAddress: Observable<NSNetService> {
        return rx_delegate.observe(#selector(NSNetServiceDelegate.netServiceDidResolveAddress(_:)))
            .map { a in
                return a[0] as! NSNetService
        }
    }
    
    
}