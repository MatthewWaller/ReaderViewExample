//
//  ReaderView.swift
//  ReaderViewExample
//
//  Created by Matthew Waller on 9/13/24.
//

import SwiftUI
import Observation


struct Page: Identifiable, Hashable {
    let id = UUID()
    let content: NSAttributedString
    let chapterId: UUID
    let startingCharacter: Int
    let pageNumber: Int
}

@Observable
class Book {
    var chapters: [Chapter] = [
        Chapter(text: Chapter.makeChapterOne()),
        Chapter(text: Chapter.makeChapterTwo())
    ]
}

struct ReaderView: View {
    @AppStorage("bookmark") private var bookmark: Int = 0
    @State private var book = Book()
    @State private var size: CGSize = .zero
    @State private var pages: [Page] = [
        Page(content: .init(string: ""),
             chapterId: UUID(),
             startingCharacter: 0,
            pageNumber: 1)
    ]
    @State private var selectedPageId: UUID = UUID()
    @State private var startingCharacter: Int? = nil
    
    func getPages(forSize size: CGSize) {
        pages = paginateChapters(book.chapters, size: size)
        if pages.isEmpty {
            pages = [
                Page(content: .init(string: ""),
                     chapterId: UUID(),
                     startingCharacter: 0,
                    pageNumber: 1),
            ]
        }
        
        if let startingCharacter {
            for page in pages {
                if page.startingCharacter >= startingCharacter {
                    selectedPageId = page.id
                    break
                }
            }
        }
    }
    
    func paginateChapters(_ chapters: [Chapter], size: CGSize) -> [Page] {
        var pages: [Page] = []
        
        var currentCharacterCount = 0
        var currentPageNumber = 1
        for chapter in chapters {
            let attributedString = chapter.text
            let nextPages = paginate(attributedString,
                                     size: size,
                                     chapterId: chapter.id, latestCharacterCount: currentCharacterCount,
            currentPageNumber: currentPageNumber)
            if let lastPage = nextPages.last {
                currentCharacterCount = lastPage.startingCharacter + lastPage.content.length
            }
            
            currentPageNumber += nextPages.count
            pages.append(contentsOf: nextPages)
        }
        
        return pages
    }
    
    private func paginate(_ attributedString: NSAttributedString,
                          size: CGSize,
                          chapterId: UUID,
                          latestCharacterCount: Int,
                          currentPageNumber: Int) -> [Page] {
        // Ensure there's at least a font attribute throughout the string
        let mutableString = NSMutableAttributedString(attributedString: attributedString)
        
        let framesetter = CTFramesetterCreateWithAttributedString(mutableString)
        let path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        var pages: [Page] = []
        var currentIndex = 0
        let totalLength = mutableString.length
        var currentPageGroupNumber = 0
        while currentIndex < totalLength {
            let frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(currentIndex, 0), path, nil)
            let range = CTFrameGetVisibleStringRange(frameRef)
            
            if range.length > 0 {
                let pageContent = mutableString.attributedSubstring(from: NSRange(location: currentIndex, length: range.length))
                let trimmedContent = pageContent.trimmingTrailingWhitespacesAndNewlines()
                pages.append(
                    Page(content: trimmedContent,
                         chapterId: chapterId,
                         startingCharacter: currentIndex + latestCharacterCount,
                        pageNumber: currentPageNumber + currentPageGroupNumber))
                currentIndex += range.length
                currentPageGroupNumber += 1
            } else {
                break
            }
        }
        
        return pages
    }
    
    var body: some View {
        TabView(selection: $selectedPageId) {
            ForEach(pages) { page in
                VStack {
                    VStack {
                        SizeReaderLayout(size: $size) {
                            VStack {
                                Text(AttributedString(page.content))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            }
                        }
                        .tag(page.id)
                    }
                    .padding()
                    .padding(.bottom)
                    .padding(.bottom)
                }.overlay {
                    VStack {
                        Spacer()
                        HStack {
                            Text("\(page.pageNumber)/\(pages.count)")
                                .padding()
                            Spacer()
                        }
                    }
                }
            }
        }
        .onChange(of: size) { _, newValue in
            getPages(forSize: newValue)
        }
        .onChange(of: selectedPageId) { oldValue, newValue in
            let selectedPage = pages.first { page in
                page.id == newValue
            }
            
            if let selectedPage {
                setBookmark(appearedPage: selectedPage)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .toolbar {
            ToolbarItem {
                Menu {
                    ForEach(book.chapters) { chapter in
                        Button {
                            let pageId = pages.first(where: { page in
                                page.chapterId == chapter.id
                            })?.id
                            selectedPageId = pageId ?? UUID()
                        } label: {
                            Text((chapter.text.string).prefix(20))
                        }
                    }
                } label: {
                    Text("Chapters")
                }
            }
        }
        .task {
            self.startingCharacter = bookmark
        }
    }
    
    func setBookmark(appearedPage: Page) {
        bookmark = appearedPage.startingCharacter
    }
}

struct SizeReaderLayout: Layout {
    @Binding var size: CGSize
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let subview = subviews.first else { return .zero }
        
        let size = subview.sizeThatFits(proposal)
        Task.detached { @MainActor in
            self.size = size
        }
        
        return size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard let subview = subviews.first else { return }
        
        subview.place(at: bounds.origin, proposal: proposal)
    }
}

extension NSAttributedString {
    func trimmingTrailingWhitespacesAndNewlines() -> NSAttributedString {
        let invertedSet = CharacterSet.whitespacesAndNewlines.inverted
        let range = (string as NSString).rangeOfCharacter(from: invertedSet, options: .backwards)
        
        if range.location != NSNotFound {
            return attributedSubstring(from: NSRange(location: 0, length: range.location + range.length))
        }
        
        return NSAttributedString(string: "")
    }
}

#Preview {
    NavigationStack {
        ReaderView()
            .navigationBarTitleDisplayMode(.inline)
    }
}

