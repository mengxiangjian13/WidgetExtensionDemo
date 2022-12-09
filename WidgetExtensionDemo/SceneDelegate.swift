//
//  SceneDelegate.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/5.
//

import UIKit
import WidgetKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for context in URLContexts {
            let urlString = context.url.absoluteString
            if urlString == "Search" {
                // 搜索
                print("search")
                self.alert(title: "Search Click", message: "search")
            } else if urlString.hasPrefix("smallCard") {
                print("small card open vid")
                let component = urlString.components(separatedBy: ",")
                if component.count > 1 {
                    let vid = component[1]
                    self.alert(title: "small card click", message: "vid: \(vid)")
                }
            } else if urlString.hasPrefix("episode") {
                print("medium card open vid")
                let component = urlString.components(separatedBy: ",")
                if component.count > 2 {
                    let vid = component[1]
                    let order = component[2]
                    self.alert(title: "medium card click", message: "vid: \(vid), order: \(order)")
                }
            }
        }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if let kind =  userActivity.userInfo?[WidgetCenter.UserInfoKey.kind] as? String, kind == "LetvPoster" {
            self.alert(title: "widget点击", message: kind)
        }
    }

    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { _ in
            print("ok")
        }))
        self.window?.rootViewController?.present(alert, animated: true)
    }

}

