import 'package:flutter/material.dart';
import '../l10n/strings.dart';

/// One alphabet flashcard: a letter, an example word (in each language),
/// and an icon to stand in for illustration art.
class LetterCard {
  final String letter;
  final Map<AppLanguage, String> word;
  final IconData icon;
  const LetterCard(this.letter, this.word, this.icon);
}

/// Full A-Z set. Swap the [icon] for a real illustration asset later -
/// see README "Replacing placeholder art".
final List<LetterCard> alphabetData = [
  LetterCard('A', {AppLanguage.en: 'Apple', AppLanguage.hi: 'सेब'}, Icons.apple),
  LetterCard('B', {AppLanguage.en: 'Ball', AppLanguage.hi: 'गेंद'}, Icons.sports_baseball),
  LetterCard('C', {AppLanguage.en: 'Cat', AppLanguage.hi: 'बिल्ली'}, Icons.pets),
  LetterCard('D', {AppLanguage.en: 'Dog', AppLanguage.hi: 'कुत्ता'}, Icons.pets),
  LetterCard('E', {AppLanguage.en: 'Elephant', AppLanguage.hi: 'हाथी'}, Icons.elderly),
  LetterCard('F', {AppLanguage.en: 'Fish', AppLanguage.hi: 'मछली'}, Icons.set_meal),
  LetterCard('G', {AppLanguage.en: 'Goat', AppLanguage.hi: 'बकरी'}, Icons.grass),
  LetterCard('H', {AppLanguage.en: 'Hat', AppLanguage.hi: 'टोपी'}, Icons.checkroom),
  LetterCard('I', {AppLanguage.en: 'Ice cream', AppLanguage.hi: 'आइसक्रीम'}, Icons.icecream),
  LetterCard('J', {AppLanguage.en: 'Juice', AppLanguage.hi: 'जूस'}, Icons.local_bar),
  LetterCard('K', {AppLanguage.en: 'Kite', AppLanguage.hi: 'पतंग'}, Icons.air),
  LetterCard('L', {AppLanguage.en: 'Lion', AppLanguage.hi: 'शेर'}, Icons.pets),
  LetterCard('M', {AppLanguage.en: 'Moon', AppLanguage.hi: 'चाँद'}, Icons.nightlight_round),
  LetterCard('N', {AppLanguage.en: 'Nest', AppLanguage.hi: 'घोंसला'}, Icons.forest),
  LetterCard('O', {AppLanguage.en: 'Orange', AppLanguage.hi: 'संतरा'}, Icons.circle),
  LetterCard('P', {AppLanguage.en: 'Parrot', AppLanguage.hi: 'तोता'}, Icons.flutter_dash),
  LetterCard('Q', {AppLanguage.en: 'Queen', AppLanguage.hi: 'रानी'}, Icons.emoji_events),
  LetterCard('R', {AppLanguage.en: 'Rabbit', AppLanguage.hi: 'खरगोश'}, Icons.cruelty_free),
  LetterCard('S', {AppLanguage.en: 'Sun', AppLanguage.hi: 'सूरज'}, Icons.wb_sunny),
  LetterCard('T', {AppLanguage.en: 'Tiger', AppLanguage.hi: 'बाघ'}, Icons.pets),
  LetterCard('U', {AppLanguage.en: 'Umbrella', AppLanguage.hi: 'छाता'}, Icons.umbrella),
  LetterCard('V', {AppLanguage.en: 'Van', AppLanguage.hi: 'वैन'}, Icons.airport_shuttle),
  LetterCard('W', {AppLanguage.en: 'Watch', AppLanguage.hi: 'घड़ी'}, Icons.watch),
  LetterCard('X', {AppLanguage.en: 'Xylophone', AppLanguage.hi: 'जाइलोफोन'}, Icons.piano),
  LetterCard('Y', {AppLanguage.en: 'Yak', AppLanguage.hi: 'याक'}, Icons.pets),
  LetterCard('Z', {AppLanguage.en: 'Zebra', AppLanguage.hi: 'ज़ेबरा'}, Icons.pets),
];

/// 1-100, generated rather than hand-typed. Number words are spoken via TTS
/// (flutter_tts pronounces digits correctly in both English and Hindi).
final List<int> numbersData = List<int>.generate(100, (i) => i + 1);

