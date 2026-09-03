/// Supported app languages. English is the default / global language;
/// Hindi is bundled now. To add another language later (e.g. Gujarati),
/// add a new enum value here and a matching map entry in [AppStrings.all].
enum AppLanguage { en, hi }

class AppStrings {
  final String appName;
  final String tagline;

  final String home;
  final String zoneLearning;
  final String zoneLearningSub;
  final String zonePlay;
  final String zonePlaySub;
  final String zoneCreative;
  final String zoneCreativeSub;
  final String zoneCoplay;
  final String zoneCoplaySub;
  final String viewRewards;
  final String back;
  final String stars;

  final String learningAlphabetTab;
  final String learningNumbersTab;
  final String tapALetter;
  final String countWithMe;

  final String playChooseLevel;
  final String levelEasy;
  final String levelMedium;
  final String levelHard;
  final String moves;
  final String matched;
  final String playAgain;

  final String coloringTitle;
  final String clear;
  final String nextPicture;
  final String previousPicture;

  final String coplayHubTitle;
  final String coplayTeamChallenge;
  final String coplayTeamChallengeSub;
  final String coplayStoryTime;
  final String coplayStoryTimeSub;
  final String coplayVoiceNotes;
  final String coplayVoiceNotesSub;
  final String coplayFamilyBadges;
  final String coplayFamilyBadgesSub;

  final String teamChallengeInstructions;
  final String correctAnswer;
  final String wrongAnswer;
  final String nextQuestion;
  final String questionOf;

  final String storyListTitle;
  final String readAloud;
  final String storyQuestionPrompt;
  final String finishStory;

  final String voiceRecordingTitle;
  final String voiceRecordingHint;
  final String recordButton;
  final String stopButton;
  final String playButton;
  final String noRecordingsYet;
  final String recordingSaved;

  final String rewardsTitle;
  final String rewardsStarsEarned;
  final String badgeAlphabet;
  final String badgeNumbers;
  final String badgeMemory;
  final String badgeArtist;
  final String badgeStoryteller;
  final String badgeFamily;

  const AppStrings({
    required this.appName,
    required this.tagline,
    required this.home,
    required this.zoneLearning,
    required this.zoneLearningSub,
    required this.zonePlay,
    required this.zonePlaySub,
    required this.zoneCreative,
    required this.zoneCreativeSub,
    required this.zoneCoplay,
    required this.zoneCoplaySub,
    required this.viewRewards,
    required this.back,
    required this.stars,
    required this.learningAlphabetTab,
    required this.learningNumbersTab,
    required this.tapALetter,
    required this.countWithMe,
    required this.playChooseLevel,
    required this.levelEasy,
    required this.levelMedium,
    required this.levelHard,
    required this.moves,
    required this.matched,
    required this.playAgain,
    required this.coloringTitle,
    required this.clear,
    required this.nextPicture,
    required this.previousPicture,
    required this.coplayHubTitle,
    required this.coplayTeamChallenge,
    required this.coplayTeamChallengeSub,
    required this.coplayStoryTime,
    required this.coplayStoryTimeSub,
    required this.coplayVoiceNotes,
    required this.coplayVoiceNotesSub,
    required this.coplayFamilyBadges,
    required this.coplayFamilyBadgesSub,
    required this.teamChallengeInstructions,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.nextQuestion,
    required this.questionOf,
    required this.storyListTitle,
    required this.readAloud,
    required this.storyQuestionPrompt,
    required this.finishStory,
    required this.voiceRecordingTitle,
    required this.voiceRecordingHint,
    required this.recordButton,
    required this.stopButton,
    required this.playButton,
    required this.noRecordingsYet,
    required this.recordingSaved,
    required this.rewardsTitle,
    required this.rewardsStarsEarned,
    required this.badgeAlphabet,
    required this.badgeNumbers,
    required this.badgeMemory,
    required this.badgeArtist,
    required this.badgeStoryteller,
    required this.badgeFamily,
  });

