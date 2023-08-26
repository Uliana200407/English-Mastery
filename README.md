<a href="https://developer.apple.com/xcode/swiftui/"><img src="https://img.icons8.com/?size=512&id=24465&format=png" align="right" width="10%"></a>
<img src="https://i.imgur.com/2wXKp4n.png" align="right" width="10%"></a>
# English-Mastery app
## Description
_**Elevate Your Language Proficiency with Ease!**_

Introducing Mastery English: the revolutionary SwiftUI-based mobile app that transforms language learning into a captivating adventure. Elevate your English proficiency, access an online library of captivating English books, and stay updated with BBC news. Enjoy interactive tests and expand your vocabulary effortlessly with engaging flashcards.
### English Mastery phone views


<table>
  <tr>
    <td align="center"><strong>Launch screen</strong><br><img src="https://i.imgur.com/Dn7xGdv.png" alt="Telephone Image 1"></td>
    <td align="center"><strong>Authorization view</strong><br><img src="https://i.imgur.com/oFrqpEi.png" alt="Telephone Image 3"></td>
    <td align="center"><strong>Rigistration view</strong><br><img src="https://i.imgur.com/ChPspvx.png" alt="Telephone Image 4"></td>
    <td align="center"><strong>User profile view</strong><br><img src="https://i.imgur.com/rYXL1ui.png" alt="Telephone Image 2"></td>
  </tr>
</table>

<table>
  <tr>
    <td align="center"><strong>Book library view</strong><br><img src="https://i.imgur.com/NzUhZa5.png" alt="Telephone Image 3"></td>
    <td align="center"><strong>Detailed data view</strong><br><img src="https://i.imgur.com/CdJKqWz.png" alt="Telephone Image 4"></td>
    <td align="center"><strong>Tests view</strong><br><img src="https://i.imgur.com/DFL4sT3.png" alt="Telephone Image 1"></td>
    <td align="center"><strong>Flashcards view</strong><br><img src="https://i.imgur.com/oDsO30R.png" alt="Telephone Image 2"></td>
  </tr>
</table>

### Components of the ios application
<td align="center">
  <img src="https://i.imgur.com/DfJsfbD.png" alt="Telephone Image 3" style="max-width: 100px;">
</td>

## Functionality List

- **Book Library:** Explore a collection of English books.
- **Read and Download:** Read books online and download them for offline access.
- **Interactive Tests:** Take tests and earn scores to track your progress.
- **Idioms Flashcards:** Study English idioms with flashcards.
- **BBC News Updates:** Stay updated with the latest news from BBC.
- **User Profiles:** Register and manage your profile using Firebase database.
### Colors & Typography
<td align="center">
  <img src="https://i.imgur.com/tyaVX1Y.png" alt="Telephone Image 3" style="max-width: 100px;">
</td>

### HTML content-parsing from BBC site

```
 func parseHTML(_ html: String) throws {
        let doc = try SwiftSoup.parse(html)
        let promoBlocks = try doc.select(".gs-c-promo")
        
        newsItems = try promoBlocks.map { block in
            let title = try block.select(".gs-c-promo-heading").text()
            let linkString = try block.select("a").attr("href")
            let imageUrlString = try block.select("img").attr("src")
            let fullArticleLinkString = try block.select("a").attr("href") 
            
            let link = URL(string: linkString)!
            let imageUrl = URL(string: imageUrlString)
            let fullArticleLink = URL(string: fullArticleLinkString)!
            
            return NewsItem(title: title, link: link, imageUrl: imageUrl, fullArticleLink: fullArticleLink)
        }
    }
```
### Video demonstration

[Tap to watch the video](https://youtu.be/sSr6kcCJHhc?si=1fQWkhCB9W3YChPF)

