//
//  Books.swift
//  English Mastery
//
//  Created by mac on 08.07.2023.
//

import SwiftUI

struct Books: Identifiable,Hashable{
    var id: String = UUID().uuidString
    var title: String
    var imageName: String
    var author: String
    var rating: Int
    var bookYear: Int
    var description: String
    var URL: String
}

var BuiltInBooks: [Books] = [
    .init(title: "She Lies Close", imageName: "Cover1", author: "Sharon Doering", rating: 3, bookYear: 2020,description:"This book is one of those that throws you off course constantly and absolutely wows you no end when you finish. I’m a little lost for words right now! I’ve had this on my TBR list for way too long and I got a deep sense of satisfaction when I read that last page. This book is such an immense debut from Sharon Doering and if you love a book which messes with your head a little and makes you question everything, this is the one for you. So happy to share my review of this seriously unforgettable book!", URL:"https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "The Coward", imageName: "Cover2", author: "Stephen Aryan", rating: 4, bookYear: 1965,description:"Who will take up the mantle and slay the evil in the Frozen North, saving all from death and destruction? Not Kell Kressia, he's done his part...Kell Kressia is a legend, a celebrity, a hero. Aged just seventeen he set out on an epic quest with a band of wizened fighters to slay the Ice Lich and save the world, but only he returned victorious. The Lich was dead, the ice receded and the Five Kingdoms were safe.", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "Troy", imageName: "Cover4", author: "Stephen Fry", rating: 5, bookYear: 2000,description:"In this brilliant conclusion to his bestselling  Mythos  trilogy, legendary author and actor Stephen Fry retells the tale of the Trojan War with his trademark wit and vibrance.Full of tragic heroes, intoxicating love stories, and the unstoppable force of fate, there is no conflict more iconic than the Trojan War.  Troy  is the story of the epic battle retold by Fry with drama, humor, and vivid emotion.", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "Here The Whole Time", imageName: "Cover5", author: "Vitor Martins", rating: 4, bookYear: 2017,description:"The charm and humor of To All the Boys I've Loved Before meets Dumplin' in this body-positive YA love story between two boys who must spend 15 days living with each other over school break.What would you do if you had to spend the next 15 days with your lifelong crush?", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "Rabitts", imageName: "Cover8", author: "Tery Miles", rating: 4, bookYear: 1998,description:"Have you ever questioned the nature of your reality? Found some strange coincidences and patterns that seem to hint at something larger? If the answers to those questions are yes, chances are you’re probably part of Rabbits. Or maybe you’re not. Maybe it’s all just an elaborate hoax.", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "The Night Tiger", imageName: "Cover6", author: "Yanksze Choo", rating: 4, bookYear: 2019,description:"An utterly transporting novel set in 1930s colonial Malaysia, perfect for fans of Isabel Allende and Min Jin Lee. Quick-witted, ambitious Ji Lin is stuck as an apprentice dressmaker, moonlighting as a dancehall girl to help pay off her mother’s Mahjong debts. But when one of her dance partners accidentally leaves behind a gruesome souvenir, Ji Lin may finally get the adventure she has been longing for.", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "The Liar of Red Valley", imageName: "Cover7", author: "Walter Goodwater", rating: 5, bookYear: 2021,description:"In Red Valley, California, you follow the rules if you want to stay alive. But they won’t be enough to protect Sadie now that she’s become the Liar, the keeper of the town’s many secrets. Friendships are hard-won here, and it isn’t safe to make enemies.", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "The Mother Next Door", imageName: "Cover9", author: "Tara Laskowski", rating: 4, bookYear: 2021,description:"“If the women of Big Little Lies were the moms of East Coast high schoolers, they'd be right at home in The Mother Next Door - a witty, wicked thriller packed with hidden agendas, juicy secrets, and pitch-perfect satire of the suburban dream.” (Andrea Bartz, author of The Lost Night and The Herd)", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Voices-of-Unbelief-Documents-from-Atheists-and-Agnostics-Edited-by-Dale-McGowan.pdf"),
    
        .init(title: "Tonight We Rule the World", imageName: "Cover3", author: "Zack Smedley", rating: 4, bookYear: 2021,description:"In the beginning, Owen’s story was blank . . . then he was befriended by Lily, the aspiring author who helped him find his voice. Together, the two have spent years navigating first love and amassing an inseparable friend group. But all of it is upended one day when his school’s administration learns Owen’s that he was sexually assaulted by a classmate.", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/Percy-Jackson-1-The-Lightning.pdf"),
    
        .init(title: "The Right Side of Reckless", imageName: "Cover10", author: " Whitney D.Grandison", rating: 3, bookYear: 2021,description:"He’s never met a rule he didn’t break… She’s followed the rules her whole life… When they meet, one golden rule is established: stay away. Sparks fly in this edgy own voices novel, perfect for fans of Sandhya Menon, S. K. Ali, and Kristina Forest.", URL: "https://pdflibrary.co.in/wp-content/uploads/2023/07/The-Wind-Knows-My-Name-Book-by-Isabel-Allende.pdf"),

]