/// Memory-game icon sets, one list per difficulty. Easy = fewer pairs.
final Map<String, List<IconData>> memoryIconSets = {
  'easy': [Icons.pets, Icons.star, Icons.favorite, Icons.wb_sunny],
  'medium': [
    Icons.pets, Icons.star, Icons.favorite, Icons.wb_sunny,
    Icons.cake, Icons.umbrella,
  ],
  'hard': [
    Icons.pets, Icons.star, Icons.favorite, Icons.wb_sunny,
    Icons.cake, Icons.umbrella, Icons.icecream, Icons.emoji_events,
  ],
};

/// A single coloring page: named regions the child can tap to fill.
/// Each region is described as a simple path built at render time in
/// creative_zone_screen.dart - this record just carries the region ids
/// and a display name so more pages can be added without touching UI code.
class ColoringPage {
  final String id;
  final Map<AppLanguage, String> name;
  final List<String> regionIds;
  const ColoringPage(this.id, this.name, this.regionIds);
}

final List<ColoringPage> coloringPages = [
  ColoringPage('sun', {AppLanguage.en: 'Sun', AppLanguage.hi: 'सूरज'}, ['body']),
  ColoringPage('flower', {AppLanguage.en: 'Flower', AppLanguage.hi: 'फूल'}, ['petals', 'center']),
  ColoringPage('heart', {AppLanguage.en: 'Heart', AppLanguage.hi: 'दिल'}, ['body']),
  ColoringPage('fish', {AppLanguage.en: 'Fish', AppLanguage.hi: 'मछली'}, ['body', 'tail']),
  ColoringPage('house', {AppLanguage.en: 'House', AppLanguage.hi: 'घर'}, ['roof', 'wall', 'door']),
];

/// One quiz question for Team Challenge, with per-language text so the
/// parent and child can both play in their preferred language.
class QuizQuestion {
  final Map<AppLanguage, String> question;
  final Map<AppLanguage, List<String>> options;
  final Map<AppLanguage, String> answer;
  const QuizQuestion(this.question, this.options, this.answer);
}

final List<QuizQuestion> quizBank = [
  QuizQuestion(
    {AppLanguage.en: 'Which letter comes after B?', AppLanguage.hi: 'B के बाद कौन सा अक्षर आता है?'},
    {AppLanguage.en: ['A', 'C', 'D', 'E'], AppLanguage.hi: ['A', 'C', 'D', 'E']},
    {AppLanguage.en: 'C', AppLanguage.hi: 'C'},
  ),
  QuizQuestion(
    {AppLanguage.en: 'How many legs does a cat have?', AppLanguage.hi: 'बिल्ली के कितने पैर होते हैं?'},
    {AppLanguage.en: ['2', '3', '4', '6'], AppLanguage.hi: ['2', '3', '4', '6']},
    {AppLanguage.en: '4', AppLanguage.hi: '4'},
  ),
  QuizQuestion(
    {AppLanguage.en: 'What color do you get by mixing blue and yellow?', AppLanguage.hi: 'नीले और पीले रंग को मिलाने से कौन सा रंग बनता है?'},
    {AppLanguage.en: ['Red', 'Green', 'Purple', 'Orange'], AppLanguage.hi: ['लाल', 'हरा', 'बैंगनी', 'नारंगी']},
    {AppLanguage.en: 'Green', AppLanguage.hi: 'हरा'},
  ),
  QuizQuestion(
    {AppLanguage.en: 'Which animal says "moo"?', AppLanguage.hi: 'कौन सा जानवर "मूँ" बोलता है?'},
    {AppLanguage.en: ['Cat', 'Cow', 'Dog', 'Duck'], AppLanguage.hi: ['बिल्ली', 'गाय', 'कुत्ता', 'बत्तख']},
    {AppLanguage.en: 'Cow', AppLanguage.hi: 'गाय'},
  ),
  QuizQuestion(
    {AppLanguage.en: 'How many days are in a week?', AppLanguage.hi: 'एक हफ्ते में कितने दिन होते हैं?'},
    {AppLanguage.en: ['5', '6', '7', '8'], AppLanguage.hi: ['5', '6', '7', '8']},
    {AppLanguage.en: '7', AppLanguage.hi: '7'},
  ),
  QuizQuestion(
    {AppLanguage.en: 'What do bees make?', AppLanguage.hi: 'मधुमक्खियाँ क्या बनाती हैं?'},
    {AppLanguage.en: ['Milk', 'Honey', 'Juice', 'Butter'], AppLanguage.hi: ['दूध', 'शहद', 'जूस', 'मक्खन']},
    {AppLanguage.en: 'Honey', AppLanguage.hi: 'शहद'},
  ),
  QuizQuestion(
    {AppLanguage.en: 'Which shape has three sides?', AppLanguage.hi: 'किस आकृति की तीन भुजाएँ होती हैं?'},
    {AppLanguage.en: ['Circle', 'Square', 'Triangle', 'Star'], AppLanguage.hi: ['वृत्त', 'वर्ग', 'त्रिकोण', 'तारा']},
    {AppLanguage.en: 'Triangle', AppLanguage.hi: 'त्रिकोण'},
  ),
  QuizQuestion(
    {AppLanguage.en: 'What do we use to see in the dark?', AppLanguage.hi: 'अंधेरे में देखने के लिए हम क्या उपयोग करते हैं?'},
    {AppLanguage.en: ['Torch', 'Spoon', 'Book', 'Shoe'], AppLanguage.hi: ['टॉर्च', 'चम्मच', 'किताब', 'जूता']},
    {AppLanguage.en: 'Torch', AppLanguage.hi: 'टॉर्च'},
  ),
];

