//
//  Utils.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 13/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import Foundation
import UIKit

public class Utils {
    // MARK: Dateformatter
    private static var dateFormatter: DateFormatter = DateFormatter()
    
    public static func convertDate(from now: Date?) -> String {
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return (now == nil) ? dateFormatter.string(for: Date())! : dateFormatter.string(for: now)!
    }
    
    public static func convertDate(from now: String?) -> Date {
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return (now == nil) ? Date() : dateFormatter.date(from: now!)!
    }
    
    public static func getTimeNow() -> String {
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: Date())
    }
    
    public static func getTimeNow() -> Date {
        return Date()
    }
    
    public static func addIconToTextField(textField: UITextField, icon: UIImage, widthMargin: CGFloat, heightMargin: CGFloat, padding: Int) {
        let iconWidth: CGFloat = icon.size.width - CGFloat(padding)
        let iconHeight: CGFloat = icon.size.height - CGFloat(padding)
        
        let leftImageView = UIImageView(frame: CGRect(x: widthMargin, y: heightMargin, width: iconWidth, height: iconHeight))
        leftImageView.image = icon
        let view = UIView(frame: CGRect(x: 0, y: 0, width: iconWidth + widthMargin, height: iconHeight + heightMargin))
        view.addSubview(leftImageView)
        textField.leftView = view
        textField.leftViewMode = .always
    }
    
    public static func getDeviceIPAddress() -> String? {
        var ipAddress: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name = String(cString: (interface?.ifa_name)!)
                    if name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        ipAddress = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return ipAddress
    }
    
    public static func getWiFiAddress() -> String? {
        var address : String?
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}
