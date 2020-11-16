# Flamingo

Augmented Reality Banking with TypingDNA

## Inspiration

We dream about a world where displays will be much more than squares that sit in our hands. This future is coming closer with the power of Augmented Reality (AR). In an utopic future where people see more with their eyes through technology we imagine that contextual information should be available without looking down at screens anymore.

## What it does

We provide an experience where the user can see the banking information such as total balance, income and outcome just by pointing the camera at the card.

To protect the privacy of our users, we have incorporated a secure way of authentication and all the processing is done locally on the device.

## How we built it

We used [RealityKit](https://developer.apple.com/augmented-reality/realitykit/) from Apple to create a dynamically generated experience in AR to provide banking data such as total balance, income and outcome.

To register and authenticate our users we used [TypingDNA API](https://api.typingdna.com) with the "same-text" type which is evaluated on the last 8 digits of the card. This was possible by integrating the [TypingDNA Recorder for iOS](https://github.com/TypingDNA/TypingDNARecorder-iOS).

We made use of [Card.io](https://github.com/card-io/card.io-iOS-SDK) library to recognise the card numbers and take a cropped picture of the card to use it as a tracker in the AR experience.

## Challenges we ran into

5 out of the 6 members were new to programming. We spent 2/3 of the time on planning and studying programming together. Because of our limited resources, we wanted to build something on a common platform making use of JavaScript and other web-based technologies.

We wanted to create an interactive experience where the user would be able to use their hands to be recognised through the TypingDNA by [extending the recorder to understand the hand pose estimation data](https://github.com/razvangeangu/flamingo/blob/feat/hand-pose-estimation/packages/flamingo-ui/src/app/containers/HomePage/index.tsx). However, we encountered major performance difficulties and we were not able to pursue this further on the web.

After we realised that our dream cannot be achieved without a native technology we were very demotivated after spending 40+ hours studying web technologies.

We decided to make our dream a reality through iOS, but only 1 out of 6 had access to an iPhone and a MacBook (remember the professional developer? haha 🥲). But we did not lose hope and we pair-programmed together using [TeamViewer](https://www.teamviewer.com/en/), coded logic in [Swift Playgrounds online](http://online.swiftplayground.run) but most importantly, we created virtual machines and spent hours getting Xcode in a virtual environment up and runnning.

Finally we were only left with 2 weeks before the deadline and we **ACTUALLY** got to start developing.

Not to say.. Apple did not approve our application on TestFlight so we decided to go on our own and use [AppDistribution](https://firebase.google.com/docs/app-distribution) by Firebase which gives us the flexibility we need for this project.

Since we all have our jobs and studies it was incredibily difficult to schedule times to code together particularly during the week. This has also been difficult because of the differences in the timezones.

## Accomplishments that we're proud of

- Everyone in the team knows now how to code
- Most members are now proficient in JavaScript and TypeScript after doing all the exercises on [freeCodeCamp](https://www.freecodecamp.org) (even though we didn't end up using it for the final app)
- Most of us did a [crash course on SwiftUI](https://youtu.be/VlhcNR7Qrno)
- Finalised a demo where you can scan a card, get the card numbers, register and authenticate through the API to enjoy a demo AR Experience

## What we learned

Web is too weak for our dreams. Oh and JavaScript, TypeScript, Swift and TypingDNA API.

## What's next for Flamingo

Firstly, we would love to integrate hand pose estimation in Swift and adapt the recorder to register a typing pattern without using the keyboard.

Secondly, we would like to connect through [OpenBanking](https://www.openbanking.org.uk) to the bank account and provide real live data information in the AR experience.

Finally we would like more than a MacBook and an iPhone to be able to test our dream...
