//
//  Chapter.swift
//  ReaderViewExample
//
//  Created by Matthew Waller on 9/13/24.
//

import SwiftUI

struct Chapter: Identifiable {
    var id = UUID()
    var text: NSAttributedString
    
    static func makeChapterOne() -> NSAttributedString {
        let storyText = """
        Chapter 1: The Woods that Whisper

        In the heart of the Emerald Valley, where mist clung to ancient trees and secrets lingered in the shadows, stood the Whispering Woods. For generations, the people of Millbrook had lived alongside its borders, their lives intertwined with the forest's mysteries.

        Lila Greene, a curious girl of twelve with unruly red hair and bright green eyes, had always been drawn to the woods. Despite her parents' warnings and the village elders' tales of those who ventured in and never returned, she couldn't resist its call.

        On the morning of the summer solstice, as golden light filtered through her bedroom window, Lila made a decision. Today would be the day she'd finally explore the Whispering Woods.

        She packed a small bag with bread, cheese, and a waterskin. In her pocket, she tucked a smooth river stone—a gift from her late grandmother, who'd always encouraged Lila's adventurous spirit.

        As Lila crept out of the house, the village was still asleep. Dew-laden grass dampened her shoes as she made her way to the forest's edge. The trees loomed before her, their branches swaying gently in a breeze she couldn't feel.

        Taking a deep breath, Lila stepped into the woods. Immediately, the air changed. It felt thicker, charged with an energy she couldn't explain. The sounds of the village faded away, replaced by the soft rustling of leaves and distant, melodic whispers.

        Lila followed a narrow path that wound between ancient oaks and silver birches. Shafts of sunlight pierced the canopy, creating dappled patterns on the forest floor. As she walked deeper into the woods, the whispers grew louder, almost forming words she could almost understand.

        Suddenly, a flash of blue caught her eye. A butterfly with wings that shimmered like sapphires fluttered past her face. Without thinking, Lila followed it, leaving the path behind.

        The butterfly led her to a small clearing where a circle of white stones gleamed in the filtered sunlight. In the center stood an ancient willow tree, its branches hanging low, creating a curtain of green.

        As Lila approached the willow, the whispers crescendoed. The branches parted on their own, revealing a hidden grotto. There, nestled among gnarled roots, was a small, ornate box.

        With trembling hands, Lila reached for the box. As her fingers brushed its surface, the whispers suddenly became clear. They were voices—hundreds of them—telling stories of the forest, of magic long forgotten, of a destiny waiting to unfold.

        Lila knew, in that moment, that her life would never be the same. The Whispering Woods had chosen her, and a great adventure was about to begin.
        """

        let attributedString = NSMutableAttributedString(string: storyText)

        // Define attributes
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let italicFont = UIFont.italicSystemFont(ofSize: bodyFont.pointSize)

        let bodyAttributes = [NSAttributedString.Key.font: bodyFont]
        let titleAttributes = [NSAttributedString.Key.font: titleFont]
        let italicAttributes = [NSAttributedString.Key.font: italicFont]

        // Apply body style to entire text
        attributedString.addAttributes(bodyAttributes, range: NSRange(location: 0, length: storyText.count))

        let titleRange = (storyText as NSString).range(of: "Chapter 1: The Woods that Whisper")
        attributedString.addAttributes(titleAttributes, range: titleRange)

        // Apply italic style to specific phrases
        let italicPhrases = ["Whispering Woods", "Emerald Valley", "Millbrook"]
        for phrase in italicPhrases {
            var searchRange = NSRange(location: 0, length: storyText.count)
            while true {
                let range = (storyText as NSString).range(of: phrase, options: [], range: searchRange)
                if range.location != NSNotFound {
                    attributedString.addAttributes(italicAttributes, range: range)
                    searchRange = NSRange(location: range.location + range.length, length: storyText.count - (range.location + range.length))
                } else {
                    break
                }
            }
        }
        
        return attributedString
    }
    
