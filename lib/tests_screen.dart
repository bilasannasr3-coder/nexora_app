import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// NEXORA assessments: 90 questions in one file.
/// Replace the existing tests_screen.dart contents with this file.
/// Correct answers for the skills assessment are stored internally and are
/// never rendered in the student-facing interface.

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final tests = _testInfos(isArabic);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF10121C) : const Color(0xFFF7F8FC),
        appBar: AppBar(
          title: Text(isArabic ? 'الاختبارات' : 'Assessments',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              isArabic ? 'اكتشف نقاط قوتك' : 'Discover your strengths',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF20243A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isArabic
                  ? 'أكمل الاختبارات الثلاثة للحصول على صورة أشمل عن اهتماماتك وطريقتك في التفكير.'
                  : 'Complete all three assessments to build a broader picture of your interests and thinking.',
              style: TextStyle(
                height: 1.5,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            for (final test in tests) ...[
              _TestCard(
                test: test,
                isArabic: isArabic,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TestIntroScreen(test: test, isArabic: isArabic),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class _TestInfo {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final IconData icon;
  final Color color;
  final int questionCount;

  const _TestInfo({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.icon,
    required this.color,
    required this.questionCount,
  });

  String title(bool ar) => ar ? titleAr : titleEn;
  String description(bool ar) => ar ? descriptionAr : descriptionEn;
}

List<_TestInfo> _testInfos(bool isArabic) => const [
  _TestInfo(
    id: 'interests',
    titleAr: 'الميول والاهتمامات',
    titleEn: 'Interests',
    descriptionAr: 'تعرّف إلى الأنشطة والمجالات التي تميل إلى الاستمتاع بها.',
    descriptionEn: 'Explore activities and fields you may enjoy.',
    icon: Icons.explore_outlined,
    color: Color(0xFF4A6CF7),
    questionCount: 30,
  ),
  _TestInfo(
    id: 'personality',
    titleAr: 'اختبار الشخصية',
    titleEn: 'Personality',
    descriptionAr: 'تأمل في أسلوبك في التعامل والعمل والتفكير.',
    descriptionEn: 'Reflect on how you interact, work, and think.',
    icon: Icons.psychology_alt_outlined,
    color: Color(0xFF7C4DFF),
    questionCount: 30,
  ),
  _TestInfo(
    id: 'skills',
    titleAr: 'المهارات والقدرات',
    titleEn: 'Skills and Abilities',
    descriptionAr: 'تعامل مع مواقف وأسئلة قصيرة تقيس أنماطًا مختلفة من التفكير.',
    descriptionEn: 'Try short problems covering different ways of thinking.',
    icon: Icons.lightbulb_outline,
    color: Color(0xFFE58A26),
    questionCount: 30,
  ),
];

class _TestCard extends StatelessWidget {
  final _TestInfo test;
  final bool isArabic;
  final VoidCallback onTap;

  const _TestCard({
    required this.test,
    required this.isArabic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDark ? const Color(0xFF1B1E2B) : Colors.white,
      elevation: isDark ? 0 : 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: test.color.withOpacity(.13),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(test.icon, color: test.color, size: 29),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(test.title(isArabic),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 5),
                    Text(test.description(isArabic),
                        style: TextStyle(
                          height: 1.35,
                          color: isDark ? Colors.white70 : Colors.black54,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      isArabic ? '30 سؤالًا' : '30 questions',
                      style: TextStyle(color: test.color, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(isArabic ? Icons.chevron_left : Icons.chevron_right,
                  color: isDark ? Colors.white54 : Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}

class TestIntroScreen extends StatelessWidget {
  final _TestInfo test;
  final bool isArabic;

  const TestIntroScreen({super.key, required this.test, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black54;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF10121C) : const Color(0xFFF7F8FC),
        appBar: AppBar(
          title: Text(test.title(isArabic)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  children: [
                    Container(
                      height: 88,
                      decoration: BoxDecoration(
                        color: test.color.withOpacity(.12),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(test.icon, color: test.color, size: 48),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      test.title(isArabic),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      test.id == 'skills'
                          ? (isArabic
                          ? 'يتكوّن الاختبار من 30 سؤالًا من اختيار متعدد موزعة على خمسة مجالات: التفكير المنطقي، وحل المشكلات، والاستدلال الكمي، والتفكير العلمي، والتفكير الإبداعي.'
                          : 'This 30-question multiple-choice assessment covers logical reasoning, problem solving, quantitative reasoning, scientific reasoning, and creative thinking.')
                          : test.id == 'personality'
                          ? (isArabic
                          ? 'يتكوّن الاختبار من 30 عبارة. اختر درجة موافقتك على كل عبارة. لا توجد إجابات صحيحة أو خاطئة، والإجابات تعبّر عن تقييمك لنفسك.'
                          : 'This assessment contains 30 statements. Rate how much you agree with each one. There are no right or wrong answers; respond based on your own self-assessment.')
                          : (isArabic
                          ? 'يتكوّن الاختبار من 30 عبارة حول أنشطة ومجالات متنوعة. اختر درجة اهتمامك بكل نشاط، وأجب وفق ما يناسبك فعلًا.'
                          : 'This assessment contains 30 statements about different activities and fields. Rate your interest in each activity honestly.'),
                      style: TextStyle(height: 1.55, color: textColor),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1B1E2B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? Colors.white10 : Colors.black.withOpacity(.05),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: test.color, size: 22),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              isArabic
                                  ? 'تعليمات: اقرأ كل سؤال بعناية، ثم اختر إجابة واحدة. أجب بنفسك وبهدوء، ولا تستخدم مصادر خارجية في اختبار القدرات.'
                                  : 'Instructions: Read each question carefully and select one answer. Respond independently. Do not use external sources for the skills assessment.',
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: test.color,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => AssessmentQuestionScreen(
                          test: test,
                          isArabic: isArabic,
                        ),
                      ),
                    ),
                    child: Text(
                      isArabic ? 'ابدأ الاختبار' : 'Start assessment',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Question {
  final String ar;
  final String en;
  final List<String> optionsAr;
  final List<String> optionsEn;
  final int? correctIndex;
  final String categoryAr;
  final String categoryEn;

  const _Question({
    required this.ar,
    required this.en,
    this.optionsAr = const [],
    this.optionsEn = const [],
    this.correctIndex,
    this.categoryAr = '',
    this.categoryEn = '',
  });
}

const List<String> _likertAr = [
  'لا أوافق بشدة',
  'لا أوافق',
  'محايد',
  'أوافق',
  'أوافق بشدة',
];
const List<String> _likertEn = [
  'Strongly disagree',
  'Disagree',
  'Neutral',
  'Agree',
  'Strongly agree',
];

List<_Question> _interestQuestions() => const [
  _Question(ar:'أستمتع باستخدام الأدوات أو تركيب الأشياء وإصلاحها.', en:'I enjoy using tools, assembling things, or repairing them.', categoryAr:'واقعي', categoryEn:'Realistic'),
  _Question(ar:'أفضّل الأنشطة العملية التي تتضمن العمل باليدين.', en:'I prefer practical activities that involve working with my hands.', categoryAr:'واقعي', categoryEn:'Realistic'),
  _Question(ar:'أحب العمل في الهواء الطلق أو العناية بالنباتات.', en:'I enjoy working outdoors or caring for plants.', categoryAr:'واقعي', categoryEn:'Realistic'),
  _Question(ar:'أستمتع بتشغيل الأجهزة أو معرفة طريقة عملها.', en:'I enjoy operating devices or learning how they work.', categoryAr:'واقعي', categoryEn:'Realistic'),
  _Question(ar:'أفضّل تنفيذ شيء ملموس بدلًا من الاكتفاء بالحديث عنه.', en:'I prefer making something tangible rather than only talking about it.', categoryAr:'واقعي', categoryEn:'Realistic'),
  _Question(ar:'أستمتع بحل الألغاز والأسئلة التي تحتاج إلى تحليل.', en:'I enjoy solving puzzles and questions that require analysis.', categoryAr:'بحثي', categoryEn:'Investigative'),
  _Question(ar:'أحب معرفة أسباب حدوث الظواهر من حولي.', en:'I like finding out why things around me happen.', categoryAr:'بحثي', categoryEn:'Investigative'),
  _Question(ar:'أستمتع بإجراء التجارب وملاحظة نتائجها.', en:'I enjoy conducting experiments and observing their results.', categoryAr:'بحثي', categoryEn:'Investigative'),
  _Question(ar:'أحب جمع المعلومات ومقارنتها قبل الوصول إلى استنتاج.', en:'I like gathering and comparing information before reaching a conclusion.', categoryAr:'بحثي', categoryEn:'Investigative'),
  _Question(ar:'أستمتع بالمسائل التي تتطلب التفكير المنطقي والبحث عن الأدلة.', en:'I enjoy problems that require logical thinking and evidence.', categoryAr:'بحثي', categoryEn:'Investigative'),
  _Question(ar:'أحب الرسم أو التصميم أو ابتكار أشكال بصرية.', en:'I enjoy drawing, designing, or creating visual forms.', categoryAr:'فني', categoryEn:'Artistic'),
  _Question(ar:'أستمتع بكتابة القصص أو التعبير عن الأفكار بالكلمات.', en:'I enjoy writing stories or expressing ideas with words.', categoryAr:'فني', categoryEn:'Artistic'),
  _Question(ar:'أحب ابتكار أفكار جديدة وغير مألوفة.', en:'I enjoy coming up with new and unusual ideas.', categoryAr:'فني', categoryEn:'Artistic'),
  _Question(ar:'أستمتع بالموسيقى أو التمثيل أو أشكال التعبير الفني.', en:'I enjoy music, acting, or other forms of artistic expression.', categoryAr:'فني', categoryEn:'Artistic'),
  _Question(ar:'أفضل وجود مساحة لاستخدام خيالي وطريقتي الخاصة في إنجاز العمل.', en:'I prefer having room to use my imagination and my own approach.', categoryAr:'فني', categoryEn:'Artistic'),
  _Question(ar:'أستمتع بشرح المعلومات للآخرين ومساعدتهم على الفهم.', en:'I enjoy explaining information and helping others understand.', categoryAr:'اجتماعي', categoryEn:'Social'),
  _Question(ar:'أحب التعاون مع الآخرين لإنجاز هدف مشترك.', en:'I enjoy cooperating with others to reach a shared goal.', categoryAr:'اجتماعي', categoryEn:'Social'),
  _Question(ar:'أشعر بالرضا عندما أساعد شخصًا يواجه صعوبة.', en:'I feel satisfied when I help someone who is struggling.', categoryAr:'اجتماعي', categoryEn:'Social'),
  _Question(ar:'أستمتع بالاستماع إلى مشكلات الآخرين ومحاولة دعمهم.', en:'I enjoy listening to others’ problems and trying to support them.', categoryAr:'اجتماعي', categoryEn:'Social'),
  _Question(ar:'أفضل الأنشطة التي تتضمن التواصل والعمل مع الناس.', en:'I prefer activities that involve communicating and working with people.', categoryAr:'اجتماعي', categoryEn:'Social'),
  _Question(ar:'أستمتع بقيادة فريق وتنظيم الجهود لتحقيق هدف.', en:'I enjoy leading a team and coordinating efforts toward a goal.', categoryAr:'ريادي', categoryEn:'Enterprising'),
  _Question(ar:'أحب عرض أفكاري ومحاولة إقناع الآخرين بها باحترام.', en:'I enjoy presenting my ideas and respectfully persuading others.', categoryAr:'ريادي', categoryEn:'Enterprising'),
  _Question(ar:'أستمتع بالمبادرة إلى تنظيم نشاط أو مشروع.', en:'I enjoy taking initiative to organize an activity or project.', categoryAr:'ريادي', categoryEn:'Enterprising'),
  _Question(ar:'أحب اتخاذ القرارات عندما تكون لدي معلومات كافية.', en:'I like making decisions when I have enough information.', categoryAr:'ريادي', categoryEn:'Enterprising'),
  _Question(ar:'أستمتع بالتفاوض وتقسيم الأدوار للوصول إلى نتيجة مشتركة.', en:'I enjoy negotiating and assigning roles to reach a shared outcome.', categoryAr:'ريادي', categoryEn:'Enterprising'),
  _Question(ar:'أحب ترتيب المعلومات والاحتفاظ بالسجلات بصورة منظمة.', en:'I like arranging information and keeping records organized.', categoryAr:'تنظيمي', categoryEn:'Conventional'),
  _Question(ar:'أستمتع باتباع خطوات واضحة لإنجاز مهمة.', en:'I enjoy following clear steps to complete a task.', categoryAr:'تنظيمي', categoryEn:'Conventional'),
  _Question(ar:'أفضّل أن تكون الملفات والأدوات مرتبة وسهلة الوصول.', en:'I prefer files and tools to be organized and easy to find.', categoryAr:'تنظيمي', categoryEn:'Conventional'),
  _Question(ar:'أنتبه إلى التفاصيل عند إدخال البيانات أو مراجعة الأرقام.', en:'I pay attention to details when entering data or checking numbers.', categoryAr:'تنظيمي', categoryEn:'Conventional'),
  _Question(ar:'أستمتع بالتخطيط المسبق ووضع قائمة بالمهام المطلوبة.', en:'I enjoy planning ahead and making a list of required tasks.', categoryAr:'تنظيمي', categoryEn:'Conventional'),
];

List<_Question> _personalityQuestions() => const [
  _Question(ar:'أستمتع بقضاء جزء من وقتي في التحدث والتفاعل مع الآخرين.', en:'I enjoy spending some of my time talking and interacting with others.', categoryAr:'الانبساط', categoryEn:'Extraversion'),
  _Question(ar:'غالبًا ما أكون أنا من يبدأ الحديث أو يطرح موضوعًا عند الجلوس مع مجموعة من أصدقائي.', en:'I am often the one who starts a conversation or brings up a topic among friends.', categoryAr:'الانبساط', categoryEn:'Extraversion'),
  _Question(ar:'أشارك بأفكاري خلال النقاشات الجماعية.', en:'I share my ideas during group discussions.', categoryAr:'الانبساط', categoryEn:'Extraversion'),
  _Question(ar:'أشعر بالحيوية عندما أشارك في أنشطة اجتماعية مع الآخرين.', en:'I feel energized when taking part in social activities with others.', categoryAr:'الانبساط', categoryEn:'Extraversion'),
  _Question(ar:'أحب الانضمام إلى الأنشطة الجماعية عندما تتاح لي الفرصة.', en:'I like joining group activities when I have the opportunity.', categoryAr:'الانبساط', categoryEn:'Extraversion'),
  _Question(ar:'أشعر بالفضول للتعرّف على أشخاص جدد والتحدث معهم.', en:'I am curious about meeting new people and talking with them.', categoryAr:'الانبساط', categoryEn:'Extraversion'),
  _Question(ar:'أحاول فهم مشاعر الآخرين عندما يمرّون بموقف صعب.', en:'I try to understand others’ feelings when they face a difficult situation.', categoryAr:'التوافق', categoryEn:'Agreeableness'),
  _Question(ar:'أتعامل باحترام مع زملائي حتى عندما تكون آراؤهم مختلفة عن رأيي.', en:'I treat classmates respectfully even when their opinions differ from mine.', categoryAr:'التوافق', categoryEn:'Agreeableness'),
  _Question(ar:'أنتبه إلى الطريقة التي أعبّر بها عن رأيي حتى أحافظ على الاحترام في حديثي مع الآخرين.', en:'I pay attention to how I express my opinions to remain respectful.', categoryAr:'التوافق', categoryEn:'Agreeableness'),
  _Question(ar:'أستمع إلى وجهة نظر الشخص الآخر حتى عندما لا أتفق معه.', en:'I listen to another person’s point of view even when I disagree.', categoryAr:'التوافق', categoryEn:'Agreeableness'),
  _Question(ar:'أعرض المساعدة على الآخرين عندما ألاحظ أنهم يحتاجون إليها.', en:'I offer help when I notice that others need it.', categoryAr:'التوافق', categoryEn:'Agreeableness'),
  _Question(ar:'أحاول الوصول إلى حل يراعي احتياجات الآخرين عند حدوث خلاف.', en:'When there is a disagreement, I try to find a solution that considers others’ needs.', categoryAr:'التوافق', categoryEn:'Agreeableness'),
  _Question(ar:'أرتّب واجباتي وأحاول إنجازها في المواعيد المحددة.', en:'I organize my assignments and try to finish them on time.', categoryAr:'يقظة الضمير', categoryEn:'Conscientiousness'),
  _Question(ar:'أراجع عملي للتأكد من أنني لم أنسَ تفاصيل مهمة.', en:'I review my work to make sure I have not missed important details.', categoryAr:'يقظة الضمير', categoryEn:'Conscientiousness'),
  _Question(ar:'أحرص على إكمال المهام التي أبدأ بها حتى لو احتاجت إلى وقت وجهد.', en:'I make sure to finish tasks I start, even if they take time and effort.', categoryAr:'يقظة الضمير', categoryEn:'Conscientiousness'),
  _Question(ar:'أحدد ما يجب أن أنجزه أولًا عندما يكون لدي أكثر من مهمة.', en:'I decide what to do first when I have more than one task.', categoryAr:'يقظة الضمير', categoryEn:'Conscientiousness'),
  _Question(ar:'أتحمل مسؤولية الأخطاء التي أرتكبها وأحاول تصحيحها.', en:'I take responsibility for my mistakes and try to correct them.', categoryAr:'يقظة الضمير', categoryEn:'Conscientiousness'),
  _Question(ar:'ألتزم بالاتفاقات التي أقبل بها، حتى عندما يتطلب تنفيذها جهدًا إضافيًا.', en:'I keep the commitments I accept, even when they require extra effort.', categoryAr:'يقظة الضمير', categoryEn:'Conscientiousness'),
  _Question(ar:'عندما يحدث أمر يزعجني، أستطيع غالبًا العودة إلى هدوئي بعد مرور بعض الوقت.', en:'When something upsets me, I can usually regain my calm after some time.', categoryAr:'الاستقرار الانفعالي', categoryEn:'Emotional stability'),
  _Question(ar:'عندما تتراكم عليّ المهام، أستطيع التعامل معها خطوة بخطوة.', en:'When tasks pile up, I can handle them step by step.', categoryAr:'الاستقرار الانفعالي', categoryEn:'Emotional stability'),
  _Question(ar:'إذا لم تسر الأمور كما خططت لها، أستطيع التفكير في الخطوة التالية بدلًا من الاستسلام للانزعاج.', en:'If things do not go as planned, I can think about the next step instead of staying upset.', categoryAr:'الاستقرار الانفعالي', categoryEn:'Emotional stability'),
  _Question(ar:'عندما يحدث شيء غير متوقع، أستطيع غالبًا المحافظة على هدوئي أثناء التعامل معه.', en:'When something unexpected happens, I can usually stay calm while dealing with it.', categoryAr:'الاستقرار الانفعالي', categoryEn:'Emotional stability'),
  _Question(ar:'حتى عندما أواجه صعوبة، أستطيع غالبًا مواصلة ما أقوم به دون أن يسيطر عليّ التوتر.', en:'Even when facing difficulty, I can usually continue without being overwhelmed by stress.', categoryAr:'الاستقرار الانفعالي', categoryEn:'Emotional stability'),
  _Question(ar:'إذا ارتكبت خطأ أمام الآخرين، أستطيع تجاوز الموقف ومتابعة يومي.', en:'If I make a mistake in front of others, I can move on and continue my day.', categoryAr:'الاستقرار الانفعالي', categoryEn:'Emotional stability'),
  _Question(ar:'أحب تجربة أفكار أو أنشطة جديدة لم أجرّبها من قبل.', en:'I like trying new ideas or activities that I have not tried before.', categoryAr:'الانفتاح على الخبرة', categoryEn:'Openness'),
  _Question(ar:'أستمتع بالتفكير في طرق مختلفة لحل مشكلة واحدة.', en:'I enjoy thinking of different ways to solve the same problem.', categoryAr:'الانفتاح على الخبرة', categoryEn:'Openness'),
  _Question(ar:'يثير فضولي التعرّف على أفكار جديدة لم أفكر فيها من قبل.', en:'I am curious about learning ideas I have never considered before.', categoryAr:'الانفتاح على الخبرة', categoryEn:'Openness'),
  _Question(ar:'أستعد للاستماع إلى أفكار مختلفة عن أفكاري والنظر فيها بجدية.', en:'I am willing to listen to different ideas and consider them seriously.', categoryAr:'الانفتاح على الخبرة', categoryEn:'Openness'),
  _Question(ar:'أستمتع بمعرفة معلومات عن موضوعات جديدة خارج ما أتعلمه في المدرسة.', en:'I enjoy learning about new topics beyond what I study at school.', categoryAr:'الانفتاح على الخبرة', categoryEn:'Openness'),
  _Question(ar:'أهتم بالتعرّف على تفسيرات مختلفة للموضوع نفسه، حتى لو كانت جديدة بالنسبة إلي.', en:'I like exploring different explanations of the same topic, even when they are new to me.', categoryAr:'الانفتاح على الخبرة', categoryEn:'Openness'),
];

List<_Question> _skillsQuestions() => const [
  _Question(ar:'لاحظ النمط التالي: 3، 6، 12، 24، ... ما العدد التالي؟', en:'Observe the pattern: 3, 6, 12, 24, ... What comes next?', optionsAr:['30','36','48','54'], optionsEn:['30','36','48','54'], correctIndex:2, categoryAr:'التفكير المنطقي', categoryEn:'Logical reasoning'),
  _Question(ar:'جميع أعضاء نادي العلوم يشاركون في نشاط أسبوعي. سارة عضوة في نادي العلوم. أي عبارة نستطيع استنتاجها بالتأكيد؟', en:'All science club members take part in a weekly activity. Sara is a member. What can we conclude for certain?', optionsAr:['سارة تحب الرياضيات.','سارة تشارك في نشاط أسبوعي.','سارة هي قائدة النادي.','سارة تحصل على أعلى العلامات.'], optionsEn:['Sara likes mathematics.','Sara takes part in a weekly activity.','Sara is the club leader.','Sara gets the highest grades.'], correctIndex:1, categoryAr:'التفكير المنطقي', categoryEn:'Logical reasoning'),
  _Question(ar:'إذا كان ترتيب الكتب هو: الأحمر قبل الأزرق، والأزرق قبل الأخضر، فأي كتاب يأتي أولًا؟', en:'Books are ordered with red before blue, and blue before green. Which book comes first?', optionsAr:['الأخضر','الأزرق','الأحمر','لا يمكن تحديد ذلك'], optionsEn:['Green','Blue','Red','Cannot be determined'], correctIndex:2, categoryAr:'التفكير المنطقي', categoryEn:'Logical reasoning'),
  _Question(ar:'أكمل النمط: 2، 5، 9، 14، 20، ...', en:'Complete the pattern: 2, 5, 9, 14, 20, ...', optionsAr:['25','26','27','28'], optionsEn:['25','26','27','28'], correctIndex:2, categoryAr:'التفكير المنطقي', categoryEn:'Logical reasoning'),
  _Question(ar:'كل المربعات في مجموعة معينة أشكال رباعية. أحد الأشكال في المجموعة مربع. ما الذي يمكن الجزم به؟', en:'Every square in a certain set is a quadrilateral. One shape in the set is a square. What can be concluded?', optionsAr:['له ثلاثة أضلاع.','له أربعة أضلاع.','جميع أضلاعه مختلفة الطول.','هو دائرة.'], optionsEn:['It has three sides.','It has four sides.','All its sides have different lengths.','It is a circle.'], correctIndex:1, categoryAr:'التفكير المنطقي', categoryEn:'Logical reasoning'),
  _Question(ar:'ما اليوم الذي يسبق الجمعة بيومين؟', en:'Which day is two days before Friday?', optionsAr:['الثلاثاء','الأربعاء','الخميس','السبت'], optionsEn:['Tuesday','Wednesday','Thursday','Saturday'], correctIndex:1, categoryAr:'التفكير المنطقي', categoryEn:'Logical reasoning'),
  _Question(ar:'لديك مشروع مدرسي وموعد تسليمه غدًا، لكنك اكتشفت أن جزءًا أساسيًا منه لم يكتمل. ما الخطوة الأنسب؟', en:'A school project is due tomorrow, and you discover an essential part is unfinished. What is the best next step?', optionsAr:['تجاهل الجزء الناقص وتسليم المشروع دون مراجعته.','تحديد الجزء الضروري وإنجازه أولًا، ثم مراجعة العمل المتبقي.','البدء بمشروع جديد بالكامل.','تأجيل العمل حتى بعد موعد التسليم.'], optionsEn:['Ignore the missing part and submit without reviewing.','Identify and complete the essential part first, then review the rest.','Start an entirely new project.','Delay the work until after the deadline.'], correctIndex:1, categoryAr:'حل المشكلات', categoryEn:'Problem solving'),
  _Question(ar:'لا يعمل المصباح في غرفتك. ما أفضل خطوة أولى لمعرفة السبب؟', en:'The light in your room does not work. What is the best first step to find out why?', optionsAr:['شراء مصباح جديد مباشرة.','تغيير جميع أسلاك الغرفة.','التحقق من أن المصباح موصول وأن مصدر الكهرباء يعمل بأمان.','افتراض أن المصباح تالف دون فحصه.'], optionsEn:['Buy a new bulb immediately.','Replace all the room wiring.','Safely check that the bulb is fitted and the power source works.','Assume the bulb is broken without checking.'], correctIndex:2, categoryAr:'حل المشكلات', categoryEn:'Problem solving'),
  _Question(ar:'يعمل فريق من أربعة طلاب على مشروع، لكن كل طالب بدأ بتنفيذ جزء مختلف دون الاتفاق على الخطة. ما الحل الأفضل؟', en:'Four students are working on a project, but each started a different part without agreeing on a plan. What is the best solution?', optionsAr:['ترك كل طالب يعمل بالطريقة التي يراها مناسبة.','تقسيم المشروع إلى مهام واضحة وتحديد مسؤولية كل طالب.','مطالبة طالب واحد بتنفيذ المشروع كله.','إيقاف المشروع حتى موعد التسليم.'], optionsEn:['Let everyone work however they think best.','Divide the project into clear tasks and assign responsibility to each student.','Ask one student to do the entire project.','Stop the project until the deadline.'], correctIndex:1, categoryAr:'حل المشكلات', categoryEn:'Problem solving'),
  _Question(ar:'لديك ساعة واحدة لإنجاز ثلاثة أعمال: واجب يستغرق 30 دقيقة وموعده اليوم، ومراجعة تستغرق 20 دقيقة وامتحانها غدًا، وترتيب ملفات يستغرق 15 دقيقة ولا يوجد موعد قريب له. ما الخطة الأنسب؟', en:'You have one hour: homework due today takes 30 minutes, revision for tomorrow’s exam takes 20 minutes, and organizing files takes 15 minutes with no near deadline. What is the best plan?', optionsAr:['البدء بترتيب الملفات ثم التوقف عند انتهاء الساعة.','توزيع الوقت بحسب الأولوية، مع إعطاء الواجب المستحق اليوم الأولوية.','مراجعة الملفات طوال الساعة.','تجاهل جميع الأعمال لأنها لا تكفي ساعة واحدة.'], optionsEn:['Organize files first and stop when the hour ends.','Prioritize tasks, starting with the homework due today.','Review files for the whole hour.','Ignore all tasks because they do not fit into one hour.'], correctIndex:1, categoryAr:'حل المشكلات', categoryEn:'Problem solving'),
  _Question(ar:'جرّبت طريقة لحل مسألة، لكن النتيجة كانت خاطئة. ما أفضل تصرف؟', en:'You tried solving a problem but got the wrong result. What is the best response?', optionsAr:['تكرار الطريقة نفسها دون مراجعة.','حذف الحل والانتقال إلى سؤال آخر دائمًا.','مراجعة الخطوات وتحديد موضع الخطأ ثم تجربة تعديل مناسب.','افتراض أن السؤال ليس له حل.'], optionsEn:['Repeat the same method without checking.','Always delete the solution and move to another question.','Review the steps, find the error, and try an appropriate adjustment.','Assume the question has no solution.'], correctIndex:2, categoryAr:'حل المشكلات', categoryEn:'Problem solving'),
  _Question(ar:'يريد فريق تنظيم فعالية بميزانية محدودة. اكتشف الفريق أن تكلفة الخطة الأولى أعلى من الميزانية. ما الخطوة الأنسب؟', en:'A team planning an event finds its first plan exceeds the budget. What should it do?', optionsAr:['إلغاء الفعالية فورًا دون مناقشة بدائل.','تجاوز الميزانية دون الرجوع إلى المسؤولين.','تحديد التكاليف الضرورية والبحث عن بدائل أقل تكلفة.','حذف جميع الأنشطة دون مقارنة أهميتها.'], optionsEn:['Cancel immediately without discussing alternatives.','Exceed the budget without consulting anyone.','Identify essential costs and look for lower-cost alternatives.','Remove every activity without comparing its importance.'], correctIndex:2, categoryAr:'حل المشكلات', categoryEn:'Problem solving'),
  _Question(ar:'اشترى طالب 3 دفاتر، سعر الدفتر الواحد ديناران. كم دفع؟', en:'A student buys 3 notebooks at 2 dinars each. How much does he pay?', optionsAr:['5 دنانير','6 دنانير','8 دنانير','9 دنانير'], optionsEn:['5 dinars','6 dinars','8 dinars','9 dinars'], correctIndex:1, categoryAr:'الاستدلال الكمي', categoryEn:'Quantitative reasoning'),
  _Question(ar:'حصلت مدرسة على 80 كتابًا، ووزّعت 25% منها على مكتبة الصفوف. كم كتابًا وُزّع؟', en:'A school received 80 books and distributed 25% to classroom libraries. How many books were distributed?', optionsAr:['10','15','20','25'], optionsEn:['10','15','20','25'], correctIndex:2, categoryAr:'الاستدلال الكمي', categoryEn:'Quantitative reasoning'),
  _Question(ar:'سجّل فريق عدد النباتات التي زرعها خلال ثلاثة أيام: 4، ثم 7، ثم 9 نباتات. كم نباتًا زرع خلال الأيام الثلاثة؟', en:'A team planted 4 plants, then 7, then 9 over three days. How many plants did it plant in total?', optionsAr:['16','18','20','21'], optionsEn:['16','18','20','21'], correctIndex:1, categoryAr:'الاستدلال الكمي', categoryEn:'Quantitative reasoning'),
  _Question(ar:'قطعت حافلة 120 كيلومترًا خلال ساعتين بسرعة ثابتة. ما متوسط سرعتها؟', en:'A bus travels 120 kilometres in two hours at a constant speed. What is its average speed?', optionsAr:['40 كم/ساعة','50 كم/ساعة','60 كم/ساعة','80 كم/ساعة'], optionsEn:['40 km/h','50 km/h','60 km/h','80 km/h'], correctIndex:2, categoryAr:'الاستدلال الكمي', categoryEn:'Quantitative reasoning'),
  _Question(ar:'يبيّن الجدول عدد الكتب التي قرأها ثلاثة طلاب خلال شهر: ليان: 4 كتب؛ عمر: 7 كتب؛ نور: 5 كتب. كم يزيد عدد كتب عمر على عدد كتب ليان ونور معًا؟', en:'Three students read these books in a month: Layan 4, Omar 7, Noor 5. How many more books did Omar read than Layan and Noor combined?', optionsAr:['لا يزيد؛ بل يقل بكتابين.','يزيد بكتاب واحد.','يزيد بكتابين.','يزيد بثلاثة كتب.'], optionsEn:['He read 2 fewer books.','He read 1 more book.','He read 2 more books.','He read 3 more books.'], correctIndex:0, categoryAr:'الاستدلال الكمي', categoryEn:'Quantitative reasoning'),
  _Question(ar:'حصل طالب على العلامات التالية في أربعة اختبارات: 70، 80، 90، 80. ما متوسط العلامات؟', en:'A student scored 70, 80, 90, and 80 on four tests. What is the average?', optionsAr:['75','80','85','90'], optionsEn:['75','80','85','90'], correctIndex:1, categoryAr:'الاستدلال الكمي', categoryEn:'Quantitative reasoning'),
  _Question(ar:'أرادت طالبة معرفة ما إذا كان الضوء يؤثر في نمو النبات. ما الطريقة الأفضل للمقارنة؟', en:'A student wants to know whether light affects plant growth. What is the best way to compare?', optionsAr:['وضع نبات في الضوء وآخر في الظلام، مع محاولة إبقاء بقية الظروف متشابهة.','إعطاء النبات الأول ماءً أكثر وضوءًا أكثر من الثاني.','تغيير نوع التربة والضوء وكمية الماء في الوقت نفسه.','سؤال شخص عن النتيجة دون إجراء تجربة.'], optionsEn:['Place one plant in light and another in darkness while keeping other conditions similar.','Give the first plant more water and more light.','Change soil, light, and water all at once.','Ask someone for the result without experimenting.'], correctIndex:0, categoryAr:'التفكير العلمي', categoryEn:'Scientific reasoning'),
  _Question(ar:'لاحظ طالب أن الثلج يذوب أسرع في مكان دافئ منه في مكان بارد. أي تفسير تدعمه الملاحظة بصورة مباشرة؟', en:'A student observes that ice melts faster in a warm place than a cold place. Which conclusion is directly supported?', optionsAr:['جميع المواد تذوب بالطريقة نفسها.','درجة الحرارة لا تؤثر في الثلج.','الثلج يذوب أسرع في الظروف الدافئة التي اختُبرت.','كل الثلج يذوب في لحظة واحدة.'], optionsEn:['All materials melt in the same way.','Temperature does not affect ice.','Ice melted faster in the warm conditions tested.','All ice melts in one instant.'], correctIndex:2, categoryAr:'التفكير العلمي', categoryEn:'Scientific reasoning'),
  _Question(ar:'تريد طالبة اختبار ما إذا كان نوع الورق يؤثر في كمية الماء التي يمتصها. ما المتغير الذي ينبغي تغييره بين التجارب؟', en:'A student tests whether paper type affects how much water is absorbed. Which variable should change between trials?', optionsAr:['كمية الماء المستخدمة في كل تجربة.','نوع الورق.','مدة التجربة وكمية الماء ونوع الورق معًا.','طريقة قياس الماء في كل مرة.'], optionsEn:['The amount of water in each trial.','The type of paper.','The duration, water amount, and paper type all together.','The way water is measured each time.'], correctIndex:1, categoryAr:'التفكير العلمي', categoryEn:'Scientific reasoning'),
  _Question(ar:'قرأ طالب ادعاءً على الإنترنت بأن مشروبًا معينًا يحسّن الذاكرة فورًا. ما أفضل تصرف قبل تصديق الادعاء؟', en:'A student reads online that a drink instantly improves memory. What should he do before believing the claim?', optionsAr:['تصديقه لأنه منشور على الإنترنت.','مشاركته مع الجميع دون تحقق.','البحث عن أدلة موثوقة ودراسات مناسبة تدعم الادعاء.','اعتباره صحيحًا إذا أعجب أصدقاءه.'], optionsEn:['Believe it because it is online.','Share it with everyone without checking.','Look for reliable evidence and suitable studies supporting the claim.','Treat it as true if friends like it.'], correctIndex:2, categoryAr:'التفكير العلمي', categoryEn:'Scientific reasoning'),
  _Question(ar:'قاس فريق درجة حرارة الماء قبل وضعه في مكان مشمس وبعد فترة، فوجد أنها ارتفعت. ما المعلومات الإضافية التي تساعد على تفسير النتيجة بصورة أفضل؟', en:'A team measured water temperature before and after leaving it in sunlight and found it rose. What extra information would help explain the result?', optionsAr:['لون الدفتر الذي سُجلت فيه النتائج.','درجة حرارة الماء الابتدائية، ومدة التعرض، وظروف المقارنة.','أسماء الطلاب الذين شاهدوا التجربة فقط.','عدد الصفحات في تقرير التجربة.'], optionsEn:['The colour of the notebook used.','Initial water temperature, exposure duration, and comparison conditions.','Only the names of students who watched.','The number of pages in the report.'], correctIndex:1, categoryAr:'التفكير العلمي', categoryEn:'Scientific reasoning'),
  _Question(ar:'أجرى فريق تجربة مرتين وحصل على نتيجتين مختلفتين قليلًا. ما أفضل خطوة تالية؟', en:'A team repeats an experiment and gets two slightly different results. What should it do next?', optionsAr:['اختيار النتيجة التي تعجبه وإهمال الأخرى.','إخفاء إحدى النتيجتين.','مراجعة طريقة القياس والظروف وتكرار التجربة عند الحاجة.','استنتاج أن التجربة لا قيمة لها مباشرة.'], optionsEn:['Choose the result it likes and ignore the other.','Hide one of the results.','Review measurements and conditions, and repeat the experiment if needed.','Immediately conclude the experiment is worthless.'], correctIndex:2, categoryAr:'التفكير العلمي', categoryEn:'Scientific reasoning'),
  _Question(ar:'طلبت منك المدرسة اقتراح طريقة لتشجيع الطلاب على قراءة الكتب. أي اقتراح يجمع بين فكرة جديدة وإمكانية تطبيقها؟', en:'Your school asks for an idea to encourage reading. Which idea is both creative and practical?', optionsAr:['مطالبة الجميع بقراءة الكتاب نفسه دون نقاش.','إنشاء تحدٍّ يتيح للطلاب اختيار كتب مختلفة وتبادل توصيات قصيرة عنها.','إلغاء وقت القراءة.','وضع الكتب في مكان لا يستطيع الطلاب الوصول إليه.'], optionsEn:['Require everyone to read the same book without discussion.','Create a challenge where students choose different books and exchange short recommendations.','Cancel reading time.','Put books somewhere students cannot reach.'], correctIndex:1, categoryAr:'التفكير الإبداعي', categoryEn:'Creative thinking'),
  _Question(ar:'لديك صندوق كرتوني فارغ، والمطلوب التفكير في استخدامات مفيدة له. أي إجابة تُظهر تنوعًا أكبر في الأفكار؟', en:'You have an empty cardboard box and must think of useful ways to use it. Which answer shows the widest range of ideas?', optionsAr:['استخدامه للتخزين فقط.','استخدامه للزينة فقط.','تحويله إلى منظم للمكتب، أو مجسّم تعليمي، أو لعبة بسيطة.','التخلص منه مباشرة.'], optionsEn:['Use it only for storage.','Use it only for decoration.','Turn it into a desk organizer, learning model, or simple game.','Throw it away immediately.'], correctIndex:2, categoryAr:'التفكير الإبداعي', categoryEn:'Creative thinking'),
  _Question(ar:'تريد المدرسة تقليل هدر الماء. أي اقتراح يقدم طريقة مختلفة وعملية للتعامل مع المشكلة؟', en:'A school wants to reduce water waste. Which suggestion is a practical way to approach the problem?', optionsAr:['تجاهل المشكلة.','وضع ملصقات فقط دون متابعة.','رصد أماكن الهدر، ثم اقتراح حلول مناسبة وقياس أثرها.','منع استخدام الماء في المدرسة تمامًا.'], optionsEn:['Ignore the problem.','Put up posters without follow-up.','Identify where water is wasted, propose suitable solutions, and measure their impact.','Ban all water use at school.'], correctIndex:2, categoryAr:'التفكير الإبداعي', categoryEn:'Creative thinking'),
  _Question(ar:'لم يستطع فريقك تنفيذ نموذج مشروعه باستخدام المواد المتاحة. ما التصرف الذي يعكس مرونة في التفكير؟', en:'Your team cannot build its project model with the available materials. What shows flexible thinking?', optionsAr:['تكرار الخطة نفسها رغم عدم توفر المواد.','البحث عن مواد بديلة تحقق الوظيفة المطلوبة، ثم اختبارها.','التوقف عن التفكير في أي بديل.','افتراض أن المشروع مستحيل دون تجربة الخيارات.'], optionsEn:['Repeat the same plan despite missing materials.','Find substitute materials that serve the purpose and test them.','Stop considering alternatives.','Assume the project is impossible without trying options.'], correctIndex:1, categoryAr:'التفكير الإبداعي', categoryEn:'Creative thinking'),
  _Question(ar:'طُلب منك تقديم فكرة لشرح مفهوم علمي صعب لطلاب أصغر سنًا. أي خيار يتيح طريقة مختلفة للتوضيح؟', en:'You must explain a difficult science concept to younger students. Which option offers a different way to explain it?', optionsAr:['قراءة التعريف العلمي فقط دون أمثلة.','إعادة كتابة التعريف بخط أكبر.','استخدام نموذج أو تجربة آمنة أو قصة توضيحية تناسب المفهوم.','حذف المفهوم من الدرس.'], optionsEn:['Read only the definition without examples.','Rewrite the definition in larger letters.','Use a model, safe experiment, or suitable explanatory story.','Remove the concept from the lesson.'], correctIndex:2, categoryAr:'التفكير الإبداعي', categoryEn:'Creative thinking'),
  _Question(ar:'اقترح فريقك حلًا لمشكلة مدرسية، لكن فريقًا آخر اقترح حلًا مختلفًا. ما التصرف الذي يساعد على تطوير الفكرة؟', en:'Your team suggests a solution to a school problem, and another team suggests a different one. What helps improve the idea?', optionsAr:['رفض أي فكرة لم يقترحها فريقك.','مقارنة الحلول وفق معايير واضحة، ثم دمج العناصر المفيدة من كل حل عند ملاءمتها.','اختيار الحل الأطول دون تقييمه.','التوقف عن تطوير الفكرة بعد أول اقتراح.'], optionsEn:['Reject every idea your team did not suggest.','Compare solutions using clear criteria and combine useful elements when appropriate.','Choose the longest solution without evaluating it.','Stop developing the idea after the first suggestion.'], correctIndex:1, categoryAr:'التفكير الإبداعي', categoryEn:'Creative thinking'),
];

class AssessmentQuestionScreen extends StatefulWidget {
  final _TestInfo test;
  final bool isArabic;

  const AssessmentQuestionScreen({
    super.key,
    required this.test,
    required this.isArabic,
  });

  @override
  State<AssessmentQuestionScreen> createState() => _AssessmentQuestionScreenState();
}

class _AssessmentQuestionScreenState extends State<AssessmentQuestionScreen> {
  late final List<_Question> _questions;
  final Map<int, int> _answers = {};
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _questions = switch (widget.test.id) {
      'interests' => _interestQuestions(),
      'personality' => _personalityQuestions(),
      _ => _skillsQuestions(),
    };
  }

  void _next() {
    if (!_answers.containsKey(_index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.isArabic ? 'اختر إجابة للمتابعة.' : 'Select an answer to continue.')),
      );
      return;
    }
    if (_index < _questions.length - 1) {
      setState(() => _index++);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => _AssessmentResultScreen(
            test: widget.test,
            isArabic: widget.isArabic,
            questions: _questions,
            answers: Map<int, int>.from(_answers),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ar = widget.isArabic;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final q = _questions[_index];
    final likert = widget.test.id != 'skills';
    final options = likert ? (ar ? _likertAr : _likertEn) : (ar ? q.optionsAr : q.optionsEn);
    final progress = (_index + 1) / _questions.length;

    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF10121C) : const Color(0xFFF7F8FC),
        appBar: AppBar(
          title: Text(widget.test.title(ar)),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ar ? 'السؤال ${_index + 1} من ${_questions.length}' : 'Question ${_index + 1} of ${_questions.length}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text('${(progress * 100).round()}%',
                          style: const TextStyle(color: Color(0xFF4A6CF7), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: isDark ? Colors.white12 : Colors.black12,
                      valueColor: AlwaysStoppedAnimation(widget.test.color),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                children: [
                  if (!likert)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(ar ? q.categoryAr : q.categoryEn,
                          style: TextStyle(color: widget.test.color, fontWeight: FontWeight.bold)),
                    ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1B1E2B) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ar ? q.ar : q.en,
                      style: const TextStyle(fontSize: 18, height: 1.6, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 18),
                  for (int i = 0; i < options.length; i++) ...[
                    _AnswerOption(
                      label: options[i],
                      selected: _answers[_index] == i,
                      index: i,
                      isArabic: ar,
                      onTap: () => setState(() => _answers[_index] = i),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(
                  children: [
                    if (_index > 0) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setState(() => _index--),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text(ar ? 'السابق' : 'Previous'),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.test.color,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          _index == _questions.length - 1
                              ? (ar ? 'إنهاء الاختبار' : 'Finish assessment')
                              : (ar ? 'التالي' : 'Next'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final String label;
  final bool selected;
  final int index;
  final bool isArabic;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.label,
    required this.selected,
    required this.index,
    required this.isArabic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF4A6CF7).withOpacity(.12)
              : (isDark ? const Color(0xFF1B1E2B) : Colors.white),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected ? const Color(0xFF4A6CF7) : (isDark ? Colors.white12 : Colors.black12),
            width: selected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? const Color(0xFF4A6CF7) : Colors.transparent,
                border: Border.all(color: selected ? const Color(0xFF4A6CF7) : Colors.grey),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text('${index + 1}', style: const TextStyle(fontSize: 12)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(height: 1.4))),
          ],
        ),
      ),
    );
  }
}

class _AssessmentResultScreen extends StatelessWidget {
  final _TestInfo test;
  final bool isArabic;
  final List<_Question> questions;
  final Map<int, int> answers;

  const _AssessmentResultScreen({
    required this.test,
    required this.isArabic,
    required this.questions,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final ar = isArabic;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSkills = test.id == 'skills';
    final correct = isSkills
        ? questions.asMap().entries.where((e) => answers[e.key] == e.value.correctIndex).length
        : 0;
    final percent = isSkills ? (correct / questions.length * 100).round() : 0;
    final Map<String, List<int>> grouped = {};
    for (int i = 0; i < questions.length; i++) {
      final q = questions[i];
      final key = ar ? q.categoryAr : q.categoryEn;
      if (key.isNotEmpty) {
        grouped.putIfAbsent(key, () => []).add(answers[i] ?? 0);
      }
    }

    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF10121C) : const Color(0xFFF7F8FC),
        appBar: AppBar(
          title: Text(ar ? 'نتيجتك' : 'Your result'),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1B1E2B) : Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Icon(isSkills ? Icons.check_circle_outline : test.icon,
                      size: 58, color: test.color),
                  const SizedBox(height: 12),
                  Text(test.title(ar),
                      style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  if (isSkills) ...[
                    Text('$correct / ${questions.length}',
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: test.color)),
                    Text(ar ? 'إجابة صحيحة' : 'Correct answers'),
                    const SizedBox(height: 6),
                    Text('$percent%', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ] else
                    Text(
                      ar
                          ? 'اكتمل الاختبار. هذه ملخصات وصفية لإجاباتك وليست تشخيصًا أو حكمًا نهائيًا على شخصيتك أو مستقبلك.'
                          : 'Assessment complete. These are descriptive summaries of your responses, not a diagnosis or a definitive judgment about your personality or future.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(height: 1.55),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            if (!isSkills)
              for (final entry in grouped.entries) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1B1E2B) : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: entry.value.isEmpty ? 0 : entry.value.reduce((a, b) => a + b) / (entry.value.length * 4),
                          minHeight: 8,
                          backgroundColor: isDark ? Colors.white12 : Colors.black12,
                          valueColor: AlwaysStoppedAnimation(test.color),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        ar
                            ? 'متوسط التقييم: ${(entry.value.reduce((a, b) => a + b) / entry.value.length + 1).toStringAsFixed(1)} من 5'
                            : 'Average rating: ${(entry.value.reduce((a, b) => a + b) / entry.value.length + 1).toStringAsFixed(1)} out of 5',
                        style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            if (isSkills)
              Text(
                ar
                    ? 'النتيجة تعكس أداءك في هذه المجموعة من الأسئلة فقط. لا تمثل وحدها حكمًا نهائيًا على قدراتك أو المسار الدراسي الأنسب لك.'
                    : 'This score reflects your performance on this set of questions only. It is not, by itself, a definitive judgment of your abilities or best academic path.',
                style: TextStyle(height: 1.5, color: isDark ? Colors.white70 : Colors.black54),
              ),
            const SizedBox(height: 18),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A6CF7),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(ar ? 'العودة إلى الاختبارات' : 'Back to assessments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