/// A short bilingual story broken into pages, ending in a comprehension
/// question for the parent to ask the child (Story Time co-play feature).
class Story {
  final String id;
  final Map<AppLanguage, String> title;
  final Map<AppLanguage, List<String>> pages;
  final Map<AppLanguage, String> question;
  final Map<AppLanguage, List<String>> options;
  final Map<AppLanguage, String> answer;
  const Story(this.id, this.title, this.pages, this.question, this.options, this.answer);
}

final List<Story> storyData = [
  Story(
    'rabbit_garden',
    {AppLanguage.en: 'The Rabbit and the Garden', AppLanguage.hi: 'खरगोश और बगीचा'},
    {
      AppLanguage.en: [
        'Once there was a little rabbit who loved carrots.',
        'One day she found a garden full of carrots!',
        'She shared the carrots with all her friends.',
      ],
      AppLanguage.hi: [
        'एक बार एक छोटा खरगोश था जिसे गाजर बहुत पसंद थी।',
        'एक दिन उसे गाजर से भरा एक बगीचा मिला!',
        'उसने सारी गाजर अपने दोस्तों के साथ बाँट दी।',
      ],
    },
    {AppLanguage.en: 'What did the rabbit find in the garden?', AppLanguage.hi: 'खरगोश को बगीचे में क्या मिला?'},
    {AppLanguage.en: ['Apples', 'Carrots', 'Flowers', 'Shoes'], AppLanguage.hi: ['सेब', 'गाजर', 'फूल', 'जूते']},
    {AppLanguage.en: 'Carrots', AppLanguage.hi: 'गाजर'},
  ),
  Story(
    'cloud_rain',
    {AppLanguage.en: 'The Cloud Who Wanted to Rain', AppLanguage.hi: 'बादल जो बारिश करना चाहता था'},
    {
      AppLanguage.en: [
        'A little cloud floated over a dry farm.',
        'The farmer looked up and smiled at the cloud.',
        'The cloud rained gently, and the plants grew tall.',
      ],
      AppLanguage.hi: [
        'एक छोटा बादल एक सूखे खेत के ऊपर तैर रहा था।',
        'किसान ने ऊपर देखा और बादल को देखकर मुस्कुराया।',
        'बादल ने धीरे-धीरे बारिश की, और पौधे बड़े हो गए।',
      ],
    },
    {AppLanguage.en: 'What happened after the cloud rained?', AppLanguage.hi: 'बादल की बारिश के बाद क्या हुआ?'},
    {AppLanguage.en: ['Plants grew tall', 'The sun disappeared', 'The farmer left', 'Nothing changed'], AppLanguage.hi: ['पौधे बड़े हो गए', 'सूरज गायब हो गया', 'किसान चला गया', 'कुछ नहीं बदला']},
    {AppLanguage.en: 'Plants grew tall', AppLanguage.hi: 'पौधे बड़े हो गए'},
  ),
];
