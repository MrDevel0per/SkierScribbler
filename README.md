![The Logo of the Skier Scribbler](https://skierscribbler.com/wp-content/uploads/2022/05/Website-Header.jpg)
<!-- Tags will go below. This project is built on the latest SwiftUI and Swift, and supports iOS and iPadOS natively with Compatibility for macOS via Mac Catalyst. -->
[![GitHub tag](https://img.shields.io/github/tag/MrDevel0per/SkierScribbler?include_prereleases=&sort=semver)](https://github.com/MrDevel0per/SkierScribbler/releases/)
![iOS Compatibility - SwiftUI](https://img.shields.io/badge/iOS_Compatibility-SwiftUI-white)
![iPadOS Compatibility - SwiftUI](https://img.shields.io/badge/iPadOS_Compatibility-SwiftUI-white)
![Mac Compatibility - Mac Catalyst](https://img.shields.io/badge/macOS_Compatibility-Mac_Catalyst-blue)
# Welcome!
This is SkierScribbler - the official app of https://skierscribbler.com, your source for [AHS](aspenk12.net) news. This app was build by [@MrDevel0per](https://github.com/MrDevel0per) (Owen).
## The App
The app scrapes https://SkierScribbler.com with help from [SwiftSoup](https://github.com/scinfu/swiftsoup). Owen is the CEO/CTO/CDO (chief dev officer) of OCA Creations LLC, so the app is published on the [App Store under his company](APP_STORE_LINK_HERE). It aims to follow the UI of the website as closely as possible, and includes the following features:
### Features
The tabs of the SkierScribbler app (called **"The App"** for the rest of the README) will include the following:
- Homepage (this may have integrated ads to support the Scribbler)
- Print Editions
- Search (with category list on page + icons like Apple News)
- SkierTV?
There will also be a settings icon (likely on the homepage) so that users can choose to subscribe to authors or topics. The app will include notifications as well.
#### Homepage Feed
This app is designed to closely mimic the [Gore Range Gazette App](https://github.com/MrDevel0per/Gore-Range-Gazette-App), as it also scrapes the SNO site. Some features of the homepage include:
- The Poll on top (scraped from the website, in a miniview): this was one feature the GRGA never had. The homepage view will be a lot like Apple News, as it will show the articles in a continuous feed.
- The articles with images on the homepage. This will include previews, content menus, etc, and be very fancy. It will look good.
- Potentially sports scores.
- Subscriptions to topics (like Apple News)!
#### Print Editions
This will display a list of print editions in a pretty format, and offer an interactive WebView for users to experience them. Maybe ads?
#### Ads/IAP
The app will offer users the option to watch ads, and even buy extra features to support the Scribbler. The developer may take a commission in addition to Apple's 30%.
#### Search
This will include a list of articles with integrated SF Symbols, and have a fuzzy search. This will search the archives as well if possible.
#### SkierTV
This may not be included, but there might be a tab to watch live SkierTV.
### Extra Features
- Filtering on WebViews: This will ensure that only the article and external links included, as well as staff, are allowed to be visited. NOT UNRESTRICTED INTERNET ACCESS!
- Highly advanced HTML parsing: All extra stuff will be removed on pages, so that users can enjoy an ad-free and extra-stuff-free reading experience.
- Subscribing to authors/topics: This will ensure that the given author/topic is always at the top of the user's feed.
- Notifications: This may use FireBase, and will notify the user when a new article comes out from an author/topic they are interested in.
- Reccomendation on the homepage (if there are enough articles): allow users to like/dislike articles, collect these data, and then eventually train a parser.
# Installation
Once developed, the App will be available on the App Store. For the second, use the following steps:
### Step 1: Install Xcode
Install the latest version of Xcode from [the App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12) or [the Apple Developer website](https://developer.apple.com/xcode/). It's worth noting that this project was built with Xcode 15 beta, but is Xcode 14 compatible.
### Step 2: Clone the Repository
You should have now installed Xcode, which brings `git` with it. If not, install git: https://git-scm.com.

Now, enter the following line in Terminal.app:
```sh
git clone https://github.com/MrDevel0per/SkierScribbler.git && cd SkierScribbler
```
If you get a credentials error, you may have to install `git-credential-manager` first. Take a look at [the Install docs](https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md).
### Step 3: Build + Run
While you can `xcodebuild`, the major focus of this app is iOS. You should build to a device or simulator. Open the repo in Xcode:
```sh
open . -a "Xcode.app"
```
Or, if you're running an Xcode Beta:
```sh
open . -a "Xcode-beta.app"
```
Once the app is open, you can now build and run! You may have to sign locally, by registering for the Apple Developer program. You're probably better off with the TestFlight beta if you don't have a membership. **The first beta of SkierScribbler will be released by the end of 2023.**

# Contributing
Thank you for wanting to contribute to the project! As of right now, we only use Swift and SwiftUI, plus some UIKit Bridging for `WKWebView`. We are open to all contributions, but please note that we will likely **reject** any Objective-C contributions lacking a bridging header. If you have an idea for the app, [open a Feature Request](https://github.com/MrDevel0per/SkierScribbler/issues/new). Please see [Contributing.md](https://github.com/MrDevel0per/SkierScribbler/Contributing.md) for more information.

