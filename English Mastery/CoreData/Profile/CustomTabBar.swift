
import UIKit
import PDFKit
import SwiftUI
import SwiftSoup
import WebKit
import Combine

struct CustomTabBar: View {
    @Binding var selectedTab: String
    @State var tabPoints: [CGFloat] = []
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                TabBarButton(image: "magazine", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    selectedTab = "magazine"
                }
                TabBarButton(image: "graduationcap", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    selectedTab = "graduationcap"
                }
                TabBarButton(image: "globe.central.south.asia", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    selectedTab = "globe.central.south.asia"
                }
                TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    selectedTab = "person"
                }
            }
            .padding(.horizontal)
            .background(Color("Color 6"))
            .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
            .overlay(
                Circle()
                    .fill(Color("Color 4"))
                    .frame(width: 10, height: 10)
                    .offset(x: getCurvePoint() - 20),
                alignment: .bottomLeading
            )
            .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getSelectedScreen())
    }
    
    func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case "magazine":
                return tabPoints[0]
            case "graduationcap":
                return tabPoints[1]
            case "globe.central.south.asia":
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
    
    @ViewBuilder
    func getSelectedScreen() -> some View {
        if selectedTab == "magazine" {
            MagazineView()
        } else if selectedTab == "graduationcap" {
            PaperPlaneView()
        } else if selectedTab == "globe.central.south.asia" {
            GraduationCapView()
        } else {
            EmptyView()
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant("magazine"))
    }
}


struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    var action: () -> Void
    
    var body: some View {
        GeometryReader { reader -> AnyView in
            let midX = reader.frame(in: .global).midX
            DispatchQueue.main.async {
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            return AnyView(
                Button(action: {
                    selectedTab = image
                    action()
                }) {
                    Image(systemName: image + ".fill")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("Color 4"))
                        .offset(y: selectedTab == image ? -8 : 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 70)
    }
}

   

struct Question {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
}

struct Category {
    let name: String
    let questions: [Question]
}

struct PaperPlaneView: View {
    @State private var totalPoints: Int = 0
    @State private var isFlipped = false
    @State private var showFlashcards = false
    
    let flashcards: [(english: String, ukrainian: String)] = [
        ("Break a leg", "Удачі"),
        ("Bite the bullet", "Сцепити зуби"),
        ("Piece of cake", "Легкотня"),
        ("Once in a blue moon", "Дуже рідко"),
        ("А bed of roses", "Легке життя"),
        ("Raining cats and dogs", "Дуже сильний дощ"),
        ("When pigs fly", "Щось, що ніколи не станеться"),
        ("Miss the boat", "Пропустити шанс"),
        ("Zip your lip", "Не балакай"),
        ("Poles apart", "Щось повністю різне"),
        ("Back the wrong horse", "Прийняте неправильне рішення"),
        ("Greenhorn", "Недосвідчена людина"),
        ("Off the chain", "Дуже хороший"),
        ("Lily-livered", "Боягуз"),
        ("Under the weather", "Погано почуватися"),
        ("Add insult to injury", "Зробити ситуацію гіршою"),
        ("Costs an arm and a leg", "Дуже дорогий"),
        ("Give someone the cold shoulder", "Ігнорувати когось"),
        ("Spill the beans", "Розказати секрет"),
        ("Come rain or shine", "Неважливо що"),

        // Add more flashcards here
        
    ]
    
    
    var categories: [Category] = [
        Category(name: "Grammar1", questions: [
            Question(text: "I _____ very hard at the moment.", options: ["work", "am working", "will work"], correctAnswerIndex: 1),
            Question(text: "Water _____ at 100°C.", options: ["boils", "is boiling", "boiled"], correctAnswerIndex: 0),
            Question(text: "I _____ at 6 o’clock in the morning.", options: ["gets up", "getting up", "get up"], correctAnswerIndex: 2),
            Question(text: "Their mother _____ the party yesterday.", options: ["did not enjoy", "is not enjoying", "were not enjoying"], correctAnswerIndex: 0),
            Question(text: "She has _____ big black cat.", options: ["a", "the", "-"], correctAnswerIndex: 0),
            Question(text: "Rice _____ in Britain.", options: ["does not grow", "is not grow", "has not growing"], correctAnswerIndex: 0),
            Question(text: "There was _____ puddle on _____ floor.", options: ["a", "-", "the", "the"], correctAnswerIndex: 0),
            Question(text: "Mozart _____ more than 100 pieces of music.", options: ["wrote", "has written", "had written"], correctAnswerIndex: 0),
            Question(text: "Please don’t make so much noise! I _____ to sleep.", options: ["try", "am trying", "have tried"], correctAnswerIndex: 1),
            Question(text: "Are you going _____ home now?", options: ["to", "-", "at"], correctAnswerIndex: 0),
            Question(text: "I want _____ a new car.", options: ["buying", "buy", "to buy"], correctAnswerIndex: 1),
            Question(text: "I go _____ work _____ bus.", options: ["to,on", "to,by", "on,on"], correctAnswerIndex: 1),
            Question(text: "You can go out now. It _____ any more.", options: ["does not rain", "is not raining", "is not rain"], correctAnswerIndex: 1),
            Question(text: "_____ Wednesdays, I don’t work.", options: ["On", "At", "In"], correctAnswerIndex: 0),
            Question(text: "I can say anything _____ English.", options: ["in the", "in", "by"], correctAnswerIndex: 1),
            Question(text: "_____ early really annoys me.", options: ["Get up", "Getting up", "To get up"], correctAnswerIndex: 1),
            Question(text: "It is the most boring film I _____ !", options: ["ever saw", "have ever seen", "ever did see"], correctAnswerIndex: 1),
            Question(text: "It is so cold in the room! I _____ the heating.", options: ["turn on", "am turn on", "will turn on"], correctAnswerIndex: 2),
            Question(text: "I’m going _____ holiday next year.", options: ["on", "at", "in"], correctAnswerIndex: 0),
            Question(text: "John is very good at _____.", options: ["speaking", "to speak", "speak"], correctAnswerIndex: 0),
            Question(text: "Jeans _____ in the USA at the beginning of the 20th century.", options: ["are invented", "were invented", "invented"], correctAnswerIndex: 1),
            Question(text: "I _____ late this evening.", options: ["probably am", "will probably be", "probably were"], correctAnswerIndex: 1),
            Question(text: "This candidate spent 5 years in _____ prison.", options: ["a", "the", "-"], correctAnswerIndex: 1),
            Question(text: "Cheese _____ of milk", options: ["makes", "is making", "is made"], correctAnswerIndex: 2),
            Question(text: "I _____ James at the train station at 10 a.m. tomorrow.", options: ["will meet", "am going meet", "am meeting"], correctAnswerIndex: 0),
            
        ]),
        Category(name: "Grammar2", questions: [
            Question(text: "This town is really nice. _____ here?", options: ["Were you always living", "Did you always live", "Have you always lived"], correctAnswerIndex: 2),
            Question(text: "I _____ to London in my life.", options: ["am never", "never was", "have never been"], correctAnswerIndex: 2),
            Question(text: "If you _____ hard, you _____ your test!", options: ["don’t study, don’t pass", "won’t study, won’t pass", "don’t study, won’t pass"], correctAnswerIndex: 2),
            Question(text: "I have decided _____ my job.", options: ["change", "changing", "to change"], correctAnswerIndex: 2),
            Question(text: "William and Mary are celebrating their anniversary. They _____ for 20 years.", options: ["are married", "have been married", "were married"], correctAnswerIndex: 1),
            Question(text: "The lesson starts _____ 7:30 p.m.", options: ["in", "on", "at"], correctAnswerIndex: 2),
            Question(text: "Stop _____ at me!", options: ["shouting", "to shout", "shout"], correctAnswerIndex: 0),
            Question(text: "Look, the sheriff _____ !", options: ["has been shot", "shoots", "shooting"], correctAnswerIndex: 0),
            Question(text: "Jim is not here now. He _____ to Italy.", options: ["went", "has gone", "goes"], correctAnswerIndex: 1),
            Question(text: "When _____ ?", options: ["did Mr. Thomas die", "does Mr. Thomas die", "has Mr. Thomas died"], correctAnswerIndex: 1),
            Question(text: "Ann _____ for a job.", options: ["still looks", "is still looking", "looks still"], correctAnswerIndex: 1),
            Question(text: "They’re still playing tennis. They _____ for 2 hours!", options: ["are playing", "played", "have been playing"], correctAnswerIndex: 2),
            Question(text: "We _____ the accident happen while we _____ the street", options: ["saw, cross", "were seeing, crossed", "saw, were crossing"], correctAnswerIndex: 0),
            Question(text: "Sarah came to the party, but John _____ home.", options: ["has already gone", "had already gone", "already went"], correctAnswerIndex: 1),
            Question(text: "Hello! _____ for a long time?", options: ["Have you been waiting", "Were you waiting", "Had you waited"], correctAnswerIndex: 0),
            Question(text: "He promised me that he _____ my room the following day.", options: ["would clean", "cleaned", "will clean"], correctAnswerIndex: 0),
            Question(text: "At 11 o’clock tomorrow, we _____ a meeting.", options: ["will be have", "will be having", "will had"], correctAnswerIndex: 1),
            Question(text: "This subject _____ by the leading scientists now.", options: ["is being researched", "is researching", "is researched"], correctAnswerIndex: 0),
            Question(text: "He _____ with her even if she _____ him out.", options: ["won’t go out, asked", "won’t go out, will ask", "wouldn’t go out, asked"], correctAnswerIndex: 1),
            Question(text: "I _____ five cups of coffee today, and it’s not even afternoon!", options: ["drank", "will be drinking", "have drunk"], correctAnswerIndex: 2),
            Question(text: "I was out of breath when I got home – I _____ .", options: ["ran", "was running", "had been running"], correctAnswerIndex: 2),
            Question(text: "The shop assistant told me that my order _____ two days before.", options: ["had been sent", "was sent", "sent"], correctAnswerIndex: 0),
            Question(text: "By the time we come to the cinema, the film _____ .", options: ["will start", "will have started", "started"], correctAnswerIndex: 1),
            Question(text: "If she _____ out of university in her youth, she _____ a better job now.", options: ["hadn’t dropped, would have had", "didn’t drop, would have", "hadn’t dropped, would have"], correctAnswerIndex: 0),
            Question(text: "You _____ English for five years by this time next spring.", options: ["will have been studying", "are studying", "will be studying"], correctAnswerIndex: 0),
            
        ]),
        Category(name: "Vocabulary", questions: [
            Question(text: "Martin is a very _____ boy. Everybody likes him.", options: ["polite", "rude", "lazy", "selfish"], correctAnswerIndex: 0),
            Question(text: "Albert is really _____. He always makes me laugh.", options: ["honest", "supportive", "funny", "sincere"], correctAnswerIndex: 2),
            Question(text: "Adam is very _____. He enjoys sharing with people.", options: ["noisy", "generous", "stingy", "shy"], correctAnswerIndex: 1),
            Question(text: "You can trust secrets to Jane. She is a _____ person.", options: ["helpful", "friendly", "sensitive", "reliable"], correctAnswerIndex: 3),
            Question(text: "There is nothing to do. I'm really _____.", options: ["bored", "hardworking", "sensitive", "polite"], correctAnswerIndex: 0),
            Question(text: "Julia was very _____ to see her husband on TV.", options: ["bored", "noisy", "surprised", "quiet"], correctAnswerIndex: 2),
            Question(text: "Maria is only 5 but she can read and write. She is really _____.", options: ["sad", "interested", "clever", "angry"], correctAnswerIndex: 2),
            Question(text: "I had a/an _____dream last night. It was a real nightmare.", options: ["bad", "interesting", "sweet", "good"], correctAnswerIndex: 0),
            Question(text: "Martin is a/an _____ person. He has no money.", options: ["rich", "exciting", "shocking", "poor"], correctAnswerIndex: 3),
            Question(text: "My brother was ill last week but now he is getting _____.", options: ["gooder", "better", "more", "smarter"], correctAnswerIndex: 1),
            Question(text: "I'm going to Barcelona next week. I'm so _____.", options: ["excited", "shocked", "careful", "lazy"], correctAnswerIndex: 0),
            Question(text: "It was a/an _____ film. I cried in the end.", options: ["funny", "sensible", "sad", "bored"], correctAnswerIndex: 2),
            Question(text: "Jill is _____ to go to school today. She is in a bad mood.", options: ["excited", "unwilling", "cheerful", "untidy"], correctAnswerIndex: 1),
            Question(text: "John is a/an _____ person. He always breaks things around.", options: ["clumsy", "careful", "flexible", "reliable"], correctAnswerIndex: 0),
            Question(text: "You must be really _____ if you want to finish this boring project.", options: ["interesting", "friendly", "unwilling", "patient"], correctAnswerIndex: 3),
            Question(text: "You need to be really _____ to play chess.", options: ["funny", "focused", "rich", "unusual"], correctAnswerIndex: 1),
            Question(text: "It's _____ to have a foreign passport to travel abroad.", options: ["needing", "healthy", "necessary", "pleasant"], correctAnswerIndex: 2),
            Question(text: "Clara is never late for appointments. She is a/an _____ person.", options: ["punctual", "honest", "clever", "independent"], correctAnswerIndex: 0),
            Question(text: "Martha enjoys meeting her friends. She is a very _____ person.", options: ["organized", "independent", "reserved", "communicative"], correctAnswerIndex: 3),
            Question(text: "He always tells the truth. He is a/an _____ person.", options: ["focused", "honest", "punctual", "interesting"], correctAnswerIndex: 1),
            Question(text: "My daughter believes absolutely everything you tell her. She’s a/an _____ girl.", options: ["gullible", "intellectual", "illiterate", "tolerant"], correctAnswerIndex: 0),
            Question(text: "Aunt Mary believes horoscopes, carries lucky charms with her and hates black cats. She’s so _____.", options: ["intellectual", "cynical", "intimidating", "superstitious"], correctAnswerIndex: 3),
            Question(text: "He’s a/an _____ actor able to play any kind of roles – from comic to dramatic.", options: ["organized", "versatile", "sensitive", "illiterate"], correctAnswerIndex: 1),
            Question(text: "Dennis is rather shy and unconfident. He always feels _____ to his peers.", options: ["junior", "exhausted", "inferior", "bold"], correctAnswerIndex: 2),
            Question(text: "She was so _____ in the book she was reading that she didn’t notice me come into the room.", options: ["impressed", "mesmerized", "fascinated", "engrossed"], correctAnswerIndex: 3),
            
        ]),
        Category(name: "Starter level test", questions: [
            Question(text: "The opposite of good is _____.", options: ["baed", "bad", "bed"], correctAnswerIndex: 1),
            Question(text: "The opposite of hot is _____.", options: ["cald", "colt", "cold"], correctAnswerIndex: 2),
            Question(text: "The opposite of big is _____.", options: ["small", "smoll", "shmall"], correctAnswerIndex: 0),
            Question(text: "The opposite of close is _____.", options: ["closed", "open", "opened"], correctAnswerIndex: 1),
            Question(text: "The opposite of sad is _____.", options: ["happy", "sadly", "happen"], correctAnswerIndex: 0),
            Question(text: "People can see because they have _____.", options: ["ears", "nose", "eyes"], correctAnswerIndex: 2),
            Question(text: "People can walk because they have _____.", options: ["legs", "ears", "nose"], correctAnswerIndex: 0),
            Question(text: "The colour and the fruit with the same name is _____.", options: ["red", "orange", "blue"], correctAnswerIndex: 1),
            Question(text: "Cows give _____. It is white.", options: ["meat", "cheese", "milk"], correctAnswerIndex: 2),
            Question(text: "Potatoes, tomatoes, onions are _____.", options: ["fruit", "vegetables", "fish"], correctAnswerIndex: 1),
            Question(text: "My mother’s sister is my _____.", options: ["uncle", "cousin", "aunt"], correctAnswerIndex: 2),
            Question(text: "I am not married. I am _____.", options: ["single", "solo", "one"], correctAnswerIndex: 0),
            Question(text: "My brother’s son is my _____.", options: ["nephew", "cousin", "uncle"], correctAnswerIndex: 0),
            Question(text: "The opposite of interesting is _____.", options: ["exciting", "beautiful", "boring"], correctAnswerIndex: 2),
            Question(text: "The opposite of right is _____.", options: ["unright", "wrong", "wrongful"], correctAnswerIndex: 1),
            Question(text: "It’s raining. I need to take a/an _____.", options: ["umbrella", "parasole", "tent"], correctAnswerIndex: 0),
            Question(text: "Why are the windows dirty again? I _____ them yesterday.", options: ["opened", "watched", "washed"], correctAnswerIndex: 2),
            Question(text: "I did not have a pen so I _____ with a pencil.", options: ["took", "wrote", "had"], correctAnswerIndex: 1),
            Question(text: "You need to _____ pasta for thirty minutes. Then it is ready to eat.", options: ["cook", "make", "buy"], correctAnswerIndex: 0),
            Question(text: "Andy plays tennis really _____.", options: ["good", "great", "well"], correctAnswerIndex: 2),
        ]),
        Category(name: "Pre-intemidiate test", questions: [
            Question(text: "The synonym for wonderful is _____.", options: ["fantastic", "awful", "fantasy"], correctAnswerIndex: 0),
            Question(text: "You will need a _____ to open a bottle of wine.", options: ["screwcork", "corkscrew", "corker"], correctAnswerIndex: 1),
            Question(text: "The opposite of good-looking is _____.", options: ["handsome", "attractive", "ugly"], correctAnswerIndex: 2),
            Question(text: "You will use a _____ to keep warm at sleep.", options: ["socks", "pillow", "blanket"], correctAnswerIndex: 2),
            Question(text: "Susie is my ex-wife. We _____ 2 years ago.", options: ["married", "divorced", "broke"], correctAnswerIndex: 1),
            Question(text: "A person who takes interviews for a newspaper is a _____.", options: ["reporter", "journalism", "writer"], correctAnswerIndex: 0),
            Question(text: "You need to _____ some water to make tea.", options: ["cook", "drink", "boil"], correctAnswerIndex: 2),
            Question(text: "If I want to put a picture on the wall I will need a _____ and a nail.", options: ["hammer", "battery", "brush"], correctAnswerIndex: 0),
            Question(text: "We need to _____ it with all our colleagues before we decide.", options: ["talk", "discuss", "tell"], correctAnswerIndex: 1),
            Question(text: "I don't have a bank card so I always pay in _____.", options: ["money", "cash", "coins"], correctAnswerIndex: 1),
            Question(text: "I have a car but I don't have a driving _____.", options: ["certificate", "document", "license"], correctAnswerIndex: 2),
            Question(text: "When you pay for something in a store you normally get a _____.", options: ["receipt", "bill", "recipe"], correctAnswerIndex: 0),
            Question(text: "I saw a very good _____ advertisement in a paper last week.", options: ["occupation", "work", "job"], correctAnswerIndex: 2),
            Question(text: "I hate doing the _____, especially washing the windows.", options: ["housework", "homework", "jobs"], correctAnswerIndex: 0),
            Question(text: "She is a bit _____. She always tells you how to do everything.", options: ["lazy", "bossy", "friendly"], correctAnswerIndex: 1),
            Question(text: "You will use _____ to keep your hands warm.", options: ["gloves", "socks", "jeans"], correctAnswerIndex: 0),
            Question(text: "They've just returned from their vacation in Spain. They are all so _____.", options: ["white", "pale", "tanned"], correctAnswerIndex: 2),
            Question(text: "_____ are not animals.", options: ["Wolves", "Eagles", "Hares"], correctAnswerIndex: 2),
            Question(text: "Don't _____ about me. I'll be very careful.", options: ["care", "worry", "think"], correctAnswerIndex: 1),
            Question(text: "I bought a pair of nice _____ for the party.", options: ["slippers", "boots", "high heels"], correctAnswerIndex: 2),
        ]),
        Category(name: "Intemidiate test", questions: [
            Question(text: "You need a/an _____ to sweep the floor.", options: ["vacuum cleaner", "broom", "hammer", "towel"], correctAnswerIndex: 1),
            Question(text: "She is only 17 but seems older. She's very _____ for her age.", options: ["young", "ageing", "middle-aged", "mature"], correctAnswerIndex: 3),
            Question(text: "He looks _____ in these pink pants and green boots.", options: ["weird", "bazar", "gloomy", "brave"], correctAnswerIndex: 0),
            Question(text: "After eating an expired yogurt he had a pain in the _____.", options: ["neck", "ear", "stomach", "head"], correctAnswerIndex: 2),
            Question(text: "_____ is typically not the way to cook potatoes.", options: ["frying", "baking", "drying", "roasting"], correctAnswerIndex: 0),
            Question(text: "You won't receive a _____ for speeding.", options: ["fine", "penalty", "ticket", "card"], correctAnswerIndex: 2),
            Question(text: "Mary likes to add _____ cream to her coffee.", options: ["whipped", "beaten", "kicked", "smacked"], correctAnswerIndex: 0),
            Question(text: "We _____ to inform you that the flight is delayed for 2 hours.", options: ["sorry", "regret", "apologize", "pity"], correctAnswerIndex: 2),
            Question(text: "I'm asking you to _____ my idea about the party.", options: ["agree", "supply", "support", "help"], correctAnswerIndex: 2),
            Question(text: "I only paid $2 for this T-shirt. It was a real _____.", options: ["bargain", "sale", "cheap", "luck"], correctAnswerIndex: 0),
            Question(text: "I have a car but I don't have a driving _____.", options: ["certificate", "document", "diploma", "license"], correctAnswerIndex: 3),
            Question(text: "Mike doesn't have a job. He's _____.", options: ["alone", "employee", "unemployed", "unused"], correctAnswerIndex: 2),
            Question(text: "A/an _____ is not green when it's ripe to eat.", options: ["egg-plant", "cabbage", "cucumber", "broccoli"], correctAnswerIndex: 0),
            Question(text: "I tried to _____ him but he didn't want to change his opinion.", options: ["agree", "persuade", "interrupt", "discuss"], correctAnswerIndex: 1),
            Question(text: "Our national football team _____ the Italians in the game.", options: ["beat", "won", "lost", "passed"], correctAnswerIndex: 0),
            Question(text: "A _____ can't breathe out of water.", options: ["seal", "whale", "salmon", "swan"], correctAnswerIndex: 2),
            Question(text: "A shirt doesn't have _____.", options: ["buttons", "sleeves", "collars", "heels"], correctAnswerIndex: 3),
            Question(text: "His parents gave him everything he asked for. He's really _____.", options: ["upset", "spoilt", "ashamed", "full"], correctAnswerIndex: 1),
            Question(text: "It's been 3 years since my appendicitis surgery. I have a small _____ after it.", options: ["scar", "wound", "bruise", "scratch"], correctAnswerIndex: 0),
            Question(text: "My aunt Lizzy is overweight. She has a double _____.", options: ["fat", "stomach", "cheeks", "chin"], correctAnswerIndex: 2),
        ]),
        Category(name: "Upper-intemidiate test", questions: [
            Question(text: "Poor Sandra is really _____. Recently she has left her laptop at a bus stop.", options: ["opinionated", "shy", "absent-minded", "gloomy"], correctAnswerIndex: 2),
            Question(text: "The boxer recovered, although he had been _____ for ten minutes after the fight.", options: ["unconscious", "asleep", "stopped", "ignorant"], correctAnswerIndex: 0),
            Question(text: "The match was _____ because of the heavy rain. They will play next Tuesday instead.", options: ["put away", "cancelled", "decided", "postponed"], correctAnswerIndex: 3),
            Question(text: "According to the weather _____ this summer is going to be really hot.", options: ["information", "forecast", "program", "news"], correctAnswerIndex: 1),
            Question(text: "My friend is a very _____ guy. He never seems to worry about anything.", options: ["laid-back", "impulsive", "witty", "relaxing"], correctAnswerIndex: 0),
            Question(text: "Heavy snow _____ the train for several hours.", options: ["cancelled", "hindered", "delayed", "postponed"], correctAnswerIndex: 2),
            Question(text: "University students have both _____ and optional subjects on their curriculum.", options: ["obligation", "compulsory", "reserved", "alternative"], correctAnswerIndex: 3),
            Question(text: "We _____ out of fuel on our way back to the camp.", options: ["went", "looked", "came", "ran"], correctAnswerIndex: 3),
            Question(text: "You will need to use a/an _____ to switch channels on the TV.", options: ["remote control", "button", "screwdriver", "scissors"], correctAnswerIndex: 0),
            Question(text: "A/an _____ is not an insect.", options: ["butterfly", "dragonfly", "ant", "chipmunk"], correctAnswerIndex: 3),
            Question(text: "I couldn't come_____ with the answer for the last question in the test.", options: ["down", "up", "over", "under"], correctAnswerIndex: 1),
            Question(text: "_____are not red.", options: ["strawberries", "watermelons", "egg-plants", "beets"], correctAnswerIndex: 1),
            Question(text: "A_____ is not on hospital staff.", options: ["physician", "surgeon", "chemist", "nurse"], correctAnswerIndex: 2),
            Question(text: "During the _____hour our city roads are badly congested.", options: ["harsh", "rush", "hurry", "breaking"], correctAnswerIndex: 1),
            Question(text: "There's a/an _____message for you from the boss.", options: ["vital", "hasty", "essential", "urgent"], correctAnswerIndex: 3),
            Question(text: "The meeting starts at 10.30am_____. Not 10.31 or 10.35am.", options: ["exact", "immediately", "sharp", "on time"], correctAnswerIndex: 3),
            Question(text: "People living around the stadium _____ about the football fans violent behavior.", options: ["complain", "criticize", "object", "disapprove"], correctAnswerIndex: 0),
            Question(text: "Jane's brother was _____ when she didn't call him to congratulate on his birthday.", options: ["exhausted", "worry", "ashamed", "sulky"], correctAnswerIndex: 3),
            Question(text: "You shouldn't leave your bike out under the rain. It'll get _____.", options: ["rotten", "decayed", "rusty", "mouldy"], correctAnswerIndex: 2),
            Question(text: "Three dangerous prisoners _____ from prison last week.", options: ["broke out", "escaped", "released", "ran out of"], correctAnswerIndex: 1),
        ]),
        Category(name: "Advanced test", questions: [
            Question(text: "Unfortunately our new partner turned _____ the invitation for lunch being too busy.", options: ["up", "down", "over", "away"], correctAnswerIndex: 1),
            Question(text: "_____ is a synonym for 'scary'.", options: ["intricate", "creeps", "awesome", "intimidating"], correctAnswerIndex: 1),
            Question(text: "My tutor is absolutely _____. He would consider all factors before taking decision in anybody's favor.", options: ["unbiased", "subjective", "decisive", "friendly"], correctAnswerIndex: 0),
            Question(text: "Human beings normally don't have any _____ in their abdomen.", options: ["intestines", "liver", "lungs", "bladder"], correctAnswerIndex: 2),
            Question(text: "The professor asked our group to hand _____ the essays in the end of the week.", options: ["over", "in", "out", "up"], correctAnswerIndex: 1),
            Question(text: "The soil there is so depleted that no _____ can help grow anything.", options: ["pesticide", "rain", "pollution", "fertilizer"], correctAnswerIndex: 3),
            Question(text: "The dress is a bit loose round the waist. But it shouldn't cost much to have it _____.", options: ["changed", "altered", "ironed", "minimized"], correctAnswerIndex: 1),
            Question(text: "It's so hot. Let's go out and sit in the _____ for a while.", options: ["shadow", "roof", "shade", "kitchen"], correctAnswerIndex: 2),
            Question(text: "W..W..Would you m..m..mind opening the w..w..window. - She was so nervous that she started _____ all of a sudden.", options: ["stammering", "lisping", "repeating", "boasting"], correctAnswerIndex: 0),
            Question(text: "A/an _____ is not a part of an eye.", options: ["lash", "iris", "pupil", "thigh"], correctAnswerIndex: 3),
            Question(text: "He looked quite convincing dressed as a woman. Only his moustache gave him _____.", options: ["away", "out", "over", "a hand"], correctAnswerIndex: 0),
            Question(text: "The defendant _____ not guilty in the beginning of the trial.", options: ["announced", "pleased", "pleaded", "informed"], correctAnswerIndex: 2),
            Question(text: "Our mortgage conditions are excellent. The _____ rate is only 3%.", options: ["interested", "interest", "exciting", "exchange"], correctAnswerIndex: 1),
            Question(text: "Criminals under 16 are tried at the _____ court.", options: ["youth", "youngsters", "rejuvenating", "juvenile"], correctAnswerIndex: 3),
            Question(text: "A _____ looking as piano keys is read by a computer in the supermarkets.", options: ["label", "barcode", "price tag", "sticker"], correctAnswerIndex: 1),
            Question(text: "A _____ doesn't measure volumes of liquid.", options: ["box", "jar", "barrel", "can"], correctAnswerIndex: 0),
            Question(text: "A _____ is not a part of a human organism.", options: ["knuckle", "throat", "trout", "rib"], correctAnswerIndex: 2),
            Question(text: "One of the dog's front legs was apparently broken judging by how he was _____ along the road.", options: ["crawling", "strolling", "limping", "climbing"], correctAnswerIndex: 2),
            Question(text: "Woodpeckers use their _____ to peck at pests inside the tree.", options: ["beaks", "claws", "paws", "talons"], correctAnswerIndex: 0),
            Question(text: "_____ his car skidded on the road and went into the ditch.", options: ["Being in the red", "Out of the blue", "Showing true colors", "With flying colors"], correctAnswerIndex: 1),
        ])
        
        
        ,]
    
    
    
    
    var body: some View {
           NavigationView {
               VStack {
                   NavigationLink(destination: FlashcardListView(flashcards: flashcards)) {
                       Text("Open Flashcards")
                           .foregroundColor(Color("Color 4"))
                           .bold()
                           
                   }
                   
                   List(categories, id: \.name) { category in
                       NavigationLink(destination: TestListView(questions: category.questions, totalPoints: $totalPoints)) {
                           Text(category.name)
                               .font(.headline)
                               .foregroundColor(.black)
                               .padding()
                       }
                   }
                   .navigationBarTitle("Categories", displayMode: .large)
                   .accentColor(.black)
                   .foregroundColor(Color("Color 4"))
                   .bold()
                   .accentColor(Color("Color 4"))
                   .navigationBarItems(trailing: Button("Reset Points") {
                       totalPoints = 0
                       
                   }).accentColor(Color("Color 4"))
                       .bold()
               }
           }
           .accentColor(.black)
       }
   }
   struct TestListView: View {
       var questions: [Question]
       @Binding var totalPoints: Int

       var body: some View {
           NavigationView {
               List(questions, id: \.text) { question in
                   NavigationLink(destination: QuestionView(question: question, totalPoints: $totalPoints)) {
                       Text(question.text)
                           .font(.headline)
                           .foregroundColor(.black)
                           .bold()
                           .padding()
                   }
               }
               .navigationBarTitle("Tests", displayMode: .large)
               .navigationBarItems(trailing: Text("Total Points: \(totalPoints)"))
               .accentColor(Color("Color 4"))
               .foregroundColor(Color("Color 4"))
               .bold()
           }.accentColor(.black)
           
         
             
       }
   }

   struct QuestionView: View {
       
       var question: Question
       @Binding var totalPoints: Int
       @State private var selectedAnswerIndex: Int = -1
       @State private var isAnswerCorrect: Bool = false
       @State private var showFeedback: Bool = false

       var body: some View {
           VStack {
               Text(question.text)
                   .font(.title)
                   .foregroundColor(.black)
                   .multilineTextAlignment(.center)
                   .lineLimit(3)
                   .padding()

               ForEach(0..<question.options.count, id: \.self) { index in
                   Button(action: {
                       selectedAnswerIndex = index
                       isAnswerCorrect = (index == question.correctAnswerIndex)
                       showFeedback = true
                       if isAnswerCorrect {
                           totalPoints += 1
                       }
                   }) {
                       Text(question.options[index])
                           .font(.headline)
                           .foregroundColor(.white)
                           .frame(width: 320, height: 30)
                           .padding()
                           .background(
                               RoundedRectangle(cornerRadius: 10)
                                   .fill(selectedAnswerIndex == index ? (isAnswerCorrect ? Color("Color 2") : Color("Color 4")) : Color("Color 6"))
                           )
                           .padding(.vertical, 5)
                           .opacity(showFeedback ? 0.7 : 1.0)
                           .animation(.easeInOut(duration: 0.3))
                   }
                   .padding(.vertical, 4)
               }

               Text(isAnswerCorrect ? "Correct!" : "Try Again!")
                   .font(.headline)
                   .foregroundColor(isAnswerCorrect ? .green : Color("Color 4"))
                   .padding(.top)
                   .opacity(showFeedback ? 1.0 : 0.0)
                   .animation(.easeInOut(duration: 0.5))

               Spacer()
           }
           .navigationBarTitle("Question", displayMode: .inline)
           .navigationBarItems(trailing: Button("Reset Points") {
               totalPoints = 0
           })
           Button("Collect Points") {
               if !showFeedback && selectedAnswerIndex != -1 {
                   selectedAnswerIndex = -1
                   showFeedback = true
               }
           }
           .font(.headline)
           .foregroundColor(.white)
           .frame(width: 200, height: 40)
           .background(RoundedRectangle(cornerRadius: 10).fill(Color("Color")))
           .padding(.top, 400)
           .opacity(showFeedback ? 0.0 : 1.0)
           .animation(.easeInOut(duration: 0.5))
       }
   }

struct GraduationCapView: View {
    var body: some View {
        NavigationView {
            NewsListView()
                .navigationBarTitle("BBC News", displayMode: .large)
        }
    }
}

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let link: URL
    let imageUrl: URL?
    let fullArticleLink: URL // Add this property
}

struct NewsListView: View {
    @State private var newsItems: [NewsItem] = []
    @State private var searchText: String = ""
    
    var filteredNewsItems: [NewsItem] {
        if searchText.isEmpty {
            return newsItems
        } else {
            return newsItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search News")
                .padding(.horizontal)
            
            List(filteredNewsItems) { newsItem in
                Link(destination: newsItem.link, label: {
                    HStack(spacing: 12) {
                        if let imageUrl = newsItem.imageUrl {
                            RemoteImage(url: imageUrl)
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        } else {
                            Color.gray // Placeholder for missing image
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(newsItem.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            Text("Read more")
                                .font(.subheadline)
                                .foregroundColor(Color("Color 4"))
                        }
                        .padding(.trailing, 8)
                    }
                    .frame(height: 100)
                    .padding(10)
                    .background(Color("background"))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .onAppear(perform: fetchNews)
            .navigationTitle("BBC News")
        }
    }

    func fetchNews() {
        guard let url = URL(string: "https://www.bbc.com/news") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let html = String(data: data, encoding: .utf8) {
                    do {
                        try parseHTML(html)
                    } catch {
                        print("Error parsing HTML: \(error)")
                    }
                }
            }
        }.resume()
    }

    func parseHTML(_ html: String) throws {
        let doc = try SwiftSoup.parse(html)
        let promoBlocks = try doc.select(".gs-c-promo")
        
        newsItems = try promoBlocks.map { block in
            let title = try block.select(".gs-c-promo-heading").text()
            let linkString = try block.select("a").attr("href")
            let imageUrlString = try block.select("img").attr("src")
            let fullArticleLinkString = try block.select("a").attr("href") // Assuming this is the link to the full article
            
            let link = URL(string: linkString)!
            let imageUrl = URL(string: imageUrlString)
            let fullArticleLink = URL(string: fullArticleLinkString)!
            
            return NewsItem(title: title, link: link, imageUrl: imageUrl, fullArticleLink: fullArticleLink)
        }
    }
    
    struct SearchBar: View {
        @Binding var text: String
        var placeholder: String

        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct WebView: View {
    let url: URL

    var body: some View {
        WebViewWrapper(url: url)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(url.host ?? "")
    }
}

struct WebViewWrapper: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct RemoteImage: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholderImage = Image(systemName: "photo")
    
    init(url: URL) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholderImage
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        load(url)
    }
    
    private func load(_ url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] image in
                self?.image = image
            })
    }
}
