//
//  Rx_MDNS.swift
//  EdgeRemote
//
//  Created by Daniel Poulsen on 09/03/2016.
//  Copyright © 2016 cambridgeaudio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxNSNetServiceBrowserDelegateProxy : DelegateProxy
    , NSNetServiceBrowserDelegate
, DelegateProxyType {
    
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let serviceBrowser: NSNetServiceBrowser = object as! NSNetServiceBrowser
        return serviceBrowser.delegate
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let serviceBrowser: NSNetServiceBrowser = object as! NSNetServiceBrowser
        serviceBrowser.delegate = delegate as? NSNetServiceBrowserDelegate
    }
}

extension NSNetServiceBrowser{

    
    public var rx_delegate: DelegateProxy {
        return proxyForObject(RxNSNetServiceBrowserDelegateProxy.self, self)
    }
    
    public var rx_didFindServiceMoreComing: Observable<(service : NSNetService, moreComing : Bool)> {
        return rx_delegate.observe(#selector(NSNetServiceBrowserDelegate.netServiceBrowser(_:didFindService:moreComing:)))
            .map { a in
                let service = a[1] as! NSNetService
                let moreComing = a[2]as! Bool
                return (service : service, moreComing : moreComing)
        }
    }
   

}