  static const Map<AppLanguage, AppStrings> all = {
    AppLanguage.en: AppStrings(
      appName: 'Little Learners',
      tagline: 'Fun and learning, together',
      home: 'Home',
      zoneLearning: 'Learning zone',
      zoneLearningSub: 'ABCs & numbers',
      zonePlay: 'Play zone',
      zonePlaySub: 'Mini-games',
      zoneCreative: 'Creative zone',
      zoneCreativeSub: 'Draw & color',
      zoneCoplay: 'Co-play mode',
      zoneCoplaySub: 'Parent & child',
      viewRewards: 'View rewards',
      back: 'Back',
      stars: 'Stars',
      learningAlphabetTab: 'Alphabet',
      learningNumbersTab: 'Numbers',
      tapALetter: 'Tap a letter to hear it',
      countWithMe: 'Count with me',
      playChooseLevel: 'Choose a level',
      levelEasy: 'Easy',
      levelMedium: 'Medium',
      levelHard: 'Hard',
      moves: 'Moves',
      matched: 'All matched!',
      playAgain: 'Play again',
      coloringTitle: 'Color the picture',
      clear: 'Clear',
      nextPicture: 'Next picture',
      previousPicture: 'Previous picture',
      coplayHubTitle: 'Co-play mode',
      coplayTeamChallenge: 'Team challenge',
      coplayTeamChallengeSub: 'Answer race',
      coplayStoryTime: 'Story time',
      coplayStoryTimeSub: 'Read together',
      coplayVoiceNotes: 'Voice notes',
      coplayVoiceNotesSub: "Parent's voice",
      coplayFamilyBadges: 'Family badges',
      coplayFamilyBadgesSub: 'Unlock together',
      teamChallengeInstructions:
          'One of you reads the question out loud. The other taps the answer!',
      correctAnswer: "Great job! That's right.",
      wrongAnswer: 'Not quite — try again!',
      nextQuestion: 'Next question',
      questionOf: 'Question',
      storyListTitle: 'Pick a story',
      readAloud: 'Read aloud',
      storyQuestionPrompt: 'What happened in the story?',
      finishStory: 'Finish story',
      voiceRecordingTitle: 'Record your voice',
      voiceRecordingHint:
          'Parents can record rhymes or counting in their own voice for their child to hear.',
      recordButton: 'Record',
      stopButton: 'Stop',
      playButton: 'Play',
      noRecordingsYet: 'No recordings yet',
      recordingSaved: 'Recording saved',
      rewardsTitle: 'Your rewards',
      rewardsStarsEarned: 'stars earned',
      badgeAlphabet: 'Alphabet star',
      badgeNumbers: 'Number whiz',
      badgeMemory: 'Memory master',
      badgeArtist: 'Little artist',
      badgeStoryteller: 'Storyteller',
      badgeFamily: 'Family badge',
    ),
    AppLanguage.hi: AppStrings(
      appName: 'लिटिल लर्नर्स',
      tagline: 'मज़ा और सीख, साथ में',
      home: 'होम',
      zoneLearning: 'लर्निंग ज़ोन',
      zoneLearningSub: 'वर्णमाला और संख्याएँ',
      zonePlay: 'प्ले ज़ोन',
      zonePlaySub: 'मिनी गेम्स',
      zoneCreative: 'क्रिएटिव ज़ोन',
      zoneCreativeSub: 'रंग भरें और बनाएं',
      zoneCoplay: 'साथ खेलो मोड',
      zoneCoplaySub: 'माता-पिता और बच्चा',
      viewRewards: 'रिवॉर्ड्स देखें',
      back: 'वापस',
      stars: 'सितारे',
      learningAlphabetTab: 'वर्णमाला',
      learningNumbersTab: 'संख्याएँ',
      tapALetter: 'सुनने के लिए अक्षर पर टैप करें',
      countWithMe: 'मेरे साथ गिनो',
      playChooseLevel: 'स्तर चुनें',
      levelEasy: 'आसान',
      levelMedium: 'मध्यम',
      levelHard: 'कठिन',
      moves: 'चालें',
      matched: 'सब मिल गया!',
      playAgain: 'फिर से खेलें',
      coloringTitle: 'तस्वीर में रंग भरें',
      clear: 'साफ़ करें',
      nextPicture: 'अगली तस्वीर',
      previousPicture: 'पिछली तस्वीर',
      coplayHubTitle: 'साथ खेलो मोड',
      coplayTeamChallenge: 'जवाब की दौड़',
      coplayTeamChallengeSub: 'टीम चैलेंज',
      coplayStoryTime: 'कहानी का समय',
      coplayStoryTimeSub: 'साथ में पढ़ें',
      coplayVoiceNotes: 'वॉइस नोट्स',
      coplayVoiceNotesSub: 'माता-पिता की आवाज़',
      coplayFamilyBadges: 'फैमिली बैज',
      coplayFamilyBadgesSub: 'साथ में अनलॉक करें',
      teamChallengeInstructions:
          'एक व्यक्ति सवाल ज़ोर से पढ़े। दूसरा जवाब पर टैप करे!',
      correctAnswer: 'शाबाश! यह सही है।',
      wrongAnswer: 'थोड़ा गलत — फिर से कोशिश करो!',
      nextQuestion: 'अगला सवाल',
      questionOf: 'सवाल',
      storyListTitle: 'एक कहानी चुनें',
      readAloud: 'ज़ोर से पढ़ें',
      storyQuestionPrompt: 'कहानी में क्या हुआ?',
      finishStory: 'कहानी समाप्त करें',
      voiceRecordingTitle: 'अपनी आवाज़ रिकॉर्ड करें',
      voiceRecordingHint:
          'माता-पिता अपनी आवाज़ में कविताएँ या गिनती रिकॉर्ड कर सकते हैं जिसे बच्चा सुन सके।',
      recordButton: 'रिकॉर्ड करें',
      stopButton: 'रोकें',
      playButton: 'चलाएं',
      noRecordingsYet: 'अभी तक कोई रिकॉर्डिंग नहीं',
      recordingSaved: 'रिकॉर्डिंग सेव हो गई',
      rewardsTitle: 'आपके रिवॉर्ड्स',
      rewardsStarsEarned: 'सितारे मिले',
      badgeAlphabet: 'वर्णमाला स्टार',
      badgeNumbers: 'नंबर व्हिज़',
      badgeMemory: 'मेमोरी मास्टर',
      badgeArtist: 'नन्हा कलाकार',
      badgeStoryteller: 'कहानीकार',
      badgeFamily: 'फैमिली बैज',
    ),
  };
}
