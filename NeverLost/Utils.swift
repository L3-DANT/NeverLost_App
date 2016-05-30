//
//  Utils.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import Foundation

public typealias ServiceResponseObject = (Int, NSDictionary?) -> Void
public typealias ServiceResponseArray = (Int, [NSDictionary]) -> Void

/// Read the NSUserDefaults
/// - Returns Email and token
public func getUserData() -> (email: String?, token: String?) {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let email = defaults.stringForKey("checkEmail")
    let token = defaults.stringForKey("checkToken")
    
    return (email, token)
}

/// Read the dictionary needed to check the filter
/// - Returns The dictionary
public func getCheckOutParameters() -> Dictionary<String, String> {
    let infos = getUserData()
    let email = infos.email
    let token = infos.token
    
    return ["email": email!, "token": token!] as Dictionary<String, String>
}

/// Write the NSUserDefaults (email and token)
/// - Returns Void
public func setUserData(email: AnyObject?, token: AnyObject?) -> Void {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(email, forKey: "checkEmail")
    defaults.setObject(token, forKey: "checkToken")
    defaults.synchronize()
}

/// Check if the email is valid
/// - Returns Bool
public func checkEmail(email: String) -> Bool {
    let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    return emailTest.evaluateWithObject(email)
}

private func getRequest(route: String, parameters: Dictionary<String, String>) -> (success: Bool, request: NSMutableURLRequest) {
    let request = NSMutableURLRequest(URL: NSURL(string: "http://127.0.0.1:8080/NeverLost/rest/" + route)!)
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
        return (true, request)
    } catch {
        return (false, NSMutableURLRequest())
    }
}

/// Execute a HTTP request with POST method via an url.
/// - Parameter route The route of the url.
/// - Parameter parameters The parameters to include in the body of the request.
/// - Parameter callback ServiceResponse
/// - Returns Void
public func sendRequestObject(route: String, parameters: Dictionary<String, String>, callback: ServiceResponseObject) -> Void {
    let session = NSURLSession.sharedSession()
    
    let requestItem = getRequest(route, parameters: parameters)
    
    if requestItem.success {
        let task = session.dataTaskWithRequest(requestItem.request) { data, response, error in
            guard data != nil else {
                print("No Data Found -> \(error)")
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200 :
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            callback(statusCode, json)
                        }
                    } catch {
                        callback(statusCode, nil)
                    }
                    break
                    
                case 400 :
                    callback(statusCode, ["error": "Bad Request"])
                    break
                    
                case 401 :
                    setUserData(nil, token: nil)
                    callback(statusCode, ["error": "Unauthorized"])
                    break
                    
                case 403 :
                    callback(statusCode, ["error": "Forbidden"])
                    break
                    
                case 404 :
                    callback(statusCode, ["error": "Not Found"])
                    break
                    
                case 500 :
                    callback(statusCode, ["error": "Internal Server Error"])
                    break
                    
                default :
                    setUserData(nil, token: nil)
                    callback(0, ["error": "Das ist eine problem !"])
                    break
                }
            }
        }
        task.resume()
    }
}

public func sendRequestArray(route: String, parameters: Dictionary<String, String>, callback: ServiceResponseArray) -> Void {
    let session = NSURLSession.sharedSession()
    
    let requestItem = getRequest(route, parameters: parameters)
    
    if requestItem.success {
        let task = session.dataTaskWithRequest(requestItem.request) { data, response, error in
            guard data != nil else {
                print("No Data Found -> \(error)")
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                var result = [NSDictionary]()
                
                switch statusCode {
                case 200 :
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [[String : AnyObject]] {
                            for item: [String : AnyObject] in json {
                                result.append(item)
                            }
                            callback(statusCode, json)
                        }
                    } catch {
                        callback(statusCode, result)
                    }
                    break
                    
                case 400 :
                    result.append(["error": "Bad Request"])
                    callback(statusCode, result)
                    break
                    
                case 401 :
                    setUserData(nil, token: nil)
                    result.append(["error": "Unauthorized"])
                    callback(statusCode, result)
                    break
                    
                case 403 :
                    result.append(["error": "Forbidden"])
                    callback(statusCode, result)
                    break
                    
                case 404 :
                    result.append(["error": "Not Found"])
                    callback(statusCode, result)
                    break
                    
                case 500 :
                    result.append(["error": "Internal Server Error"])
                    callback(statusCode, result)
                    break
                    
                default :
                    setUserData(nil, token: nil)
                    result.append(["error": "Das ist eine problem !"])
                    callback(0, result)
                    break
                }
            }
        }
        task.resume()
    }
}