    static func makeChapterTwo() -> NSAttributedString {
        let storyText = """
        Chapter 2: The Enchanted Box

        Lila's heart raced as she held the ornate box in her trembling hands. Its surface was cool to the touch, adorned with intricate carvings of leaves and vines that seemed to shift and move in the dappled sunlight of the Whispering Woods.

        With bated breath, she lifted the lid. A soft, melodious chime filled the air, and a warm glow emanated from within. Inside, nestled on a bed of moss, lay a single acorn. But this was no ordinary acorn—it shimmered with an inner light, pulsing gently like a tiny, golden heart.

        As Lila reached for the acorn, a voice whispered in her ear, carried on a breeze that rustled through the willow's branches. "With great power comes great responsibility, young one. Are you ready for the journey ahead?"

        Startled, Lila spun around, but she was alone in the grotto. The voices of the forest had spoken directly to her. Swallowing her fear, she picked up the acorn. Instantly, warmth spread through her body, and images flashed before her eyes—ancient trees, mystical creatures, and a looming darkness threatening the heart of the forest.

        Suddenly, a twig snapped behind her. Lila whirled around to see an elderly man emerge from the shadows. His long silver beard was adorned with leaves and twigs, and his eyes sparkled with an ageless wisdom.

        "I am Eldrin, guardian of the Whispering Woods," he said, his voice as deep and rich as the earth itself. "You, Lila Greene, have been chosen by the forest. The acorn you hold is the last seed of the Great Oak, the oldest and wisest tree in our realm. It has slumbered for a thousand years, waiting for the right person to awaken its power."

        Lila's mind reeled. "But why me?" she asked, her voice barely a whisper.

        Eldrin smiled kindly. "The forest sees what others cannot. You have a pure heart and a brave spirit. The darkness that threatens us can only be defeated by one who truly listens to the whispers of the woods."

        As if in response, the acorn pulsed brightly in Lila's palm. She felt a surge of courage and determination. "What must I do?" she asked.

        "You must plant the acorn in the heart of the Dark Thicket," Eldrin explained. "Its light will push back the encroaching shadows and restore balance to the forest. But beware—the journey will be perilous. The forces of darkness will try to stop you at every turn."

        Lila nodded, her jaw set with resolve. She carefully placed the acorn back in the box and tucked it into her bag. As she did so, her river stone fell out of her pocket, landing softly on the forest floor. To her amazement, it began to glow with the same golden light as the acorn.

        Eldrin's eyes widened. "Your grandmother's stone... It's a key! It will guide you through the forest and unlock ancient magics to aid you on your quest."

        Lila picked up the stone, feeling its comforting warmth. She realized now why she had always felt drawn to the Whispering Woods. This was her destiny.

        "I'm ready," she said, her voice firm and clear.

        Eldrin nodded approvingly. "Then let us begin your training, young Lila. The fate of the Whispering Woods—and perhaps the world beyond—rests in your hands."

        As they left the grotto, the whispering of the woods grew louder, filling Lila with a sense of purpose and belonging. Her great adventure had truly begun, and she was ready to face whatever challenges lay ahead.
        """

        let attributedString = NSMutableAttributedString(string: storyText)

        // Define attributes
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let italicFont = UIFont.italicSystemFont(ofSize: bodyFont.pointSize)

        let bodyAttributes = [NSAttributedString.Key.font: bodyFont]
        let titleAttributes = [NSAttributedString.Key.font: titleFont]
        let italicAttributes = [NSAttributedString.Key.font: italicFont]

        // Apply body style to entire text
        attributedString.addAttributes(bodyAttributes, range: NSRange(location: 0, length: storyText.count))

        // Apply title style to chapter title
        let titleRange = (storyText as NSString).range(of: "Chapter 2: The Enchanted Box")
        attributedString.addAttributes(titleAttributes, range: titleRange)

        // Apply italic style to specific phrases
        let italicPhrases = ["Whispering Woods", "Great Oak", "Dark Thicket"]
        for phrase in italicPhrases {
            var searchRange = NSRange(location: 0, length: storyText.count)
            while true {
                let range = (storyText as NSString).range(of: phrase, options: [], range: searchRange)
                if range.location != NSNotFound {
                    attributedString.addAttributes(italicAttributes, range: range)
                    searchRange = NSRange(location: range.location + range.length, length: storyText.count - (range.location + range.length))
                } else {
                    break
                }
            }
        }

        return attributedString
    }
}
