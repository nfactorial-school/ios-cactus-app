//
//  Article.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/3/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

//{
//  "id": 0,
//  "title": "0 How to boost productivity",
//  "subtitle": "0 Want to increase your productivity, but not sure how to start?",
//  "image": "https://i0.wp.com/emailanalytics.com/wp-content/uploads/2018/10/27-Ways-to-Increase-Employee-Productivity-in-the-Workplace.jpg",
//  "text": "You can be the star in this movie about productivity, rather than the alternate version where you end the day tired and slumped behind a desk stacked with unfinished projects. If you donâ€™t like the way your usual workday goes, there is a way to change it.\nMost of us arenâ€™t as productive as we would like for two reasons: We have bad habits that interfere with our workplace productivity and weâ€™re reactive rather than proactive, putting out fires instead of making progress toward our goals.\nThe solution is simple, though not always easy. We can replace our bad habits and reactive patterns with good habits that will make us proactive, and take charge of our own workdays. Follow these tips on how to increase productivity and become your best, most productive self at work.\nThereâ€™s endless advice out there for people not to do mental sludge tasks like answering email or routine chores in the morning, but to start out instead doing whatever tasks are most creatively demandingâ€”which is great if youâ€™re a morning person. If youâ€™re more of a night owl, like me, obviously this isnâ€™t going to work well for you.\nProductivity expert Tony Wong advises, â€œUse your morning to focus on yourselfâ€¦ Start your day out right by ignoring your emails in the morning and getting in a good breakfast, reading the news, meditating, or working out. This will ensure youâ€™ve got the necessary fuel for a productive day.â€ The point is, do your most demanding tasks in your personal peak productivity time, whenever that is.",
//  "author": {
//    "name": "Steven Grey",
//    "subtitle": "Professor at the Wharton School",
//    "image": "https://pbs.twimg.com/profile_images/1169919000123518978/37QQ8Una_400x400.jpg"
//  }
//}

struct Article: Decodable {
    let title: String
    let subtitle: String
    let image: String
    let text: String
    let author: Author
}


